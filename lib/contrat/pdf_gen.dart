import 'package:flutter/material.dart';
import 'package:myfleet_project/contrat/button.dart';
import 'package:myfleet_project/contrat/pdf_api/invoice_api.dart';
import 'package:myfleet_project/contrat/pdf_api/pdf_api.dart';
import 'package:myfleet_project/contrat/pdf_api_update/pdfapi.dart';
import 'package:myfleet_project/home/contrat.page.dart';
import 'package:myfleet_project/models/client.dart';
import 'package:myfleet_project/models/contrat.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/models/voiture.dart';
import 'package:myfleet_project/widgets/const.dart';

class PdfPage extends StatefulWidget {
  final ClientModel clientModel;
  final CarModel car;
  final Contrat contrat;
  final Locataire locataire;
  const PdfPage(
      {Key? key,
      required this.clientModel,
      required this.car,
      required this.contrat,
      required this.locataire})
      : super(key: key);

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) {
    bool waiting = false;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ContratPage(client: widget.clientModel)));
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: ksecondary,
        title: Text(
          widget.clientModel.agence,
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
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Téléchargement de PDF",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 48),
              RaisedButton(
                color: waiting ? Colors.white : kprimary,
                onPressed: () async {
                  setState(() {
                    waiting = true;
                  });
                  // final pdfFile = await PdfInvoiceAp2.generate(
                  //     widget.clientModel,
                  //     widget.car,
                  //     widget.contrat,
                  //     widget.locataire,
                  //     size);

                  // try {
                  final pdfFile = await PdfInvoiceAp2.generate(
                      widget.clientModel,
                      widget.car,
                      widget.contrat,
                      widget.locataire,
                      size);

                  PdfApi.openFile(pdfFile);
                  // } catch (e) {
                  //   print("error pdf");
                  // }
                },
                child: Text(
                  "Télécharger le contrat PDF",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
