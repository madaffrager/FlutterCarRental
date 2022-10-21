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

class PdfInvoiceAp2 {
  static Future<File> generate(ClientModel client, CarModel car,
      Contrat contrat, Locataire locataire, Size size) async {
    final pdf = Document();

    var response = await get(Uri.parse(client.logo));
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

    final pdfmodel =
        (await rootBundle.load('assets/pdf.jpg')).buffer.asUint8List();

    final applogo =
        (await rootBundle.load('assets/logo.png')).buffer.asUint8List();

    var photo1;
    var photo2;
    var photo3;

    final justi1;

    final justi2;
    final justi3;

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
        pageFormat: PdfPageFormat(8 * PdfPageFormat.cm, 12 * PdfPageFormat.cm,
            marginAll: 0.1 * PdfPageFormat.cm),
        theme: pw.ThemeData.withFont(
          base: await PdfGoogleFonts.varelaRoundRegular(),
          bold: await PdfGoogleFonts.varelaRoundRegular(),
          icons: await PdfGoogleFonts.materialIcons(),
        ),
        build: (context) => Stack(children: [
              pw.Container(
                width: size.width,
                height: size.height,
                child: pw.Image(
                  pw.MemoryImage(pdfmodel),
                ),
              ),
              pw.Positioned(
                  top: 0,
                  left: 5,
                  child: pw.Container(
                    width: 210,
                    height: 40,
                    child: pw.Image(
                      pw.MemoryImage(logo),
                      fit: BoxFit.contain,
                    ),
                  )),
              pw.Positioned(
                  top: 75,
                  left: 10,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text("N° : ${contrat.id} ",
                          style: titleStyle1()))),
              pw.Positioned(
                  top: 75,
                  left: 150,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(
                          "Le ${DateTime.now().day.toString()}/${DateTime.now().month.toString()}/${DateTime.now().year.toString()}",
                          style: titleStyle1()))),
              pw.Positioned(
                  top: 110,
                  left: 40,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(contrat.name, style: textStyle1()))),
              pw.Positioned(
                  top: 125,
                  left: 40,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(locataire.dob, style: textStyle1()))),
              pw.Positioned(
                  top: 135.5,
                  left: 40,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(contrat.cin, style: textStyle1()))),
              pw.Positioned(
                  top: 142,
                  left: 40,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(locataire.datelivr, style: textStyle1()))),
              pw.Positioned(
                  top: 149.5,
                  left: 40,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child:
                          pw.Text(locataire.passeport, style: textStyle1()))),
              pw.Positioned(
                  top: 164,
                  left: 40,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(locataire.permis, style: textStyle1()))),
              pw.Positioned(
                  top: 176.5,
                  left: 30,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(locataire.adresse, style: textStyle1()))),
              pw.Positioned(
                  top: 184.5,
                  left: 45,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(locataire.mobile, style: textStyle1()))),
              pw.Positioned(
                  top: 210,
                  left: 42,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(locataire.sname, style: textStyle1()))),
              pw.Positioned(
                  top: 222.5,
                  left: 42,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(locataire.spermis, style: textStyle1()))),
              pw.Positioned(
                  top: 230,
                  left: 40,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(locataire.scin, style: textStyle1()))),

//voiture daba
              pw.Positioned(
                  top: 97,
                  left: 150,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text("${car.marque} ${car.modele}",
                          style: textStyle1()))),
              pw.Positioned(
                  top: 105,
                  left: 163,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text("${car.matricule}", style: textStyle1()))),
              pw.Positioned(
                top: 112,
                left: 163,
                child: Container(
                  decoration: pw.BoxDecoration(
                      color: PdfColor.fromInt(int.parse(car.couleur)),
                      border: Border.all(width: 0.5)),
                  height: 4,
                  width: 4,
                ),
              ),
              pw.Positioned(
                  top: 118,
                  left: 163,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text("${car.carburant}", style: textStyle1()))),
              pw.Positioned(
                  top: 127,
                  left: 163,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(
                          "${contrat.datedep.day.toString()}/${contrat.datedep.month.toString()}/${contrat.datedep.year.toString()}",
                          style: textStyle1()))),
              pw.Positioned(
                  top: 133,
                  left: 163,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(
                          "${contrat.datere.day.toString()}/${contrat.datere.month.toString()}/${contrat.datere.year.toString()}",
                          style: textStyle1()))),

              pw.Positioned(
                  top: 139.4,
                  left: 163,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text(
                          "${contrat.datere.difference(contrat.datedep).inDays.toString()} Jours",
                          style: textStyle1()))),
              pw.Positioned(
                  top: 172,
                  left: 163,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child: pw.Text("${client.fixe}", style: textStyle1()))),

              pw.Positioned(
                  top: 165.5,
                  left: 163,
                  child: pw.Container(
                      width: PdfPageFormat.cm * 4,
                      height: PdfPageFormat.cm * 1.5,
                      child:
                          pw.Text("${client.mobile1}", style: textStyle1()))),

              !contrat.etat.normal
                  ? pw.Positioned(
                      top: 181.5,
                      left: 114,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border: Border.all(width: 0.5)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : pw.Positioned(
                      top: 188.5,
                      left: 114,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border: Border.all(width: 0.5)),
                        height: 4,
                        width: 4,
                      ),
                    ),
              pw.Positioned(
                top: 205.5,
                left: 118,
                child: Container(
                    height: 30,
                    width: 90,
                    child: Text(contrat.commentaire, style: textStyle1())),
              ),
              photo1 == null
                  ? pw.Positioned(
                      top: 220.5,
                      left: 118,
                      child: Container(),
                    )
                  : pw.Positioned(
                      top: 220.5,
                      left: 118,
                      child: Container(
                        height: 25,
                        width: 25,
                        child: pw.Image(pw.MemoryImage(photo1),
                            fit: pw.BoxFit.contain),
                      ),
                    ),
              photo2 == null
                  ? pw.Positioned(
                      top: 220.5,
                      left: 148,
                      child: Container(),
                    )
                  : pw.Positioned(
                      top: 220.5,
                      left: 148,
                      child: Container(
                        height: 25,
                        width: 25,
                        child: pw.Image(pw.MemoryImage(photo2),
                            fit: pw.BoxFit.contain),
                      ),
                    ),
              photo3 == null
                  ? pw.Positioned(
                      top: 220.5,
                      left: 178,
                      child: Container(),
                    )
                  : pw.Positioned(
                      top: 220.5,
                      left: 178,
                      child: Container(
                        height: 25,
                        width: 25,
                        child: pw.Image(pw.MemoryImage(photo3),
                            fit: pw.BoxFit.contain),
                      ),
                    ),

              pw.Positioned(
                top: 294,
                left: 170,
                child: Container(
                  child: pw.Image(pw.MemoryImage(signatureclient),
                      fit: pw.BoxFit.fill),
                  height: 12,
                  width: 24,
                ),
              ),
              pw.Positioned(
                top: 288,
                left: 116,
                child: Container(
                  child:
                      pw.Image(pw.MemoryImage(signature), fit: pw.BoxFit.fill),
                  height: 21,
                  width: 45,
                ),
              ),

              pw.Positioned(
                top: 322,
                left: 50,
                child: Text(
                    "${client.agence} - ${client.adresse} - Tél: ${client.mobile1}.",
                    style: textStyle1()),
              ),
              pw.Positioned(
                top: 328,
                left: 70,
                child: Text(
                    " R.0 ${client.rcnum}- ICE ${client.icenum}- I.F ${client.ifnum}- CNSS ${client.cnssnum}.",
                    style: textStyle1()),
              ),

              contrat.etat.disque
                  ? pw.Positioned(
                      top: 248.5,
                      left: 35,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
              contrat.etat.roue
                  ? pw.Positioned(
                      top: 248.5,
                      left: 62,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
              contrat.etat.stemware
                  ? pw.Positioned(
                      top: 248.5,
                      left: 89,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
              contrat.etat.jack
                  ? pw.Positioned(
                      top: 258.5,
                      left: 35,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),

              contrat.etat.spanner
                  ? pw.Positioned(
                      top: 258.5,
                      left: 62,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
              contrat.etat.fire
                  ? pw.Positioned(
                      top: 258.5,
                      left: 89,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),

              contrat.etat.triangle
                  ? pw.Positioned(
                      top: 268.5,
                      left: 35,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
              contrat.etat.light
                  ? pw.Positioned(
                      top: 268.5,
                      left: 62,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
              contrat.etat.door
                  ? pw.Positioned(
                      top: 268.5,
                      left: 89,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
              contrat.etat.dumper
                  ? pw.Positioned(
                      top: 280.5,
                      left: 35,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
              contrat.etat.mirror
                  ? pw.Positioned(
                      top: 280.5,
                      left: 62,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
              contrat.etat.plus3
                  ? pw.Positioned(
                      top: 280.5,
                      left: 89,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
              contrat.etat.seat
                  ? pw.Positioned(
                      top: 290.5,
                      left: 35,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
              contrat.etat.bonnet
                  ? pw.Positioned(
                      top: 290.5,
                      left: 62,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),

              contrat.etat.plus4
                  ? pw.Positioned(
                      top: 290.5,
                      left: 89,
                      child: Container(
                        decoration: pw.BoxDecoration(
                            color: PdfColors.black,
                            border:
                                Border.all(width: 0.5, color: PdfColors.white)),
                        height: 4,
                        width: 4,
                      ),
                    )
                  : Container(),
            ])));

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
      color: PdfColor.fromInt(0x004a5085),
      fontSize: 4,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );
  }

  static TextStyle titleStyle1() {
    return TextStyle(
      color: PdfColor.fromInt(0x004a5085),
      fontSize: 6,
      fontWeight: FontWeight.bold,
    );
  }
}
