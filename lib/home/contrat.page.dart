import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfleet_project/home/contratdetail.dart';
import 'package:myfleet_project/models/contrat.dart';
import 'package:myfleet_project/models/etat_vehicule.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';

class ContratPage extends StatefulWidget {
  final ClientModel client;
  const ContratPage({
    Key? key,
    required this.client,
  }) : super(key: key);

  @override
  _ContratPageState createState() => _ContratPageState();
}

class _ContratPageState extends State<ContratPage> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimary,
      appBar: AppBar(
        backgroundColor: kprimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Rechercher par N° CIN...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: StreamBuilder<QuerySnapshot>(
          stream: (name != "")
              ? FirebaseFirestore.instance
                  .collection('clients')
                  .doc(AuthProvider.sharedPreferences!.getString('id'))
                  .collection('contrat')
                  .where("cin", isGreaterThanOrEqualTo: name)
                  .orderBy('type', descending: true)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('clients')
                  .doc(AuthProvider.sharedPreferences!.getString('id'))
                  .collection('contrat')
                  .orderBy('type', descending: true)
                  .snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(child: CircularProgressIndicator())
                : snapshot.data!.docs.length == 0
                    ? Container(
                        color: Colors.white,
                        child: Center(
                          child: Text("Pas de contrats"),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];
                          bool assur = true;
                          if (data["assurance"] == "T.R") {
                            assur = false;
                          }
                          DateTime datedep = data["datedep"].toDate();
                          DateTime datere = data["datere"].toDate();
                          EtatVehicule etat = new EtatVehicule(
                              roue: data["roue"],
                              disque: data["disque"],
                              jack: data["jack"],
                              fire: data["fire"],
                              spanner: data["spanner"],
                              triangle: data["triangle"],
                              light: data["light"],
                              door: data["door"],
                              dumper: data["dumper"],
                              mirror: data["mirror"],
                              seat: data["seat"],
                              bonnet: data["bonnet"],
                              stemware: data["stemware"],
                              plus3: data["plus3"],
                              plus4: data["plus4"],
                              normal: assur);

                          Contrat contrat = new Contrat(
                            id: data["id"],
                            cin: data["cin"],
                            name: data["name"],
                            type: data["type"],
                            matricule: data["matricule"],
                            etat: etat,
                            commentaire: data["commentaire"],
                            photos: data["photos"],
                            justificatifs: data["justificatifs"],
                            signature: data["signature"],
                            kmdep: data["kmdep"],
                            kmre: data["kmre"],
                            datedep: datedep,
                            datere: datere,
                          );
                          Color color = Colors.green.withOpacity(0.7);
                          ;
                          String text = "Active ";
                          if (contrat.type == "reservation") {
                            text = "Réservée ";
                            color = Colors.orange.withOpacity(0.2);
                            return Container();
                          }

                          if (contrat.type == "archive") {
                            text = "Archivée ";
                            color = Colors.grey.withOpacity(0.2);
                          }
                          if (contrat.datedep.isBefore(DateTime.now()) &&
                              contrat.datere.isAfter(DateTime.now())) {
                            text = "Occupée ";
                            color = Colors.red.withOpacity(0.7);
                          }

                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContratDetail(
                                              contrat: contrat,
                                              etat: etat,
                                              client: widget.client,
                                            )));
                              },
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 10,
                                  ),
                                  child: Container(
                                      width: double.infinity,
                                      child: SingleChildScrollView(
                                          child: Column(children: [
                                        Card(
                                            color: color,
                                            margin: EdgeInsets.all(10),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Text(text! +
                                                      contrat.id.toString()),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("De " +
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(contrat
                                                                  .datedep)),
                                                      Text("À " +
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(contrat
                                                                  .datere)),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Client CIN :"),
                                                      Text(contrat.cin),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ))
                                      ])))));
                        },
                      );
          },
        ),
      ),
    );
  }
}
