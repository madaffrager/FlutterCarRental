import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfleet_project/home/contratdetail.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/models/client.dart';
import 'package:myfleet_project/models/contrat.dart';
import 'package:myfleet_project/models/etat_vehicule.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/models/voiture.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ModifyContrat extends StatefulWidget {
  final Contrat contrat;
  final ClientModel client;
  final CarModel car;
  final Locataire locataire;

  const ModifyContrat({
    Key? key,
    required this.client,
    required this.car,
    required this.contrat,
    required this.locataire,
  }) : super(key: key);

  @override
  _ModifyContratState createState() => _ModifyContratState();
}

class _ModifyContratState extends State<ModifyContrat>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  DateRangePickerController cont = DateRangePickerController();

  StepperType stepperType = StepperType.horizontal;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool button = false;
    return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Colors.black,
            controller: _tabController,
            isScrollable: true,
            tabs: [
              Tab(
                text: "Client",
              ),
              Tab(
                text: "Etat de Vehicule",
              ),
              Tab(
                text: "Contrat",
              ),
            ],
          ),
          backgroundColor: ksecondary,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
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
              width: 100,
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
                          widget.locataire.name = value;
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
                          widget.locataire.dob = value;
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
                          widget.locataire.cin = value;
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
                          widget.locataire.permis = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      initialValue: widget.locataire.datelivr,
                      decoration: InputDecoration(labelText: "Délivrée Le"),
                      onChanged: (value) {
                        setState(() {
                          widget.locataire.datelivr = value;
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
                          widget.locataire.passeport = value;
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
                          widget.locataire.adresse = value;
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
                          widget.locataire.mobile = value;
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
                        widget.locataire.second
                            ? Text("2ème conducteur déclaré",
                                style: TextStyle(fontSize: 16))
                            : Text("Ajouter un 2ème conducteur",
                                style: TextStyle(fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.locataire.second =
                                  !widget.locataire.second;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: kprimary,
                            child: widget.locataire.second
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
                  widget.locataire.second
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
                                      widget.locataire.sname = value;
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
                                      widget.locataire.sdob = value;
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
                                      widget.locataire.scin = value;
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
                                      widget.locataire.spermis = value;
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
                            if (widget.locataire.second) {
                              try {
                                FirebaseFirestore.instance
                                    .collection("clients")
                                    .doc(AuthProvider.sharedPreferences!
                                        .getString("id"))
                                    .collection("locataires")
                                    .doc("${widget.locataire.id}")
                                    .update({
                                  "id": widget.locataire.id,
                                  "name": widget.locataire.name,
                                  "dob": widget.locataire.dob,
                                  "cin": widget.locataire.cin,
                                  "permis": widget.locataire.permis,
                                  "delivered": widget.locataire.datelivr,
                                  "passport": widget.locataire.passeport,
                                  "adresse": widget.locataire.adresse,
                                  "mobile": widget.locataire.mobile,
                                  "second driver": widget.locataire.second,
                                  "second_driver_name": widget.locataire.sname,
                                  "second_driver_dob": widget.locataire.sdob,
                                  "second_driver_cin": widget.locataire.scin,
                                  "second_driver_permis":
                                      widget.locataire.spermis,
                                  "cacher": widget.locataire.cacher
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
                                    .set({
                                  "id": widget.locataire.id,
                                  "name": widget.locataire.name,
                                  "dob": widget.locataire.dob,
                                  "cin": widget.locataire.cin,
                                  "permis": widget.locataire.permis,
                                  "delivered": widget.locataire.datelivr,
                                  "passport": widget.locataire.passeport,
                                  "adresse": widget.locataire.adresse,
                                  "mobile": widget.locataire.mobile,
                                  "second driver": widget.locataire.second,
                                  "cacher": widget.locataire.cacher
                                });
                              } catch (e) {
                                print(e.toString());
                              }
                            }

                            setState(() {
                              button = true;
                            });
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
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.disque =
                                    !widget.contrat.etat.disque;
                              });
                            },
                            child: buildselection("assets/cd.png")),
                        widget.contrat.etat.disque
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.roue =
                                    !widget.contrat.etat.roue;
                              });
                            },
                            child: buildselection("assets/roue.png")),
                        widget.contrat.etat.roue
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.jack =
                                    !widget.contrat.etat.jack;
                              });
                            },
                            child: buildselection("assets/jack.png")),
                        widget.contrat.etat.jack
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.spanner =
                                    !widget.contrat.etat.spanner;
                              });
                            },
                            child: buildselection("assets/spanner.png")),
                        widget.contrat.etat.spanner
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.fire =
                                    !widget.contrat.etat.fire;
                              });
                            },
                            child: buildselection("assets/fire.png")),
                        widget.contrat.etat.fire
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.triangle =
                                    !widget.contrat.etat.triangle;
                              });
                            },
                            child: buildselection("assets/triangle.png")),
                        widget.contrat.etat.triangle
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.light =
                                    !widget.contrat.etat.light;
                              });
                            },
                            child: buildselection("assets/light.png")),
                        widget.contrat.etat.light
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.door =
                                    !widget.contrat.etat.door;
                              });
                            },
                            child: buildselection("assets/door.png")),
                        widget.contrat.etat.door
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.dumper =
                                    !widget.contrat.etat.dumper;
                              });
                            },
                            child: buildselection("assets/bumper.png")),
                        widget.contrat.etat.dumper
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.mirror =
                                    !widget.contrat.etat.mirror;
                              });
                            },
                            child: buildselection("assets/mirror.png")),
                        widget.contrat.etat.mirror
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.seat =
                                    !widget.contrat.etat.seat;
                              });
                            },
                            child: buildselection("assets/seat.png")),
                        widget.contrat.etat.seat
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.stemware =
                                    !widget.contrat.etat.stemware;
                              });
                            },
                            child: buildselection("assets/stemware.png")),
                        widget.contrat.etat.stemware
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.bonnet =
                                    !widget.contrat.etat.bonnet;
                              });
                            },
                            child: buildselection("assets/bonnet.png")),
                        widget.contrat.etat.bonnet
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.plus3 =
                                    !widget.contrat.etat.plus3;
                              });
                            },
                            child: buildselection("assets/plus3.png")),
                        widget.contrat.etat.plus3
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.contrat.etat.plus4 =
                                    !widget.contrat.etat.plus4;
                              });
                            },
                            child: buildselection("assets/plus4.png")),
                        widget.contrat.etat.plus4
                            ? Icon(
                                Icons.check_box,
                                size: 16,
                              )
                            : Icon(
                                Icons.check_box_outline_blank,
                                size: 16,
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    initialValue: widget.contrat.commentaire,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(new Radius.circular(10.0))),
                    ),
                    onChanged: (value) {
                      setState(() {
                        widget.contrat.commentaire = value;
                      });
                    },
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Assurance : ",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        "Normale ",
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              widget.contrat.etat.normal = true;
                            });
                          },
                          icon: widget.contrat.etat.normal
                              ? Icon(Icons.check_box)
                              : Icon(Icons.check_box_outline_blank)),
                      Text(
                        "T.R ",
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              widget.contrat.etat.normal = false;
                            });
                          },
                          icon: !widget.contrat.etat.normal
                              ? Icon(Icons.check_box)
                              : Icon(Icons.check_box_outline_blank))
                    ],
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
                            String assurance = "Normale";
                            if (!widget.contrat.etat.normal) {
                              assurance = "T.R";
                            }

                            try {
                              FirebaseFirestore.instance
                                  .collection("clients")
                                  .doc(AuthProvider.sharedPreferences!
                                      .getString("id"))
                                  .collection("contrat")
                                  .doc("${widget.contrat.id}")
                                  .update({
                                "commentaire": widget.contrat.commentaire,
                                "assurance": assurance,
                                "roue": widget.contrat.etat.roue,
                                "disque": widget.contrat.etat.disque,
                                "jack": widget.contrat.etat.jack,
                                "fire": widget.contrat.etat.fire,
                                "spanner": widget.contrat.etat.spanner,
                                "triangle": widget.contrat.etat.triangle,
                                "light": widget.contrat.etat.light,
                                "door": widget.contrat.etat.door,
                                "dumper": widget.contrat.etat.dumper,
                                "mirror": widget.contrat.etat.mirror,
                                "seat": widget.contrat.etat.seat,
                                "bonnet": widget.contrat.etat.bonnet,
                                "stemware": widget.contrat.etat.stemware,
                                "plus3": widget.contrat.etat.plus3,
                                "plus4": widget.contrat.etat.plus4
                              });
                            } catch (e) {
                              print(e.toString());
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
          SingleChildScrollView(
              child: Container(
            child: Column(
              children: [
                Container(
                  width: 150,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: widget.contrat.kmdep,
                    decoration: InputDecoration(labelText: "KM départ"),
                    onChanged: (value) {
                      setState(() {
                        widget.contrat.kmdep = value;
                      });
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: widget.contrat.kmre,
                    decoration: InputDecoration(labelText: "KM retour"),
                    onChanged: (value) {
                      setState(() {
                        widget.contrat.kmre = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: Text(
                    "Date de réservation :",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SfDateRangePicker(
                      view: DateRangePickerView.month,
                      showActionButtons: true,
                      selectionMode: DateRangePickerSelectionMode.range,
                      initialSelectedRange: PickerDateRange(
                          widget.contrat.datedep, widget.contrat.datere),
                      onSubmit: (Object val) {
                        setState(() {
                          if (val is PickerDateRange) {
                            widget.contrat.datedep = val.startDate!;
                            widget.contrat.datere = val.endDate!;
                          }
                        });
                      },
                      onCancel: () {
                        cont.selectedRanges = null;
                      },
                    )),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: size.width * 0.4,
                  child: ClipRRect(
                    child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: kprimary,
                        onPressed: () {
                          try {
                            FirebaseFirestore.instance
                                .collection("clients")
                                .doc(AuthProvider.sharedPreferences!
                                    .getString("id"))
                                .collection("contrat")
                                .doc("${widget.contrat.id}")
                                .update({
                              "datedep": widget.contrat.datedep,
                              "datere": widget.contrat.datere,
                              "kmdep": widget.contrat.kmdep,
                              "kmre": widget.contrat.kmre,
                            });
                          } catch (e) {
                            print(e.toString());
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
          ))
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
