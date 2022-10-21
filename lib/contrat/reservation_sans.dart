import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfleet_project/contrat/button.dart';
import 'package:myfleet_project/contrat/chooseLocataire.dart';
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
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ReservationSansContrat extends StatefulWidget {
  final ClientModel client;
  final CarModel car;
  final Locataire locataire;
  final bool? news;

  const ReservationSansContrat(
      {Key? key,
      required this.client,
      required this.car,
      required this.locataire,
      this.news})
      : super(key: key);

  @override
  _ReservationSansContratState createState() => _ReservationSansContratState();
}

class _ReservationSansContratState extends State<ReservationSansContrat> {
  @override
  DateTime? datedep;
  DateTime? datere;
  Widget build(BuildContext context) {
    bool done = false;
    DateRangePickerController cont = DateRangePickerController();

    ;
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
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage())),
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
                "Réservation",
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
            Container(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: datedep != null
                  ? datere != null
                      ? Text(
                          "De : " +
                              DateFormat('dd/MM/yyyy').format(datedep!) +
                              " à " +
                              DateFormat('dd/MM/yyyy').format(datere!),
                          style: TextStyle(fontSize: 16),
                        )
                      : Text(
                          "De :" + DateFormat('dd/MM/yyyy').format(datedep!),
                          style: TextStyle(fontSize: 16),
                        )
                  : Text(
                      "Date de réservation :",
                      style: TextStyle(fontSize: 16),
                    ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton(
                      context,
                      () => showSheet(
                            context,
                            child: buildDatePicker(),
                            onClicked: () {
                              final value =
                                  DateFormat('yyyy/MM/dd').format(datedep!);

                              Navigator.pop(context);
                            },
                          ),
                      "départ"),
                  const SizedBox(height: 24),
                  buildButton(
                      context,
                      () => showSheet(
                            context,
                            child: buildDatePicker2(),
                            onClicked: () {
                              final value =
                                  DateFormat('yyyy/MM/dd').format(datedep!);

                              Navigator.pop(context);
                            },
                          ),
                      "retour"),
                ],
              ),

              // SfDateRangePicker(
              //   controller: cont,
              //   view: DateRangePickerView.month,
              //   selectionMode: DateRangePickerSelectionMode.range,
              //   showActionButtons: true,
              //   cancelText: "Annuler",
              //   confirmText: "Confirmer",
              //   onSubmit: (Object val) {
              //     if (val is PickerDateRange) {
              //       setState(() {
              //         datedep = val.startDate!;
              //         datere = val.endDate!;

              //         EtatVehicule etat = new EtatVehicule(
              //             roue: done,
              //             disque: done,
              //             jack: done,
              //             fire: done,
              //             spanner: done,
              //             triangle: done,
              //             light: done,
              //             door: done,
              //             dumper: done,
              //             mirror: done,
              //             seat: done,
              //             bonnet: done,
              //             stemware: done,
              //             plus3: done,
              //             plus4: done,
              //             normal: done);
              //         Contrat contrat = new Contrat(
              //             id: DateTime.now().millisecondsSinceEpoch,
              //             cin: widget.locataire.cin,
              //             name: widget.locataire.name,
              //             type: "reservation",
              //             matricule: widget.car.matricule,
              //             etat: etat,
              //             commentaire: "",
              //             photos: [""],
              //             justificatifs: [""],
              //             signature: "",
              //             kmdep: "",
              //             kmre: "",
              //             datedep: datedep!,
              //             datere: datere!);
              //         FirebaseFirestore.instance
              //             .collection("clients")
              //             .doc(AuthProvider.sharedPreferences!
              //                 .getString("id"))
              //             .collection("locataires")
              //             .doc(widget.locataire.id.toString())
              //             .set({
              //           "id": widget.locataire.id,
              //           "name": widget.locataire.name,
              //           "dob": widget.locataire.dob,
              //           "cin": widget.locataire.cin,
              //           "permis": widget.locataire.permis,
              //           "delivered": widget.locataire.datelivr,
              //           "passport": widget.locataire.passeport,
              //           "adresse": widget.locataire.adresse,
              //           "mobile": widget.locataire.mobile,
              //           "second driver": widget.locataire.second,
              //           "second_driver_name": widget.locataire.sname,
              //           "second_driver_dob": widget.locataire.sdob,
              //           "second_driver_cin": widget.locataire.scin,
              //           "second_driver_permis": widget.locataire.spermis,
              //           "cacher": widget.locataire.cacher
              //         });

              //         FirebaseFirestore.instance
              //             .collection("clients")
              //             .doc(AuthProvider.sharedPreferences!
              //                 .getString("id"))
              //             .collection("contrat")
              //             .doc(contrat.id.toString())
              //             .set({
              //           "id": contrat.id,
              //           "cin": contrat.cin,
              //           "name": widget.locataire.name,
              //           "type": contrat.type,
              //           "matricule": contrat.matricule,
              //           "photos": [""].toList(),
              //           "commentaire": contrat.commentaire,
              //           "assurance": "",
              //           "justificatifs": [""].toList(),
              //           "datedep": contrat.datedep,
              //           "datere": contrat.datere,
              //           "kmdep": contrat.kmdep,
              //           "kmre": contrat.kmre,
              //           "signature": contrat.signature,
              //           "roue": etat.roue,
              //           "disque": etat.disque,
              //           "jack": etat.jack,
              //           "fire": etat.fire,
              //           "spanner": etat.spanner,
              //           "triangle": etat.triangle,
              //           "light": etat.light,
              //           "door": etat.door,
              //           "dumper": etat.dumper,
              //           "mirror": etat.mirror,
              //           "seat": etat.seat,
              //           "bonnet": etat.bonnet,
              //           "stemware": etat.stemware,
              //           "plus3": etat.plus3,
              //           "plus4": etat.plus4,
              //         }).then((value) {
              //           FirebaseFirestore.instance
              //               .collection("clients")
              //               .doc(AuthProvider.sharedPreferences!
              //                   .getString("id"))
              //               .collection("garage")
              //               .doc(contrat.matricule)
              //               .update({"isfree": false}).then((value) {
              //             Navigator.pushReplacement(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => ContratDetail(
              //                         contrat: contrat,
              //                         etat: etat,
              //                         client: widget.client)));
              //           });
              //         });
              //       });
              //     }
              //   },
              //   onCancel: () {
              //     cont.selectedRanges = null;
              //   },
              // )
            ),
            SizedBox(
              height: 30,
            ),
            (datedep != null && datere != null)
                ? Text(
                    "Durée : ${datere!.difference(datedep!).inDays.toString()} Jours.",
                    style: TextStyle(fontSize: 16),
                  )
                : Text("")
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: kprimary,
          onPressed: () {
            EtatVehicule etat = new EtatVehicule(
                roue: done,
                disque: done,
                jack: done,
                fire: done,
                spanner: done,
                triangle: done,
                light: done,
                door: done,
                dumper: done,
                mirror: done,
                seat: done,
                bonnet: done,
                stemware: done,
                plus3: done,
                plus4: done,
                normal: done);
            Contrat contrat = new Contrat(
                id: DateTime.now().millisecondsSinceEpoch,
                cin: widget.locataire.cin,
                name: widget.locataire.name,
                type: "reservation",
                matricule: widget.car.matricule,
                etat: etat,
                commentaire: "",
                photos: [""],
                justificatifs: [""],
                signature: "",
                kmdep: "",
                kmre: "",
                datedep: datedep!,
                datere: datere!);
            FirebaseFirestore.instance
                .collection("clients")
                .doc(AuthProvider.sharedPreferences!.getString("id"))
                .collection("locataires")
                .doc(widget.locataire.id.toString())
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
            });

            FirebaseFirestore.instance
                .collection("clients")
                .doc(AuthProvider.sharedPreferences!.getString("id"))
                .collection("contrat")
                .doc(contrat.id.toString())
                .set({
              "id": contrat.id,
              "cin": contrat.cin,
              "name": widget.locataire.name,
              "type": contrat.type,
              "matricule": contrat.matricule,
              "photos": [""].toList(),
              "commentaire": contrat.commentaire,
              "assurance": "",
              "justificatifs": [""].toList(),
              "datedep": contrat.datedep,
              "datere": contrat.datere,
              "kmdep": contrat.kmdep,
              "kmre": contrat.kmre,
              "signature": contrat.signature,
              "roue": etat.roue,
              "disque": etat.disque,
              "jack": etat.jack,
              "fire": etat.fire,
              "spanner": etat.spanner,
              "triangle": etat.triangle,
              "light": etat.light,
              "door": etat.door,
              "dumper": etat.dumper,
              "mirror": etat.mirror,
              "seat": etat.seat,
              "bonnet": etat.bonnet,
              "stemware": etat.stemware,
              "plus3": etat.plus3,
              "plus4": etat.plus4,
            }).then((value) {
              FirebaseFirestore.instance
                  .collection("clients")
                  .doc(AuthProvider.sharedPreferences!.getString("id"))
                  .collection("garage")
                  .doc(contrat.matricule)
                  .update({"isfree": false}).then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContratDetail(
                            contrat: contrat,
                            etat: etat,
                            client: widget.client)));
              });
            });
          },
          label: Text("Confirmer")),
    );
  }

  Widget buildButton(
          BuildContext context, VoidCallback onClicked, String text) =>
      RaisedButton(
        color: kprimary,
        textColor: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.more_time, size: 20),
            const SizedBox(width: 8),
            Text(
              'Choisir la date de ' + text,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        onPressed: onClicked,
      );
  static void showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Done'),
            onPressed: onClicked,
          ),
        ),
      );
  Widget buildDatePicker() => SizedBox(
        height: 100,
        child: CupertinoDatePicker(
          minimumYear: DateTime.now().year,
          maximumYear: DateTime.now().year + 5,
          initialDateTime: DateTime(2021),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) => setState(() => datedep = dateTime),
        ),
      );
  Widget buildDatePicker2() => SizedBox(
        height: 100,
        child: CupertinoDatePicker(
          minimumYear: DateTime.now().year,
          maximumYear: DateTime.now().year + 5,
          initialDateTime: DateTime(2021),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) => setState(() => datere = dateTime),
        ),
      );
}
