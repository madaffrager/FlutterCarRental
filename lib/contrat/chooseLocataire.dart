import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfleet_project/contrat/reservation_sans.dart';
import 'package:myfleet_project/contrat/reservationclass.dart';
import 'package:myfleet_project/contrat/reservationcomplete.dart';
import 'package:myfleet_project/garage/voiture_detail.dart';
import 'package:myfleet_project/models/client.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/models/voiture.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';

class ChooseLocataire extends StatefulWidget {
  final ClientModel client;
  final CarModel car;
  final bool reservation;
  const ChooseLocataire(
      {Key? key,
      required this.client,
      required this.car,
      required this.reservation})
      : super(key: key);

  @override
  _ChooseLocataireState createState() => _ChooseLocataireState();
}

class _ChooseLocataireState extends State<ChooseLocataire> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Locataire locataire;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VoitureDetail(
                            car: widget.car, client: widget.client)));
              },
              icon: Icon(Icons.arrow_back)),
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
        backgroundColor: Color(0xFFFCFAF8),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Reservation(
                          client: widget.client,
                          car: widget.car,
                          reservation: widget.reservation,
                        )));
          },
          label: Text("Ajouter un client"),
          backgroundColor: kprimary,
          icon: Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Selectionnez un client :",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
            ),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("clients")
                    .doc(AuthProvider.sharedPreferences!.getString("id"))
                    .collection("locataires")
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : snapshot.data!.docs.length == 0
                          ? noAdresscard()
                          : ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                locataire = new Locataire(
                                  id: snapshot.data!.docs[index].get("id"),
                                  name: snapshot.data!.docs[index].get("name"),
                                  dob: snapshot.data!.docs[index].get("dob"),
                                  cin: snapshot.data!.docs[index].get("cin"),
                                  permis:
                                      snapshot.data!.docs[index].get("permis"),
                                  datelivr: snapshot.data!.docs[index]
                                      .get("delivered"),
                                  passeport: snapshot.data!.docs[index]
                                      .get("passport"),
                                  adresse:
                                      snapshot.data!.docs[index].get("adresse"),
                                  mobile:
                                      snapshot.data!.docs[index].get("mobile"),
                                  second: snapshot.data!.docs[index]
                                      .get("second driver"),
                                );
                                locataire!.cacher =
                                    snapshot.data!.docs[index].get("cacher");
                                if (locataire!.second) {
                                  locataire!.sname = snapshot.data!.docs[index]
                                      .get("second_driver_name");
                                  locataire!.sdob = snapshot.data!.docs[index]
                                      .get("second_driver_dob");
                                  locataire!.scin = snapshot.data!.docs[index]
                                      .get("second_driver_cin");
                                  locataire!.spermis = snapshot
                                      .data!.docs[index]
                                      .get("second_driver_permis");
                                  if (locataire!.scin.isEmpty) {
                                    locataire!.scin = locataire!.spermis;
                                  }
                                }
                                if (locataire!.cin.isEmpty) {
                                  locataire!.cin = locataire!.passeport;
                                }

                                return AddressCard(
                                  locataire: locataire,
                                  car: widget.car,
                                  client: widget.client,
                                  reservation: widget.reservation,
                                );
                              },
                            );
                },
              ),
            )
          ],
        ));
  }

  noAdresscard() {
    return Card(
      color: kprimary,
      child: Container(
        height: 100,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: Colors.black,
            ),
            Text("Vous n'avez pas de clients."),
            Text("Ajoutez un client !"),
          ],
        ),
      ),
    );
  }
}

class AddressCard extends StatefulWidget {
  final Locataire locataire;
  final ClientModel client;
  final CarModel car;
  final bool reservation;
  const AddressCard({
    Key? key,
    required this.locataire,
    required this.client,
    required this.car,
    required this.reservation,
  }) : super(key: key);
  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Card(
        color: ksecondary,
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  groupValue: 1,
                  value: 1,
                  activeColor: kprimary,
                  onChanged: (val) {},
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: screenwidth * 0.8,
                      child: Table(
                        children: [
                          TableRow(children: [
                            KeyText(
                              msg: 'Nom',
                            ),
                            Text(widget.locataire.name),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: 'CIN',
                            ),
                            Text(widget.locataire.cin),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: 'Permis',
                            ),
                            Text(widget.locataire.permis),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: 'Adresse',
                            ),
                            Text(widget.locataire.adresse),
                          ]),
                          TableRow(children: [
                            KeyText(
                              msg: 'Numéro Mobile',
                            ),
                            Text(widget.locataire.mobile),
                          ]),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            1 == 1
                ? FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: kprimary,
                    onPressed: () {
                      if (widget.reservation) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReservationSansContrat(
                                      client: widget.client,
                                      car: widget.car,
                                      locataire: widget.locataire,
                                    )));
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompleteReservation(
                                      client: widget.client,
                                      car: widget.car,
                                      locataire: widget.locataire,
                                      reservation: widget.reservation,
                                    )));
                      }
                    },
                    child: Text(
                      "Continuer",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }
}

class KeyText extends StatelessWidget {
  final String msg;

  const KeyText({Key? key, required this.msg}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
