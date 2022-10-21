import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image/image.dart' as encoder;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myfleet_project/contrat/chooseLocataire.dart';
import 'package:myfleet_project/contrat/pdf_gen.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/models/client.dart';
import 'package:myfleet_project/models/contrat.dart';
import 'package:myfleet_project/models/etat_vehicule.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/models/voiture.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';
import 'package:myfleet_project/widgets/drawer.dart';
import 'package:signature/signature.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CompleteReservation extends StatefulWidget {
  final ClientModel client;
  final CarModel car;
  final Locataire locataire;
  final bool reservation;
  final int? complete;
  const CompleteReservation(
      {Key? key,
      required this.client,
      required this.car,
      required this.locataire,
      required this.reservation,
      this.complete})
      : super(key: key);

  @override
  _CompleteReservationState createState() => _CompleteReservationState();
}

class _CompleteReservationState extends State<CompleteReservation> {
  bool roue = true;
  bool button = true;
  File? image, image2, image3;
  bool disque = true;
  bool jack = true;
  bool fire = true;
  bool spanner = true;
  bool triangle = true;
  bool light = true;
  bool door = true;
  bool dumper = true;
  bool mirror = true;
  bool seat = true;
  bool bonnet = true;
  bool stemware = true;
  bool plus3 = true;
  int uid = DateTime.now().millisecondsSinceEpoch;
  bool plus4 = true;
  bool normal = true;
  String commentaire = "";
  String assurance = "";
  String kmdep = "";
  String kmre = "";
  DateTime? datedep;
  DateTime? datere;
  File? justificatif, justificatif2, justificatif3;
  int i = 0;
  int j = 1;
  int k = 2;
  List photos = ["", "", ""];
  List justificatifs = ["", "", ""];
  DateRangePickerController cont = DateRangePickerController();
  final SignatureController _controller = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      onDrawStart: () => print('onDrawStart called!'),
      onDrawEnd: () => print('onDrawEnd called!'),
      exportBackgroundColor: Colors.white);
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
        body: SingleChildScrollView(
          child: Form(
            child: Column(children: [
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage())),
                        icon: Icon(Icons.arrow_back),
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
              Center(
                child: Text(
                  "ETAT DE VEHICULE",
                  style: TextStyle(
                      fontSize: size.width * 0.06, fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Client : ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    widget.locataire.name.toUpperCase(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            disque = !disque;
                          });
                        },
                        child: buildselection("assets/cd.png")),
                    disque
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
                            roue = !roue;
                          });
                        },
                        child: buildselection("assets/roue.png")),
                    roue
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
                            jack = !jack;
                          });
                        },
                        child: buildselection("assets/jack.png")),
                    jack
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
                            spanner = !spanner;
                          });
                        },
                        child: buildselection("assets/spanner.png")),
                    spanner
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
                            fire = !fire;
                          });
                        },
                        child: buildselection("assets/fire.png")),
                    fire
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
                            triangle = !triangle;
                          });
                        },
                        child: buildselection("assets/triangle.png")),
                    triangle
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
                            light = !light;
                          });
                        },
                        child: buildselection("assets/light.png")),
                    light
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
                            door = !door;
                          });
                        },
                        child: buildselection("assets/door.png")),
                    door
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
                            dumper = !dumper;
                          });
                        },
                        child: buildselection("assets/bumper.png")),
                    dumper
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
                            mirror = !mirror;
                          });
                        },
                        child: buildselection("assets/mirror.png")),
                    mirror
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
                            seat = !seat;
                          });
                        },
                        child: buildselection("assets/seat.png")),
                    seat
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
                            stemware = !stemware;
                          });
                        },
                        child: buildselection("assets/stemware.png")),
                    stemware
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
                            bonnet = !bonnet;
                          });
                        },
                        child: buildselection("assets/bonnet.png")),
                    bonnet
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
                            plus3 = !plus3;
                          });
                        },
                        child: buildselection("assets/plus3.png")),
                    plus3
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
                            plus4 = !plus4;
                          });
                        },
                        child: buildselection("assets/plus4.png")),
                    plus4
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    image == null
                        ? GestureDetector(
                            onTap: () {
                              chooseFile(i);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera,
                                  color: Colors.black54,
                                ),
                                Text(" Ajouter des images",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54)),
                                image != null
                                    ? Image.file(
                                        image!,
                                        width: 40,
                                      )
                                    : Container(),
                              ],
                            ))
                        : Row(
                            children: [
                              Image.file(
                                image!,
                                width: 40,
                              ),
                              IconButton(
                                  onPressed: () {
                                    clearSelection(i);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                  )),
                              image2 == null
                                  ? IconButton(
                                      onPressed: () {
                                        chooseFile(j);
                                      },
                                      icon: Icon(Icons.add_a_photo))
                                  : Row(
                                      children: [
                                        Image.file(
                                          image2!,
                                          width: 40,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              clearSelection(j);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                            )),
                                        image3 == null
                                            ? IconButton(
                                                onPressed: () {
                                                  chooseFile(k);
                                                },
                                                icon: Icon(Icons.add_a_photo))
                                            : Row(
                                                children: [
                                                  Image.file(
                                                    image3!,
                                                    width: 40,
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        clearSelection(k);
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                      )),
                                                ],
                                              )
                                      ],
                                    )
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Ajouter un commentaire",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(new Radius.circular(10.0))),
                      ),
                      onChanged: (value) {
                        setState(() {
                          commentaire = value;
                        });
                      },
                    ),
                  ],
                ),
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
                          normal = true;
                        });
                      },
                      icon: normal
                          ? Icon(Icons.check_box)
                          : Icon(Icons.check_box_outline_blank)),
                  Text(
                    "T.R ",
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          normal = false;
                        });
                      },
                      icon: !normal
                          ? Icon(Icons.check_box)
                          : Icon(Icons.check_box_outline_blank))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "KM départ",
                            hintText: widget.car.km + " KM"),
                        onChanged: (value) {
                          setState(() {
                            normal ? assurance = "normal" : assurance = "T.R";
                            kmdep = value;
                          });
                        },
                      ),
                    ),
                    // Container(
                    //   width: 150,
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.number,
                    //     decoration: InputDecoration(labelText: "KM retour"),
                    //     onChanged: (value) {
                    //       setState(() {
                    //         kmre = value;
                    //       });
                    //     },
                    //   ),
                    // ),
                  ],
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
                height: 50,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SfDateRangePicker(
                    view: DateRangePickerView.month,
                    showActionButtons: true,
                    selectionMode: DateRangePickerSelectionMode.range,
                    cancelText: "Annuler",
                    confirmText: "Confirmer",
                    onSubmit: (Object val) {
                      setState(() {
                        if (val is PickerDateRange) {
                          datedep = val.startDate;
                          datere = val.endDate;
                        }
                      });
                    },
                    onCancel: () {
                      cont.selectedRanges = null;
                    },
                  )),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    justificatif == null
                        ? GestureDetector(
                            onTap: () {
                              chooseAttached(i);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_file,
                                  color: Colors.black54,
                                ),
                                Text(" Ajouter des justificatifs",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54)),
                                justificatif != null
                                    ? Image.file(
                                        justificatif!,
                                        width: 40,
                                      )
                                    : Container(),
                              ],
                            ))
                        : Row(
                            children: [
                              Image.file(
                                justificatif!,
                                width: 40,
                              ),
                              IconButton(
                                  onPressed: () {
                                    clearSelectiona(i);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                  )),
                              justificatif2 == null
                                  ? IconButton(
                                      onPressed: () {
                                        chooseAttached(j);
                                      },
                                      icon: Icon(Icons.add_a_photo))
                                  : Row(
                                      children: [
                                        Image.file(
                                          justificatif2!,
                                          width: 40,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              clearSelectiona(j);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                            )),
                                        justificatif3 == null
                                            ? IconButton(
                                                onPressed: () {
                                                  chooseAttached(k);
                                                },
                                                icon: Icon(Icons.add_a_photo))
                                            : Row(
                                                children: [
                                                  Image.file(
                                                    justificatif3!,
                                                    width: 40,
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        clearSelectiona(k);
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                      )),
                                                ],
                                              )
                                      ],
                                    )
                            ],
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Signature Client :",
                            style: TextStyle(fontSize: 16),
                          ),
                        ]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Signature(
                        controller: _controller,
                        height: 300,
                        width: size.width * 0.8,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() => _controller.clear());
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: size.width * 0.4,
                    child: ClipRRect(
                      child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: button ? kprimary : ksecondary,
                          onPressed: () async {
                            setState(() {
                              button = false;
                            });
                            if (image != null) {
                              uploadImageToFirebase(image!,
                                  "${widget.car.matricule}.jpg", false, 0);
                            }
                            if (image2 != null) {
                              uploadImageToFirebase(image2!,
                                  "${widget.car.matricule}2.jpg", false, 1);
                            }
                            if (image3 != null) {
                              uploadImageToFirebase(image3!,
                                  "${widget.car.matricule}3.jpg", false, 2);
                            }

                            if (justificatif != null) {
                              uploadImageToFirebase(justificatif!,
                                  "${widget.locataire.cin}.jpg", true, 0);
                            }
                            if (justificatif2 != null) {
                              uploadImageToFirebase(justificatif2!,
                                  "${widget.locataire.cin}2.jpg", true, 1);
                            }
                            if (justificatif3 != null) {
                              uploadImageToFirebase(justificatif3!,
                                  "${widget.locataire.cin}3.jpg", true, 2);
                            }

                            if (_controller.isNotEmpty) {
                              var image = await _controller.toImage();

                              //Store image dimensions for later
                              int height = image!.height;
                              int width = image.width;

                              ByteData? data = await image.toByteData();
                              Uint8List listData = data!.buffer.asUint8List();

                              encoder.Image toEncodeImage =
                                  encoder.Image.fromBytes(
                                      width, height, listData);
                              encoder.JpegEncoder jpgEncoder =
                                  encoder.JpegEncoder();

                              List<int> encodedImage =
                                  jpgEncoder.encodeImage(toEncodeImage);

                              uploadDataToFirebase(
                                  Uint8List.fromList(encodedImage));
                            }
                            EtatVehicule etatVehicule = new EtatVehicule(
                                roue: roue,
                                disque: disque,
                                jack: jack,
                                fire: fire,
                                spanner: spanner,
                                triangle: triangle,
                                light: light,
                                door: door,
                                dumper: dumper,
                                mirror: mirror,
                                seat: seat,
                                bonnet: bonnet,
                                stemware: stemware,
                                plus3: plus3,
                                plus4: plus4,
                                normal: normal);

                            Contrat contrat = new Contrat(
                                id: uid,
                                cin: widget.locataire.cin,
                                name: widget.locataire.name,
                                type: "active",
                                matricule: widget.car.matricule,
                                etat: etatVehicule,
                                commentaire: commentaire,
                                photos: photos.toList(),
                                justificatifs: justificatifs.toList(),
                                signature: widget.locataire.cacher,
                                kmdep: kmdep,
                                kmre: kmre,
                                datedep: datedep!,
                                datere: datere!);
                            if (widget.complete != null) {
                              contrat.id = widget.complete!;
                            }
                            saveUserContratToFireStore(contrat);
                          },
                          child: Text(
                            "Sauvegarder ",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: size.width * 0.4,
                    child: ClipRRect(
                      child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: kprimary,
                          onPressed: () async {
                            if (image != null) {
                              uploadImageToFirebase(image!,
                                  "${widget.car.matricule}.jpg", false, 0);
                            }
                            if (image2 != null) {
                              uploadImageToFirebase(image2!,
                                  "${widget.car.matricule}2.jpg", false, 1);
                            }
                            if (image3 != null) {
                              uploadImageToFirebase(image3!,
                                  "${widget.car.matricule}3.jpg", false, 2);
                            }

                            if (justificatif != null) {
                              uploadImageToFirebase(justificatif!,
                                  "${widget.locataire.cin}.jpg", true, 0);
                            }
                            if (justificatif2 != null) {
                              uploadImageToFirebase(justificatif2!,
                                  "${widget.locataire.cin}2.jpg", true, 1);
                            }
                            if (justificatif3 != null) {
                              uploadImageToFirebase(justificatif3!,
                                  "${widget.locataire.cin}3.jpg", true, 2);
                            }
                            EtatVehicule etatVehicule = new EtatVehicule(
                                roue: roue,
                                disque: disque,
                                jack: jack,
                                fire: fire,
                                spanner: spanner,
                                triangle: triangle,
                                light: light,
                                door: door,
                                dumper: dumper,
                                mirror: mirror,
                                seat: seat,
                                bonnet: bonnet,
                                stemware: stemware,
                                plus3: plus3,
                                plus4: plus4,
                                normal: normal);

                            Contrat contrat = new Contrat(
                                id: uid,
                                cin: widget.locataire.cin,
                                name: widget.locataire.name,
                                type: "active",
                                matricule: widget.car.matricule,
                                etat: etatVehicule,
                                commentaire: commentaire,
                                photos: photos.toList(),
                                justificatifs: justificatifs.toList(),
                                signature: widget.locataire.cacher,
                                kmdep: kmdep,
                                kmre: kmre,
                                datedep: datedep!,
                                datere: datere!);
                            if (widget.complete != null) {
                              contrat.id = widget.complete!;
                            }

                            saveUserContratToFireStore(contrat);
                            if (!button) {
                              delay(contrat);
                            }
                          },
                          child: Text(
                            "Valider",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ));
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

  Future<void> delay(Contrat contrat) async {
    await new Future.delayed(new Duration(milliseconds: 8000), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PdfPage(
                clientModel: widget.client,
                car: widget.car,
                locataire: widget.locataire,
                contrat: contrat,
              )));
    });
  }

  saveUserContratToFireStore(Contrat contrat) {
    String assur = "";
    if (contrat.etat.normal) {
      assur = "Normale";
    } else {
      assur = "T.R";
    }
    FirebaseFirestore.instance
        .collection("clients")
        .doc(AuthProvider.sharedPreferences!.getString("id"))
        .collection("contrat")
        .doc(contrat.id.toString())
        .set({
      "id": contrat.id,
      "cin": contrat.cin,
      "name": widget.locataire.name,
      "type": "active",
      "matricule": contrat.matricule,
      "photos": photos.toList(),
      "commentaire": contrat.commentaire,
      "assurance": assur,
      "justificatifs": justificatifs.toList(),
      "datedep": contrat.datedep,
      "datere": contrat.datere,
      "kmdep": contrat.kmdep,
      "kmre": contrat.kmre,
      "signature": contrat.signature,
      "roue": roue,
      "disque": disque,
      "jack": jack,
      "fire": fire,
      "spanner": spanner,
      "triangle": triangle,
      "light": light,
      "door": door,
      "dumper": dumper,
      "mirror": mirror,
      "seat": seat,
      "bonnet": bonnet,
      "stemware": stemware,
      "plus3": plus3,
      "plus4": plus4,
    });
    FirebaseFirestore.instance
        .collection("clients")
        .doc(AuthProvider.sharedPreferences!.getString("id"))
        .collection("garage")
        .doc(contrat.matricule)
        .update({"isfree": false, "km": kmdep});
  }

  Future uploadImageToFirebase(
      File image, String name, bool justi, int i) async {
    ;
    switch (justi) {
      case true:
        try {
          firebase_storage.Reference firebaseStorageRef = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('${widget.client.agence}/$uid/justificatifs/$name');
          firebase_storage.UploadTask uploadTask =
              firebaseStorageRef.putFile(image);
          firebase_storage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          taskSnapshot.ref.getDownloadURL().then(
            (value) {
              setState(() {
                justificatifs[i] = value;
                print("justificatif " + justificatifs[i]);
              });
            },
          );
        } catch (e) {}
        break;
      case false:
        try {
          firebase_storage.Reference firebaseStorageRef = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('${widget.client.agence}/$uid/etatphotos/$name');
          firebase_storage.UploadTask uploadTask =
              firebaseStorageRef.putFile(image);
          firebase_storage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          taskSnapshot.ref.getDownloadURL().then(
            (value) {
              setState(() {
                photos[i] = value;
                print("etat voiture" + photos[i]);
              });
            },
          );
        } catch (e) {
          print("error uploading " + " " + name + justificatifs[i]);
        }
        break;
    }
  }

  saveUserInfoToFireStore() {
    widget.locataire.second
        ? FirebaseFirestore.instance
            .collection("clients")
            .doc(AuthProvider.sharedPreferences!.getString("id"))
            .collection("locataires")
            .doc(widget.locataire.id)
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
            "second_driver_name": widget.locataire.sname,
            "second_driver_dob": widget.locataire.sdob,
            "second_driver_cin": widget.locataire.scin,
            "second_driver_permis": widget.locataire.spermis,
            "cacher": widget.locataire.cacher
          })
        : FirebaseFirestore.instance
            .collection("clients")
            .doc(AuthProvider.sharedPreferences!.getString("id"))
            .collection("locataires")
            .doc(widget.locataire.id)
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
  }

  void clearSelectiona(int i) {
    switch (i) {
      case 0:
        if (justificatif2 != null) {
          if (justificatif3 != null) {
            setState(() {
              justificatif = justificatif2;
              justificatif2 = justificatif3;
              justificatif3 = null;
            });
          } else {
            setState(() {
              justificatif = justificatif2;
              justificatif2 = null;
            });
          }
        } else {
          setState(() {
            justificatif = null;
          });
        }

        break;
      case 1:
        if (justificatif3 != null) {
          setState(() {
            justificatif2 = justificatif3;
            justificatif3 = null;
          });
        } else {
          setState(() {
            justificatif2 = null;
          });
        }
        break;
      case 2:
        setState(() {
          justificatif3 = null;
        });
        break;
    }
  }

  void clearSelection(int i) {
    switch (i) {
      case 0:
        if (image2 != null) {
          if (image3 != null) {
            setState(() {
              image = image2;
              image2 = image3;
              image3 = null;
            });
          } else {
            setState(() {
              image = image2;
              image2 = null;
            });
          }
        } else {
          setState(() {
            image = null;
          });
        }

        break;
      case 1:
        if (image3 != null) {
          setState(() {
            image2 = image3;
            image3 = null;
          });
        } else {
          setState(() {
            image2 = null;
          });
        }
        break;
      case 2:
        setState(() {
          image3 = null;
        });
        break;
    }
  }

  Future chooseAttached(int i) async {
    try {
      await ImagePicker.platform
          .pickImage(source: ImageSource.gallery)
          .then((vale) {
        if (vale == null) {
          print("error selection");
        } else {
          switch (i) {
            case 0:
              setState(() {
                justificatif = File(vale.path);
              });
              break;
            case 1:
              setState(() {
                justificatif2 = File(vale.path);
              });
              break;
            case 2:
              setState(() {
                justificatif3 = File(vale.path);
              });
              break;
          }
        }
      });
    } catch (e) {
      print("error");
    }
  }

  Future uploadDataToFirebase(Uint8List image) async {
    String fileName = widget.locataire.cin;
    try {
      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('${widget.client.agence}/$uid/client/$fileName');
      firebase_storage.UploadTask uploadTask =
          firebaseStorageRef.putData(image);
      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() {});
      taskSnapshot.ref.getDownloadURL().then(
        (value) {
          setState(() {
            widget.locataire.cacher = value;
            saveUserInfoToFireStore();
          });
        },
      );
    } catch (e) {
      print("error dans la signature");
    }
  }

  Future chooseFile(int i) async {
    try {
      await ImagePicker.platform
          .pickImage(source: ImageSource.camera)
          .then((vale) {
        if (vale == null) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Echec de selection de l'image, merci de réssayer"),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        } else {
          if (i == 0) {
            setState(() {
              image = File(vale.path);
            });
          }
          if (i == 1) {
            setState(() {
              image2 = File(vale.path);
            });
          }
          if (i == 2) {
            setState(() {
              image3 = File(vale.path);
            });
          }
        }
      });
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("failed to select image"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }
}
