import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myfleet_project/contrat/pdf_api/pdf_api.dart';
import 'package:myfleet_project/models/client.dart';
import 'package:myfleet_project/models/contrat.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/models/voiture.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:http/http.dart' show get;

class PdfInvoiceApi {
  static Future<File> generate(ClientModel client, CarModel car,
      Contrat contrat, Locataire locataire, Size size) async {
    final pdf = Document();
    var url = client.logo;
    var response = await get(Uri.parse(url));
    var logo = response.bodyBytes;

    var respons2e = await get(Uri.parse(client.cacher));
    var signature = respons2e.bodyBytes;

    var response2 = await get(Uri.parse(locataire.cacher));
    var signatureclient = response2.bodyBytes;

    final roue =
        (await rootBundle.load('assets/roue.png')).buffer.asUint8List();
    final bonnet =
        (await rootBundle.load('assets/bonnet.png')).buffer.asUint8List();
    final dumper =
        (await rootBundle.load('assets/bumper.png')).buffer.asUint8List();
    final fire =
        (await rootBundle.load('assets/fire.png')).buffer.asUint8List();
    final jack =
        (await rootBundle.load('assets/jack.png')).buffer.asUint8List();
    final light =
        (await rootBundle.load('assets/light.png')).buffer.asUint8List();
    final mirror =
        (await rootBundle.load('assets/mirror.png')).buffer.asUint8List();
    final seat =
        (await rootBundle.load('assets/seat.png')).buffer.asUint8List();
    final spanner =
        (await rootBundle.load('assets/spanner.png')).buffer.asUint8List();
    final stemware =
        (await rootBundle.load('assets/stemware.png')).buffer.asUint8List();
    final plus4 =
        (await rootBundle.load('assets/roue.png')).buffer.asUint8List();

    final plus3 =
        (await rootBundle.load('assets/roue.png')).buffer.asUint8List();
    final triangle =
        (await rootBundle.load('assets/triangle.png')).buffer.asUint8List();

    final disque =
        (await rootBundle.load('assets/cd.png')).buffer.asUint8List();

    final door =
        (await rootBundle.load('assets/door.png')).buffer.asUint8List();

    final applogo =
        (await rootBundle.load('assets/logo.png')).buffer.asUint8List();

    var photo1;
    var photo2;
    var photo3;

    var justi1;

    var justi2;
    var justi3;

    if (contrat.photos[0].toString().isNotEmpty) {
      var response = await get(Uri.parse(contrat.photos[0].toString()));
      photo1 = response.bodyBytes;
    }
    if (contrat.photos[1].toString().isNotEmpty) {
      var response = await get(Uri.parse(contrat.photos[1].toString()));
      photo2 = response.bodyBytes;
    }
    if (contrat.photos[2].toString().isNotEmpty) {
      var response = await get(Uri.parse(contrat.photos[2].toString()));
      photo3 = response.bodyBytes;
    }

    if (contrat.justificatifs[0].toString().isNotEmpty) {
      var response = await get(Uri.parse(contrat.justificatifs[0].toString()));
      justi1 = response.bodyBytes;
    }
    if (contrat.justificatifs[1].toString().isNotEmpty) {
      var response = await get(Uri.parse(contrat.justificatifs[1].toString()));
      justi2 = response.bodyBytes;
    }
    if (contrat.justificatifs[2].toString().isNotEmpty) {
      var response = await get(Uri.parse(contrat.justificatifs[2].toString()));
      justi3 = response.bodyBytes;
    }

    pdf.addPage(Page(
        orientation: PageOrientation.natural,
        theme: pw.ThemeData.withFont(
          base: await PdfGoogleFonts.varelaRoundRegular(),
          bold: await PdfGoogleFonts.varelaRoundRegular(),
          icons: await PdfGoogleFonts.materialIcons(),
        ),
        build: (context) => pw.Container(
              child: Column(children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: pw.EdgeInsets.all(2),
                        height: 70,
                        width: 70,
                        child: pw.Image(
                          pw.MemoryImage(logo),
                        ),
                      ),
                      Text(
                        "Contrat",
                        style: TextStyle(fontSize: 24, color: PdfColors.blue),
                      ),
                      Container(
                        padding: pw.EdgeInsets.all(2),
                        height: 70,
                        width: 70,
                        child: pw.Image(
                          pw.MemoryImage(applogo),
                        ),
                      ),
                    ]),
                divider(500),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Text(
                          "Client",
                          style: TextStyle(fontSize: 16, color: PdfColors.blue),
                        ),
                        textRow([
                          "Nom et prénom:",
                          "${locataire.name.toUpperCase()}"
                        ], textStyle1()),
                        textRow(["Date de naissance:", "${locataire.dob}"],
                            textStyle1()),
                        textRow(["CIN:", "${locataire.cin}"], textStyle1()),
                        textRow(["N° Passeport:", "${locataire.passeport}"],
                            textStyle1()),
                        textRow(
                            ["Permis:", "${locataire.permis}"], textStyle1()),
                        textRow(["Déliveré le :", "${locataire.datelivr}"],
                            textStyle1()),
                        textRow(
                            ["Adresse:", "${locataire.adresse}"], textStyle1()),
                        textRow(["N° mobile:", "${locataire.mobile}"],
                            textStyle1()),
                        Text(
                          "2 ème Conducteur déclaré",
                          style: TextStyle(fontSize: 14, color: PdfColors.grey),
                        ),
                        textRow([
                          "Nom et prénom:",
                          "${locataire.sname.toUpperCase()}"
                        ], textStyle1()),
                        textRow(["CIN:", "${locataire.scin}"], textStyle1()),
                        textRow(
                            ["Permis:", "${locataire.spermis}"], textStyle1()),
                        Text(
                          "Photos",
                          style: TextStyle(fontSize: 14, color: PdfColors.grey),
                        ),
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              photo1 != null
                                  ? Container(
                                      height: 70,
                                      width: 70,
                                      child: pw.Image(
                                        pw.MemoryImage(photo1),
                                      ),
                                    )
                                  : pw.Container(),
                              photo2 != null
                                  ? Container(
                                      height: 70,
                                      width: 70,
                                      child: pw.Image(
                                        pw.MemoryImage(photo2),
                                      ),
                                    )
                                  : pw.Container(),
                              photo3 != null
                                  ? Container(
                                      height: 70,
                                      width: 70,
                                      child: pw.Image(
                                        pw.MemoryImage(photo3),
                                      ),
                                    )
                                  : pw.Container(),
                            ]),
                        Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              justi1 != null
                                  ? Container(
                                      height: 70,
                                      width: 70,
                                      child: pw.Image(
                                        pw.MemoryImage(justi1),
                                      ),
                                    )
                                  : pw.Container(),
                              justi2 != null
                                  ? Container(
                                      height: 70,
                                      width: 70,
                                      child: pw.Image(
                                        pw.MemoryImage(justi2),
                                      ),
                                    )
                                  : pw.Container(),
                              justi3 != null
                                  ? Container(
                                      height: 70,
                                      width: 70,
                                      child: pw.Image(
                                        pw.MemoryImage(justi3),
                                      ),
                                    )
                                  : pw.Container(),
                            ]),
                        Container(
                          width: 120,
                          height: 120,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: pw.Image(pw.MemoryImage(signature),
                                    width: 100),
                              ),
                              pw.SizedBox(height: 20),
                              Text('Signature Agence',
                                  style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        ),
                      ]),
                      pw.Container(
                          width: size.width * 0.42,
                          child: Column(children: [
                            Text(
                              "Voiture",
                              style: TextStyle(
                                  fontSize: 18, color: PdfColors.blue),
                            ),
                            textRow(["Marque:", "${car.marque}"], textStyle1()),
                            textRow(["Modèle:", "${car.modele}"], textStyle1()),
                            textRow(["Immatriculation:", "${car.matricule}"],
                                textStyle1()),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Couleur", style: textStyle1()),
                                  Container(
                                    decoration: pw.BoxDecoration(
                                        color: PdfColor.fromInt(
                                            int.parse(car.couleur)),
                                        border: Border.all(width: 1)),
                                    height: 12,
                                    width: 12,
                                  ),
                                ]),
                            textRow(["Carburant:", "${car.carburant}"],
                                textStyle1()),
                            textRow([
                              "Date de départ:",
                              "${DateFormat('dd-MM-yyyy').format(contrat.datedep)}"
                            ], textStyle1()),
                            textRow([
                              "Date de retour:",
                              "${DateFormat('dd-MM-yyyy').format(contrat.datere)}"
                            ], textStyle1()),
                            textRow([
                              "Durée de location:",
                              "${contrat.datere.difference(contrat.datedep).inDays.toString()} Jours."
                            ], textStyle1()),
                            Text(
                              "Etat de Vehicule",
                              style: TextStyle(
                                  fontSize: 18, color: PdfColors.grey),
                            ),
                            Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.roue
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(roue),
                                    ),
                                  ),
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.disque
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(disque),
                                    ),
                                  ),
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.jack
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(jack),
                                    ),
                                  ),
                                ]),
                            pw.SizedBox(height: 5),
                            Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.fire
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(fire),
                                    ),
                                  ),
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.spanner
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(spanner),
                                    ),
                                  ),
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.triangle
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(triangle),
                                    ),
                                  ),
                                ]),
                            pw.SizedBox(height: 5),
                            Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.light
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(light),
                                    ),
                                  ),
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.door
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(door),
                                    ),
                                  ),
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.dumper
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(dumper),
                                    ),
                                  ),
                                ]),
                            pw.SizedBox(height: 5),
                            Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.mirror
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(mirror),
                                    ),
                                  ),
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.seat
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(seat),
                                    ),
                                  ),
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.bonnet
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(bonnet),
                                    ),
                                  ),
                                ]),
                            pw.SizedBox(height: 5),
                            Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.stemware
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(stemware),
                                    ),
                                  ),
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.plus3
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(plus3),
                                    ),
                                  ),
                                  Container(
                                    padding: pw.EdgeInsets.all(2),
                                    decoration: contrat.etat.plus4
                                        ? pw.BoxDecoration(
                                            border: Border.all(width: 1))
                                        : pw.BoxDecoration(),
                                    height: 30,
                                    width: 30,
                                    child: pw.Image(
                                      pw.MemoryImage(plus4),
                                    ),
                                  ),
                                ]),
                            pw.SizedBox(height: 10),
                            contrat.etat.normal
                                ? textRow(
                                    ["Assurance", "Normale"], textStyle1())
                                : textRow(["Assurance", "T.R"], textStyle1()),
                            textRow(["Commentaire", "${contrat.commentaire}"],
                                textStyle1()),
                            pw.SizedBox(height: 30),
                            Container(
                              width: 120,
                              height: 120,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: pw.Image(
                                        pw.MemoryImage(signatureclient),
                                        width: 100),
                                  ),
                                  Text("Signature Client",
                                      style: TextStyle(fontSize: 11)),
                                ],
                              ),
                            ),
                          ]))
                    ]),
                Text(
                  ">> Le client est seul responsable des délits et contraventions de la circulation routière.",
                  style: TextStyle(
                      fontSize: 11,
                      color: PdfColors.blue,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "ATTENTION : Conserver ce document qui doit être présenté à tout contrôle de Police",
                  style: TextStyle(fontSize: 11, color: PdfColors.grey),
                ),
                divider(500),
                Text(
                  " ${client.adresse} - Tél: ${client.mobile1}.",
                  style: TextStyle(fontSize: 11, color: PdfColors.grey),
                ),
                Text(
                  " R.0 ${client.rcnum}- ICE ${client.icenum}- I.F ${client.ifnum}- CNSS ${client.cnssnum}.",
                  style: TextStyle(fontSize: 11, color: PdfColors.grey),
                ),
              ]),
            )));

    return PdfApi.saveDocument(
        name: '${locataire.cin}-${contrat.id}.pdf', pdf: pdf);
  }

  static Widget divider(double width) {
    return Container(
      height: 3,
      width: width,
      decoration: BoxDecoration(
        color: PdfColors.grey,
      ),
    );
  }

  static Widget textRow(List<String> titleList, TextStyle textStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: titleList
          .map((e) => Container(
                alignment: pw.Alignment.topLeft,
                width: 100,
                child: Text(
                  e,
                  style: textStyle,
                ),
              ))
          .toList(),
    );
  }

  static TextStyle textStyle1() {
    return TextStyle(
      color: PdfColors.grey800,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    );
  }
}
