import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfleet_project/contrat/extension.dart';
import 'package:myfleet_project/contrat/modifier_reservation.dart';
import 'package:myfleet_project/contrat/modifiercontrat.dart';
import 'package:myfleet_project/contrat/pdf_gen.dart';
import 'package:myfleet_project/contrat/reservationcomplete.dart';
import 'package:myfleet_project/home/contrat.page.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/models/client.dart';
import 'package:myfleet_project/models/contrat.dart';
import 'package:myfleet_project/models/etat_vehicule.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/models/voiture.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';
import 'package:myfleet_project/widgets/drawer.dart';

class ContratDetail extends StatefulWidget {
  final Contrat contrat;
  final EtatVehicule etat;
  final ClientModel client;

  const ContratDetail(
      {Key? key,
      required this.contrat,
      required this.etat,
      required this.client})
      : super(key: key);

  @override
  _ContratDetailState createState() => _ContratDetailState();
}

class _ContratDetailState extends State<ContratDetail> {
  String retour = "";

  CarModel? car;
  Locataire? locataire;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        drawer: BDrawer(client: widget.client),
        body: ListView(padding: EdgeInsets.only(left: 20.0), children: <Widget>[
          SizedBox(height: 8.0),
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                      widget.contrat.type == "reservation"
                          ? Text(
                              "Réservation N°${widget.contrat.id}",
                              style: TextStyle(fontSize: 18),
                            )
                          : Text(
                              "Contrat N°${widget.contrat.id}",
                              style: TextStyle(fontSize: 18),
                            ),
                      IconButton(
                          onPressed: () async {
                            if (widget.contrat.type == "active") {
                              print("before : " + car!.km);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Archivage de contrat'),
                                      content: TextField(
                                        autofocus: true,
                                        onChanged: (value) {
                                          setState(() {
                                            retour = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText:
                                                "Entrez le KM de retour:"),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () async {
                                              if (retour.isNotEmpty) {
                                                await deleteall();
                                                try {
                                                  FirebaseFirestore.instance
                                                      .collection('clients')
                                                      .doc(AuthProvider
                                                          .sharedPreferences!
                                                          .getString('id'))
                                                      .collection('contrat')
                                                      .doc(
                                                          '${widget.contrat!.id}')
                                                      .update({
                                                    "type": "archive",
                                                    "kmre": retour
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection('clients')
                                                      .doc(AuthProvider
                                                          .sharedPreferences!
                                                          .getString('id'))
                                                      .collection('garage')
                                                      .doc(car!.matricule)
                                                      .update({
                                                    "km": retour,
                                                  }).then((value) => Navigator
                                                          .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          HomePage())));
                                                } catch (e) {
                                                  print("error");
                                                }
                                              }
                                            },
                                            child: Text('Archiver')),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Annuler'),
                                        )
                                      ],
                                    );
                                  });
                            }
                            if (widget.contrat.type == "reservation") {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title:
                                          Text('Suppression de la réservation'),
                                      content: Text(
                                          'Voulez vous supprimer la réservation ?'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () async {
                                              try {
                                                FirebaseFirestore.instance
                                                    .collection('clients')
                                                    .doc(AuthProvider
                                                        .sharedPreferences!
                                                        .getString('id'))
                                                    .collection('contrat')
                                                    .doc(
                                                        '${widget.contrat!.id}')
                                                    .delete()
                                                    .then((value) {
                                                  FirebaseFirestore.instance
                                                      .collection('clients')
                                                      .doc(AuthProvider
                                                          .sharedPreferences!
                                                          .getString('id'))
                                                      .collection('locataires')
                                                      .doc(locataire!.id)
                                                      .delete();

                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage()));
                                                });
                                              } catch (e) {
                                                print("error");
                                              }
                                            },
                                            child: Text('Confirmer')),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Annuler'),
                                        )
                                      ],
                                    );
                                  });
                            }

                            // try {
                            //   FirebaseFirestore.instance
                            //       .collection('clients')
                            //       .doc(AuthProvider.sharedPreferences!
                            //           .getString('id'))
                            //       .collection('locataires')
                            //       .doc('${locataire!.id}')
                            //       .delete();
                            // } catch (e) {
                            //   print("error");
                            // }
                            // FirebaseFirestore.instance
                            //     .collection('clients')
                            //     .doc(AuthProvider.sharedPreferences!
                            //         .getString('id'))
                            //     .collection('contrat')
                            //     .doc('${widget.contrat.id}')
                            //     .delete()
                            //     .then((value) => Navigator.pushReplacement(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) => ContratPage(
                            //                 client: widget.client))));
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 20,
                            color: Colors.red,
                          ))
                    ]),
                Column(
                  children: [
                    Text(
                      "Informations du contrat",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ID: '),
                          Text(widget.contrat.id.toString())
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date de départ: '),
                          Text(DateFormat('dd-MM-yyyy')
                              .format(widget.contrat.datedep))
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date de retour: '),
                          Text(DateFormat('dd-MM-yyyy')
                              .format(widget.contrat.datere))
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Durée : '),
                          Text(widget.contrat.datere
                                  .difference(widget.contrat.datedep)
                                  .inDays
                                  .toString() +
                              " Jours.")
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Commentaire : '),
                          Container(
                              width: 150,
                              child: Text(widget.contrat.commentaire))
                        ]),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 200,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('clients')
                              .doc(AuthProvider.sharedPreferences!
                                  .getString('id'))
                              .collection('garage')
                              .where("matricule",
                                  isEqualTo: widget.contrat.matricule)
                              .snapshots(),
                          builder: (context, snapshot) {
                            return (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                ? Center(child: CircularProgressIndicator())
                                : ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var dataSnapshot =
                                          snapshot.data!.docs[index];
                                      car = new CarModel(
                                          photo: dataSnapshot["photo"],
                                          marque: dataSnapshot["marque"],
                                          modele: dataSnapshot["modele"],
                                          couleur: dataSnapshot["couleur"],
                                          matricule: dataSnapshot["matricule"],
                                          carburant: dataSnapshot["carburant"],
                                          km: dataSnapshot["km"],
                                          isfree: dataSnapshot["isfree"],
                                          prochainvidange:
                                              dataSnapshot["prochainvidange"]
                                                  .toString());

                                      return Container(
                                          width: size.width,
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                Hero(
                                                    tag: car!.matricule,
                                                    child: Image.network(
                                                        car!.photo,
                                                        height:
                                                            size.width * 0.4,
                                                        width: size.width * 0.4,
                                                        fit: BoxFit.contain)),
                                                Container(
                                                  width: size.width * 0.5,
                                                  decoration: BoxDecoration(
                                                      color: kprimary),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Marque : ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            car!.marque,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )
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
                                                          Text(
                                                            "Modèle : ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            car!.modele,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )
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
                                                          Text(
                                                            "Imm : ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            car!.matricule,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )
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
                                                          Text(
                                                            "Couleur : ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Container(
                                                            width: 12,
                                                            height: 12,
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                      width: 1),
                                                              color: Color(
                                                                  int.parse(car!
                                                                      .couleur)),
                                                            ),
                                                          )
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
                                                          Text(
                                                            "KM : ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            car!.km,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )
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
                                                          Text(
                                                            "P. Vidange : ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            car!.prochainvidange,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ]));
                                    },
                                  );
                          }),
                    ),
                    Container(
                      height: 300,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('clients')
                              .doc(AuthProvider.sharedPreferences!
                                  .getString('id'))
                              .collection('locataires')
                              .where("cin", isEqualTo: widget.contrat.cin)
                              .snapshots(),
                          builder: (context, snapshot) {
                            return (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                ? Center(child: CircularProgressIndicator())
                                : snapshot.data!.docs.length == 0
                                    ? Container(
                                        height: 5,
                                      )
                                    : ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          locataire = new Locataire(
                                            id: snapshot.data!.docs[index]
                                                .get("id"),
                                            name: snapshot.data!.docs[index]
                                                .get("name"),
                                            dob: snapshot.data!.docs[index]
                                                .get("dob"),
                                            cin: snapshot.data!.docs[index]
                                                .get("cin"),
                                            permis: snapshot.data!.docs[index]
                                                .get("permis"),
                                            datelivr: snapshot.data!.docs[index]
                                                .get("delivered"),
                                            passeport: snapshot
                                                .data!.docs[index]
                                                .get("passport"),
                                            adresse: snapshot.data!.docs[index]
                                                .get("adresse"),
                                            mobile: snapshot.data!.docs[index]
                                                .get("mobile"),
                                            second: snapshot.data!.docs[index]
                                                .get("second driver"),
                                          );
                                          locataire!.cacher = snapshot
                                              .data!.docs[index]
                                              .get("cacher");
                                          if (locataire!.second) {
                                            locataire!.sname = snapshot
                                                .data!.docs[index]
                                                .get("second_driver_name");
                                            locataire!.sdob = snapshot
                                                .data!.docs[index]
                                                .get("second_driver_dob");
                                            locataire!.scin = snapshot
                                                .data!.docs[index]
                                                .get("second_driver_cin");
                                            locataire!.spermis = snapshot
                                                .data!.docs[index]
                                                .get("second_driver_permis");
                                            if (locataire!.scin.isEmpty) {
                                              locataire!.scin =
                                                  locataire!.spermis;
                                            }
                                          }
                                          if (locataire!.cin.isEmpty) {
                                            locataire!.cin =
                                                locataire!.passeport;
                                          }

                                          return Column(children: [
                                            Text(
                                              "Informations du client",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Nom: '),
                                                  Text(locataire!.name)
                                                ]),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('CIN / N° Passepot: '),
                                                  Text(locataire!.cin)
                                                ]),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('N° Permis: '),
                                                  Text(locataire!.permis)
                                                ]),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Délivré le : '),
                                                  Text(locataire!.datelivr)
                                                ]),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Adresse : '),
                                                  Text(locataire!.adresse)
                                                ]),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('N° Mobile: '),
                                                  Text(locataire!.mobile)
                                                ]),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            locataire!.second
                                                ? Container(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "2ème conducteur déclaré",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('Nom: '),
                                                              Text(locataire!
                                                                  .sname)
                                                            ]),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  'Date de naissance : '),
                                                              Text(locataire!
                                                                  .sdob)
                                                            ]),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text('N° CIN : '),
                                                              Text(locataire!
                                                                  .scin)
                                                            ]),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  'N° Permis : '),
                                                              Text(locataire!
                                                                  .spermis)
                                                            ]),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                          ]);
                                        },
                                      );
                          }),
                    )
                  ],
                ),
                SizedBox(height: 30),
                widget.contrat.type == "active"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: size.width * 0.3,
                            child: ClipRRect(
                              child: FlatButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  color: ksecondary,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Extensioncalss(
                                                    contrat: widget.contrat,
                                                    client: widget.client)));
                                  },
                                  child: Text(
                                    "Ext.",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: size.width * 0.3,
                            child: ClipRRect(
                              child: FlatButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  color: kprimary,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PdfPage(
                                                clientModel: widget.client,
                                                car: car!,
                                                contrat: widget.contrat,
                                                locataire: locataire!)));
                                  },
                                  child: Text(
                                    "PDF.",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: size.width * 0.3,
                            child: ClipRRect(
                              child: FlatButton(
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  color: ksecondary,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ModifyContrat(
                                                client: widget.client,
                                                car: car!,
                                                locataire: locataire!,
                                                contrat: widget.contrat)));
                                  },
                                  child: Text(
                                    "Modifier",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )),
                            ),
                          ),
                        ],
                      )
                    : widget.contrat.type == "reservation"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: size.width * 0.3,
                                child: ClipRRect(
                                  child: FlatButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      color: ksecondary,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CompleteReservation(
                                                      client: widget.client,
                                                      car: car!,
                                                      locataire: locataire!,
                                                      reservation: false,
                                                      complete:
                                                          widget.contrat.id,
                                                    )));
                                      },
                                      child: Text(
                                        "Contrat",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      )),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                width: size.width * 0.3,
                                child: ClipRRect(
                                  child: FlatButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0)),
                                      color: kprimary,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ModifyReservation(
                                                        client: widget.client,
                                                        contrat:
                                                            widget.contrat)));
                                      },
                                      child: Text(
                                        "Modifier",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      )),
                                ),
                              ),
                            ],
                          )
                        : Container(),
              ]))
        ]));
  }

  Future<void> deleteall() async {
    try {
      if (widget.contrat.photos[0].toString().isNotEmpty)
        await FirebaseStorage.instance
            .ref()
            .child(
                "${widget.client.agence}/${widget.contrat.id}/etatphotos/${widget.contrat.matricule}.jpg")
            .delete();
      if (widget.contrat.photos[1].toString().isNotEmpty)
        await FirebaseStorage.instance
            .ref()
            .child(
                "${widget.client.agence}/${widget.contrat.id}/etatphotos/${widget.contrat.matricule}2.jpg")
            .delete();
      if (widget.contrat.photos[2].toString().isNotEmpty)
        await FirebaseStorage.instance
            .ref()
            .child(
                "${widget.client.agence}/${widget.contrat.id}/etatphotos/${widget.contrat.matricule}3.jpg")
            .delete();
      if (widget.contrat.justificatifs[0].toString().isNotEmpty)
        await FirebaseStorage.instance
            .ref()
            .child(
                "${widget.client.agence}/${widget.contrat.id}/justificatifs/${widget.contrat.cin}.jpg")
            .delete();
      if (widget.contrat.photos[1].toString().isNotEmpty)
        await FirebaseStorage.instance
            .ref()
            .child(
                "${widget.client.agence}/${widget.contrat.id}/justificatifs/${widget.contrat.cin}2.jpg")
            .delete();
      if (widget.contrat.photos[2].toString().isNotEmpty)
        await FirebaseStorage.instance
            .ref()
            .child(
                "${widget.client.agence}/${widget.contrat.id}/justificatifs/${widget.contrat.cin}3.jpg")
            .delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
