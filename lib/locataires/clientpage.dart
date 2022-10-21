import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfleet_project/locataires/clientdetail.dart';
import 'package:myfleet_project/models/client.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';

class ClientPage extends StatefulWidget {
  final ClientModel client;
  const ClientPage({Key? key, required this.client}) : super(key: key);

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  String name = "";
  Locataire? locataire;
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
          stream: (name != "" && name != null)
              ? FirebaseFirestore.instance
                  .collection('clients')
                  .doc(AuthProvider.sharedPreferences!.getString('id'))
                  .collection('locataires')
                  .where("cin", isEqualTo: name)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('clients')
                  .doc(AuthProvider.sharedPreferences!.getString('id'))
                  .collection('locataires')
                  .snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(child: CircularProgressIndicator())
                : snapshot.data!.docs.length == 0
                    ? Container(
                        color: Colors.white,
                        child: Center(child: Text("Pas de clients.")),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];
                          locataire = Locataire(
                              id: data["id"],
                              name: data["name"],
                              dob: data["dob"],
                              cin: data["cin"],
                              permis: data["permis"],
                              datelivr: data["delivered"],
                              passeport: data["passport"],
                              adresse: data["adresse"],
                              mobile: data["mobile"],
                              second: data["second driver"]);
                          locataire!.cacher = data["cacher"];
                          if (locataire!.second) {
                            locataire!.sname = data["second_driver_name"];
                            locataire!.scin = data["second_driver_cin"];
                            locataire!.sdob = data["second_driver_dob"];
                            locataire!.spermis = data["second_driver_permis"];
                          }

                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LocataireDetail(
                                              client: widget.client,
                                              locataire: locataire!,
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
                                            color:
                                                Colors.orange.withOpacity(0.3),
                                            margin: EdgeInsets.all(10),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Text(locataire!.cin
                                                      .toString()),
                                                  Text(locataire!.name),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Permis N° :"),
                                                      Text(locataire!.permis),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Déliveré le :"),
                                                      Text(locataire!.datelivr),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Client mobile :"),
                                                      Text(locataire!.mobile),
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
