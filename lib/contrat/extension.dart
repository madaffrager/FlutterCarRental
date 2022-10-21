import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/models/contrat.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Extensioncalss extends StatefulWidget {
  final Contrat contrat;
  final ClientModel client;
  const Extensioncalss({Key? key, required this.contrat, required this.client})
      : super(key: key);

  @override
  _ExtensioncalssState createState() => _ExtensioncalssState();
}

class _ExtensioncalssState extends State<Extensioncalss> {
  DateRangePickerController cont = DateRangePickerController();

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
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Row(
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                    Text(
                      "Extension du contrat",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      " ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  child: Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              color: Colors.orange.withOpacity(0.3),
                              margin: EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(widget.contrat.id.toString()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("De " +
                                            DateFormat('dd-MM-yyyy').format(
                                                widget.contrat.datedep)),
                                        Text("À " +
                                            DateFormat('dd-MM-yyyy')
                                                .format(widget.contrat.datere)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Client CIN :"),
                                        Text(widget.contrat.cin),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: SfDateRangePicker(
                                  view: DateRangePickerView.month,
                                  showActionButtons: true,
                                  selectionMode:
                                      DateRangePickerSelectionMode.range,
                                  initialSelectedRange: PickerDateRange(
                                      widget.contrat.datedep,
                                      widget.contrat.datere),
                                  onSubmit: (Object val) {
                                    setState(() {
                                      if (val is PickerDateRange) {
                                        widget.contrat.datere = val.endDate!;
                                      }
                                    });
                                  },
                                  onCancel: () {
                                    cont.selectedRanges = null;
                                  },
                                )),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('clients')
                .doc(AuthProvider.sharedPreferences!.getString('id'))
                .collection('contrat')
                .doc('${widget.contrat.id}')
                .update({"datere": widget.contrat.datere});

            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "Changement effectué, téléchager le contrat depuis Mes Contrats "),
                backgroundColor: Theme.of(context).focusColor,
              ),
            );
          },
          backgroundColor: kprimary,
          label: Text("Valider")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
