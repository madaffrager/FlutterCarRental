import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/models/client.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';

class ModifyClient extends StatefulWidget {
  final ClientModel client;
  final Locataire locataire;
  const ModifyClient({Key? key, required this.client, required this.locataire})
      : super(key: key);

  @override
  _ModifyClientState createState() => _ModifyClientState();
}

class _ModifyClientState extends State<ModifyClient>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.locataire.name;
    String dob = widget.locataire.dob;
    String cin = widget.locataire.cin;
    String permis = widget.locataire.permis;
    String datelivr = widget.locataire.datelivr;
    String passeport = widget.locataire.passeport;
    String adresse = widget.locataire.adresse;
    String mobile = widget.locataire.mobile;
    bool second = widget.locataire.second;
    String sname = widget.locataire.scin;
    String sdob = widget.locataire.sdob;
    String scin = widget.locataire.scin;
    String spermis = widget.locataire.spermis;
    String cacher = widget.locataire.cacher;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.black,
            controller: _tabController,
            isScrollable: true,
            tabs: [
              Tab(
                text: "Informations de client",
              ),
            ],
          ),
          backgroundColor: ksecondary,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
              )),
          title: Text(
            widget.client.agence.toUpperCase(),
            style: TextStyle(color: Colors.black, fontSize: size.width * 0.05),
          ),
          centerTitle: true,
          actions: [
            Image.asset(
              "assets/logo.png",
            ),
          ],
        ),
        body: TabBarView(controller: _tabController, children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: size.width * 0.8,
                    child: TextFormField(
                      initialValue: widget.locataire.name,
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
                      initialValue: widget.locataire.dob,
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
                      initialValue: widget.locataire.cin,
                      decoration: InputDecoration(labelText: "N° CIN"),
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
                      initialValue: widget.locataire.permis,
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
                      initialValue: widget.locataire.datelivr,
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
                      initialValue: widget.locataire.passeport,
                      decoration: InputDecoration(labelText: "N° de Passeport"),
                      onChanged: (value) {
                        setState(() {
                          passeport = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: TextFormField(
                      initialValue: widget.locataire.adresse,
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
                      initialValue: widget.locataire.mobile,
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
                                  initialValue: widget.locataire.sname,
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
                                  initialValue: widget.locataire.sdob,
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
                                  initialValue: widget.locataire.scin,
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
                                  initialValue: widget.locataire.spermis,
                                  decoration:
                                      InputDecoration(labelText: "N° Permis "),
                                  onChanged: (value) {
                                    setState(() {
                                      spermis = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
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
                              cin = passeport;
                            }
                            if (second) {
                              try {
                                FirebaseFirestore.instance
                                    .collection("clients")
                                    .doc(AuthProvider.sharedPreferences!
                                        .getString("id"))
                                    .collection("locataires")
                                    .doc("${widget.locataire.id}")
                                    .update({
                                  "id": widget.locataire.id,
                                  "name": name,
                                  "dob": dob,
                                  "cin": cin,
                                  "permis": permis,
                                  "delivered": datelivr,
                                  "passport": passeport,
                                  "adresse": adresse,
                                  "mobile": mobile,
                                  "second driver": second,
                                  "second_driver_name": sname,
                                  "second_driver_dob": sdob,
                                  "second_driver_cin": scin,
                                  "second_driver_permis": spermis,
                                  "cacher": cacher
                                });
                              } catch (e) {
                                print("error");
                              }
                            } else {
                              try {
                                FirebaseFirestore.instance
                                    .collection("clients")
                                    .doc(AuthProvider.sharedPreferences!
                                        .getString("id"))
                                    .collection("locataires")
                                    .doc("${widget.locataire.id}")
                                    .update({
                                  "id": widget.locataire.id,
                                  "name": name,
                                  "dob": dob,
                                  "cin": cin,
                                  "permis": permis,
                                  "delivered": datelivr,
                                  "passport": passeport,
                                  "adresse": adresse,
                                  "mobile": mobile,
                                  "second driver": second,
                                  "cacher": cacher
                                });
                              } catch (e) {
                                print(e.toString());
                              }
                            }
                          },
                          child: Text(
                            "Valider",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
  }

  Widget buildselection(String name) {
    double tsize = MediaQuery.of(context).size.width * 0.15;
    return Container(
      width: tsize,
      height: tsize,
      child: Card(
        color: Colors.amber,
        child: Image.asset(
          name,
          width: 70,
        ),
      ),
    );
  }
}
