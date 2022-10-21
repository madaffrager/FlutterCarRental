import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfleet_project/contrat/chooseLocataire.dart';
import 'package:myfleet_project/contrat/reservation_sans.dart';
import 'package:myfleet_project/contrat/reservationcomplete.dart';
import 'package:myfleet_project/models/client.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/models/voiture.dart';
import 'package:myfleet_project/widgets/const.dart';
import 'package:myfleet_project/widgets/drawer.dart';

class Reservation extends StatefulWidget {
  final ClientModel client;
  final CarModel car;
  final bool reservation;
  const Reservation(
      {Key? key,
      required this.client,
      required this.car,
      required this.reservation})
      : super(key: key);

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  bool second = false;
  String name = "";
  String dob = "";
  String cin = "";
  String permis = "";
  String datelivr = "";
  String passport = "";
  String adresse = "";
  String mobile = "";
  String sname = "";
  String sdob = "";
  String scin = "";
  String spermis = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: BDrawer(client: widget.client),
      appBar: AppBar(
        leading: Text(""),
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
      body: ListView(children: [
        SizedBox(height: 10.0),
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
                radius: size.width * 0.07,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/p.png"),
              )
            ],
          ),
        ),
        Center(
          child: Text(
            "Informations du client",
            style: TextStyle(
                fontSize: size.width * 0.06, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Container(
              width: double.infinity,
              child: Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Nom et Prénom"),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration:
                          InputDecoration(labelText: "Date de Naissance"),
                      onChanged: (value) {
                        setState(() {
                          dob = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: "N° CIN / Passeport"),
                      onChanged: (value) {
                        setState(() {
                          cin = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "N° Permis"),
                      onChanged: (value) {
                        setState(() {
                          permis = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(labelText: "Délivrée Le"),
                      onChanged: (value) {
                        setState(() {
                          datelivr = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Adresse Postale"),
                      onChanged: (value) {
                        setState(() {
                          adresse = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(labelText: "N° de Tél."),
                      onChanged: (value) {
                        setState(() {
                          mobile = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        second
                            ? Text("2ème conducteur déclaré",
                                style: TextStyle(fontSize: 16))
                            : Text("Ajouter un 2ème conducteur",
                                style: TextStyle(fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              second = !second;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: kprimary,
                            child: second
                                ? Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  second
                      ? Container(
                          width: size.width * 0.8,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Nom et Prénom"),
                                  onChanged: (value) {
                                    setState(() {
                                      sname = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                      labelText: "Date de naissance"),
                                  onChanged: (value) {
                                    setState(() {
                                      sdob = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "N° CIN "),
                                  onChanged: (value) {
                                    setState(() {
                                      scin = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "N° Permis "),
                                  onChanged: (value) {
                                    setState(() {
                                      spermis = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: size.width * 0.4,
                    child: ClipRRect(
                      child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: kprimary,
                          onPressed: () {
                            if (cin.isEmpty) {
                              cin = passport;
                            }
                            if (cin.isNotEmpty) {
                              Locataire loc = new Locataire(
                                id: "${DateTime.now().millisecondsSinceEpoch}",
                                name: name,
                                dob: dob,
                                cin: cin,
                                permis: permis,
                                datelivr: datelivr,
                                passeport: passport,
                                adresse: adresse,
                                mobile: mobile,
                                second: second,
                              );

                              if (loc.second) {
                                loc.sname = sname;
                                loc.sdob = sdob;
                                loc.scin = scin;
                                loc.spermis = spermis;
                              }
                              if (widget.reservation) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ReservationSansContrat(
                                                client: widget.client,
                                                car: widget.car,
                                                locataire: loc)));
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CompleteReservation(
                                                client: widget.client,
                                                car: widget.car,
                                                locataire: loc,
                                                reservation:
                                                    widget.reservation)));
                              }
                            }
                          },
                          child: Text(
                            "Suivant",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                  )
                ],
              ))),
        ),
        SizedBox(height: 10.0),
      ]),
    );
  }
}
