import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/models/contrat.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';
import 'package:myfleet_project/widgets/drawer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ModifyReservation extends StatefulWidget {
  final ClientModel client;
  final Contrat contrat;
  const ModifyReservation(
      {Key? key, required this.client, required this.contrat})
      : super(key: key);

  @override
  _ModifyReservationState createState() => _ModifyReservationState();
}

class _ModifyReservationState extends State<ModifyReservation> {
  @override
  Widget build(BuildContext context) {
    DateTime? datedep;
    DateTime? datere;
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
                    widget.contrat.name.toUpperCase(),
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
                    controller: cont,
                    view: DateRangePickerView.month,
                    selectionMode: DateRangePickerSelectionMode.range,
                    showActionButtons: true,
                    cancelText: "Annuler",
                    confirmText: "Confirmer",
                    onSubmit: (Object val) {
                      if (val is PickerDateRange) {
                        setState(() {
                          datedep = val.startDate!;
                          datere = val.endDate!;

                          FirebaseFirestore.instance
                              .collection("clients")
                              .doc(AuthProvider.sharedPreferences!
                                  .getString("id"))
                              .collection("contrat")
                              .doc(widget.contrat.id.toString())
                              .update({
                            "datedep": datedep,
                            "datere": datere,
                          }).then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          });
                        });
                      }
                    },
                    onCancel: () {
                      cont.selectedRanges = null;
                    },
                  )),
              SizedBox(
                height: 30,
              ),
            ]),
          ),
        ));
  }
}
