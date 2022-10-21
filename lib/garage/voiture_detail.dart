import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfleet_project/contrat/chooseLocataire.dart';
import 'package:myfleet_project/contrat/extension.dart';
import 'package:myfleet_project/contrat/modifier_reservation.dart';
import 'package:myfleet_project/contrat/modifiercontrat.dart';
import 'package:myfleet_project/contrat/reservationclass.dart';
import 'package:myfleet_project/garage/modifycar.dart';
import 'package:myfleet_project/home/contratdetail.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/models/client.dart';
import 'package:myfleet_project/models/contrat.dart';
import 'package:myfleet_project/models/etat_vehicule.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/models/voiture.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';
import 'package:myfleet_project/widgets/drawer.dart';

class VoitureDetail extends StatelessWidget {
  final ClientModel client;
  final CarModel car;
  const VoitureDetail({Key? key, required this.car, required this.client})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: BDrawer(client: client),
      appBar: AppBar(
        leading: Text(""),
        backgroundColor: ksecondary,
        title: Text(
          client.agence,
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
      body: ListView(children: [
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
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
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Container(
                  width: size.width * 0.09,
                  height: size.height * 0.05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: kprimary),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(car.marque + " " + car.modele,
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Padding(
                  padding: const EdgeInsets.only(left: 50, right: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ModifyCar(
                                      client: client,
                                      car: car,
                                    )));
                      },
                      icon: Icon(Icons.settings))),
            ],
          ),
        ),
        Center(
            child: car.isfree
                ? Text(
                    "Disponible",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  )
                : Text(
                    "Réservée",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  )),
        SizedBox(height: 10.0),
        car.isfree
            ? Container(
                child: Column(
                  children: [
                    Hero(
                        tag: car.matricule,
                        child: Image.network(car.photo,
                            height: 200.0, width: 200.0, fit: BoxFit.contain)),
                    SizedBox(height: 10.0),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, top: 5, bottom: 5, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Marque :",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Varela'),
                              ),
                              Text(
                                car.marque,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Varela',
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, top: 5, bottom: 5, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Genre :",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Varela'),
                              ),
                              Text(
                                car.modele,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Varela',
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, top: 5, bottom: 5, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Immatriculation :",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Varela'),
                              ),
                              Text(
                                car.matricule,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Varela',
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, top: 5, bottom: 5, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Couleur :",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Varela'),
                              ),
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  color: Color(int.parse(car.couleur)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, top: 5, bottom: 5, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Kilomètrage :",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Varela'),
                              ),
                              Text(
                                car.km + " km.",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Varela',
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, top: 5, bottom: 5, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Prochain vidange :",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Varela'),
                              ),
                              Text(
                                "${car.prochainvidange} km.",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Varela',
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.all(5),
                width: size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                            tag: car.matricule,
                            child: Image.network(car.photo,
                                height: 150.0,
                                width: 150.0,
                                fit: BoxFit.contain)),
                        Container(
                          width: size.width * 0.48,
                          decoration: BoxDecoration(color: ksecondary),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Marque : ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    car.marque,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Modèle : ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    car.modele,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Imm : ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    car.matricule,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Couleur : ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      color: Color(int.parse(car.couleur)),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "KM : ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    car.km,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "P. Vidange : ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    car.prochainvidange,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Reservation(
                                          client: client,
                                          car: car,
                                          reservation: true)));
                            },
                            icon: Icon(
                              Icons.add,
                            ))
                      ],
                    ),
                    Container(
                        width: size.width * 0.9,
                        height: 180 * 2,
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('clients')
                                .doc(AuthProvider.sharedPreferences!
                                    .getString('id'))
                                .collection('contrat')
                                .where("matricule", isEqualTo: car.matricule)
                                .snapshots(),
                            builder: (context, snapshot) {
                              return (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                  ? Center(child: CircularProgressIndicator())
                                  : snapshot.hasData
                                      ? snapshot.data!.docs.length == 0
                                          ? dosomething(context, car.matricule)

                                          // ? Container(
                                          //     child: Column(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment.center,
                                          //         children: [
                                          //           Text(
                                          //               "Vous n'avez pas de contrat!"),
                                          //           RaisedButton(
                                          //               onPressed: () {
                                          //                 dosomething(context,
                                          //                     car.matricule);
                                          //               },
                                          //               child: Text(
                                          //                   "Rendre la véhicule disponible ?"))
                                          //         ]),
                                          //   )
                                          : ListView.builder(
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                int i = index;
                                                if (snapshot.data!.docs[index]
                                                        .get("type") !=
                                                    "archive") {
                                                  Contrat contrat;
                                                  if (snapshot
                                                      .data!.docs.isEmpty) {}
                                                  DateTime datedep = snapshot
                                                      .data!.docs[index]
                                                      .get("datedep")
                                                      .toDate();
                                                  DateTime datere = snapshot
                                                      .data!.docs[index]
                                                      .get("datere")
                                                      .toDate();
                                                  bool assur = true;
                                                  if (snapshot.data!.docs[index]
                                                          .get("assurance") ==
                                                      "T.R") {
                                                    assur = false;
                                                  }
                                                  EtatVehicule etat = new EtatVehicule(
                                                      roue: snapshot.data!.docs[index]
                                                          .get("roue"),
                                                      disque: snapshot
                                                          .data!.docs[index]
                                                          .get("disque"),
                                                      jack: snapshot
                                                          .data!.docs[index]
                                                          .get("jack"),
                                                      fire: snapshot
                                                          .data!.docs[index]
                                                          .get("fire"),
                                                      spanner: snapshot
                                                          .data!.docs[index]
                                                          .get("spanner"),
                                                      triangle: snapshot
                                                          .data!.docs[index]
                                                          .get("triangle"),
                                                      light: snapshot.data!.docs[index].get("light"),
                                                      door: snapshot.data!.docs[index].get("door"),
                                                      dumper: snapshot.data!.docs[index].get("dumper"),
                                                      mirror: snapshot.data!.docs[index].get("mirror"),
                                                      seat: snapshot.data!.docs[index].get("seat"),
                                                      bonnet: snapshot.data!.docs[index].get("bonnet"),
                                                      stemware: snapshot.data!.docs[index].get("stemware"),
                                                      plus3: snapshot.data!.docs[index].get("plus3"),
                                                      plus4: snapshot.data!.docs[index].get("plus4"),
                                                      normal: assur);

                                                  contrat = new Contrat(
                                                      id: snapshot.data!.docs[index]
                                                          .get("id"),
                                                      cin: snapshot
                                                          .data!.docs[index]
                                                          .get("cin"),
                                                      name: snapshot
                                                          .data!.docs[index]
                                                          .get("name"),
                                                      type: snapshot
                                                          .data!.docs[index]
                                                          .get("type"),
                                                      matricule: snapshot
                                                          .data!.docs[index]
                                                          .get("matricule"),
                                                      etat: etat,
                                                      commentaire: snapshot
                                                          .data!.docs[index]
                                                          .get("commentaire"),
                                                      photos: snapshot.data!.docs[index].get("photos"),
                                                      justificatifs: snapshot.data!.docs[index].get("justificatifs"),
                                                      signature: snapshot.data!.docs[index].get("signature"),
                                                      kmdep: snapshot.data!.docs[index].get("kmdep"),
                                                      kmre: snapshot.data!.docs[index].get("kmre"),
                                                      datedep: datedep,
                                                      datere: datere);

                                                  Color color = Colors.green
                                                      .withOpacity(0.7);
                                                  ;
                                                  String text = "Active ";
                                                  if (contrat.type ==
                                                      "reservation") {
                                                    text = "Réservée ";
                                                    color = Colors.orange
                                                        .withOpacity(0.2);
                                                  }

                                                  if (contrat.type ==
                                                      "archive") {
                                                    text = "Archivée ";
                                                    color = Colors.grey
                                                        .withOpacity(0.2);
                                                  }
                                                  if (contrat.type ==
                                                          "active" &&
                                                      contrat.datedep.isBefore(
                                                          DateTime.now()) &&
                                                      contrat.datere.isAfter(
                                                          DateTime.now())) {
                                                    text = "Occupée ";
                                                    color = Colors.red
                                                        .withOpacity(0.7);
                                                  }

                                                  return Column(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 1.0)),
                                                        child: Column(
                                                          children: [
                                                            Text(text),
                                                            GestureDetector(
                                                              onTap: () {
                                                                // Navigator.push(
                                                                //     context,
                                                                //     MaterialPageRoute(
                                                                //         builder: (contex) => ContratDetail(
                                                                //             contrat:
                                                                //                 contrat,
                                                                //             etat:
                                                                //                 etat,
                                                                //             client:
                                                                //                 client)));
                                                              },
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => ContratDetail(
                                                                              contrat: contrat,
                                                                              etat: etat,
                                                                              client: client)));
                                                                },
                                                                child: Card(
                                                                  color: color,
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Text(snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                            .get("id")
                                                                            .toString()),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text("De " +
                                                                                DateFormat('dd-MM-yyyy').format(datedep)),
                                                                            Text("À " +
                                                                                DateFormat('dd-MM-yyyy').format(datere)),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text("Client CIN :"),
                                                                            Text(snapshot.data!.docs[index].get("cin")),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      contrat.type ==
                                                                              "reservation"
                                                                          ? Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => ContratDetail(contrat: contrat, etat: etat, client: client)))
                                                                          : Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => Extensioncalss(
                                                                                        contrat: contrat,
                                                                                        client: client,
                                                                                      )));
                                                                    },
                                                                    icon: Icon(
                                                                      contrat.type ==
                                                                              "reservation"
                                                                          ? Icons
                                                                              .picture_as_pdf
                                                                          : Icons
                                                                              .add,
                                                                      size: 20,
                                                                    )),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (contrat
                                                                              .type ==
                                                                          "reservation") {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => ModifyReservation(client: client, contrat: contrat)));
                                                                      } else {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => ContratDetail(contrat: contrat, etat: etat, client: client)));
                                                                      }
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      size: 20,
                                                                    ))
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      )
                                                    ],
                                                  );
                                                } else {
                                                  i = i + 1;
                                                  if (i ==
                                                      snapshot
                                                          .data!.docs.length) {
                                                    return dosomething(
                                                        context, car.matricule);

                                                    // Container(
                                                    //   child: Column(
                                                    //       mainAxisAlignment:
                                                    //           MainAxisAlignment
                                                    //               .center,
                                                    //       children: [
                                                    //         Text(
                                                    //             "Vous n'avez pas de contrat active !"),
                                                    //         RaisedButton(
                                                    //             onPressed: () {
                                                    //               dosomething(
                                                    //                   context,
                                                    //                   car.matricule);
                                                    //             },
                                                    //             child: Text(
                                                    //                 "Rendre la véhicule disponible ?"))
                                                    //       ]),
                                                    // );
                                                  } else {
                                                    return Container(
                                                      child: Text(""),
                                                    );
                                                  }
                                                }
                                              })
                                      : Container();
                            },
                          ),
                        )),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FlatButton(
                      color: ksecondary,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reservation(
                                    client: client,
                                    car: car,
                                    reservation: false)));
                      },
                      child: Text(
                        "Contrat",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FlatButton(
                      color: kprimary,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reservation(
                                    client: client,
                                    car: car,
                                    reservation: true)));
                      },
                      child: Text(
                        "Réserver",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  Widget dosomething(BuildContext context, String s) {
    FirebaseFirestore.instance
        .collection("clients")
        .doc(AuthProvider.sharedPreferences!.getString("id"))
        .collection("garage")
        .doc(s)
        .update({"isfree": true}).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
    return Container();
  }
}
