import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfleet_project/home/contratdetail.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/locataires/clientpage.dart';
import 'package:myfleet_project/locataires/modifyclient.dart';
import 'package:myfleet_project/models/client.dart';
import 'package:myfleet_project/models/contrat.dart';
import 'package:myfleet_project/models/etat_vehicule.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';

class LocataireDetail extends StatefulWidget {
  final Locataire locataire;
  final ClientModel client;
  const LocataireDetail(
      {Key? key, required this.locataire, required this.client})
      : super(key: key);

  @override
  _LocataireDetailState createState() => _LocataireDetailState();
}

class _LocataireDetailState extends State<LocataireDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<String> contrats = ["garbagevalue"];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ksecondary,
          title: Text(
            widget.client.agence,
            style: TextStyle(color: Colors.black, fontSize: size.width * 0.05),
          ),
          centerTitle: true,
          actions: [
            Image.asset(
              "assets/logo.png",
              width: 100,
            ),
          ],
        ),
        body: ListView(padding: EdgeInsets.only(left: 20.0), children: <Widget>[
          SizedBox(height: 8.0),
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: Icon(Icons.menu_rounded),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: size.width * 0.07,
                      backgroundImage: AssetImage("assets/p.png"),
                      child: Text(""),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Container(
                          width: size.width * 0.09,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kprimary),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "N° CIN ${widget.locataire.cin}",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 20),
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       // FirebaseFirestore.instance
                      //       //     .collection('clients')
                      //       //     .doc(AuthProvider.sharedPreferences!
                      //       //         .getString('id'))
                      //       //     .collection('locataires')
                      //       //     .doc('${widget.locataire.id}')
                      //       //     .delete()
                      //       //     .then((value) {
                      //       //   deletecontrats(contrats);
                      //       //   return Navigator.pop(context);
                      //       // });
                      //     },
                      //     icon:
                      //     Icon(

                      //       Icons.delete,
                      //       size: 20,
                      //       color: Colors.red,
                      //     )
                      //     )
                    ]),
                Column(
                  children: [
                    Text(
                      "Informations du client :",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nom et prénom: '),
                          Text(widget.locataire.name.toString())
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Document d'identité:"),
                          Text(widget.locataire.cin)
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date de naissance: '),
                          Text(widget.locataire.dob)
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Permis N°: '),
                          Text(widget.locataire.permis)
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Adresse: '),
                          Text(widget.locataire.adresse)
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('N° mobile: '),
                          Text(widget.locataire.mobile)
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "2ème Conducteur déclaré :",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nom et prènom: '),
                          Container(
                              width: 150, child: Text(widget.locataire.sname))
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date de naissance: '),
                          Container(
                              width: 150, child: Text(widget.locataire.sdob))
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Document d'identité:"),
                          Container(
                              width: 150, child: Text(widget.locataire.scin))
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Permis N°: '),
                          Container(
                              width: 150, child: Text(widget.locataire.spermis))
                        ]),
                    SizedBox(height: 30),
                    Divider(
                      height: 5,
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Liste des contrats : ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 300,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('clients')
                              .doc(AuthProvider.sharedPreferences!
                                  .getString('id'))
                              .collection('contrat')
                              .where("cin", isEqualTo: widget.locataire.cin)
                              .snapshots(),
                          builder: (context, snapshot) {
                            return (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                ? Center(child: CircularProgressIndicator())
                                : snapshot.data!.docs.length == 0
                                    ? Container(
                                        child: Text(
                                            "Ce client n'a pas de contrat."))
                                    : ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var data = snapshot.data!.docs[index];
                                          contrats.add(data["id"].toString());
                                          bool assur = true;
                                          if (data["assurance"] == "T.R") {
                                            assur = false;
                                          }
                                          DateTime datedep =
                                              data["datedep"].toDate();
                                          DateTime datere =
                                              data["datere"].toDate();
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
                                              justificatifs:
                                                  data["justificatifs"],
                                              signature: data["signature"],
                                              kmdep: data["kmdep"],
                                              kmre: data["kmre"],
                                              datedep: datedep,
                                              datere: datere);
                                          Color color =
                                              Colors.green.withOpacity(0.5);
                                          String text = "Active ";
                                          if (contrat.type == "archive") {
                                            text = "Archivée ";
                                            color =
                                                Colors.grey.withOpacity(0.2);
                                          }
                                          if (contrat.type == "reservation") {
                                            text = "Réservée ";
                                            color =
                                                Colors.orange.withOpacity(0.7);
                                          }

                                          if (contrat.datedep
                                                  .isBefore(DateTime.now()) &&
                                              contrat.datere
                                                  .isAfter(DateTime.now())) {
                                            text = "Occupée ";
                                            color = Colors.red.withOpacity(0.7);
                                          }

                                          return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ContratDetail(
                                                              contrat: contrat,
                                                              etat: etat,
                                                              client:
                                                                  widget.client,
                                                            )));
                                              },
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 10,
                                                  ),
                                                  child: Container(
                                                      width: double.infinity,
                                                      child:
                                                          SingleChildScrollView(
                                                              child: Column(
                                                                  children: [
                                                            Card(
                                                                color: color,
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Text(text! +
                                                                          " " +
                                                                          contrat
                                                                              .id
                                                                              .toString()),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text("De " +
                                                                              DateFormat('dd-MM-yyyy').format(contrat.datedep)),
                                                                          Text("À " +
                                                                              DateFormat('dd-MM-yyyy').format(contrat.datere)),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                              "Client CIN :"),
                                                                          Text(contrat
                                                                              .cin),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ))
                                                          ])))));
                                        },
                                      );
                          }),
                    ),
                  ],
                ),
              ]))
        ]));
  }

  void deletecontrats(List<String> contrats) {
    for (int i = 1; i < contrats.length; i++) {
      FirebaseFirestore.instance
          .collection('clients')
          .doc(AuthProvider.sharedPreferences!.getString('id'))
          .collection('contrat')
          .doc(contrats[i])
          .delete();
      //TODO MSSH HTA LES DOSSIERS F STORAGE
    }
  }
}
