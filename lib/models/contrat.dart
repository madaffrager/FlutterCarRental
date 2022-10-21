import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfleet_project/models/etat_vehicule.dart';
import 'package:myfleet_project/widgets/config.dart';

class Contrat {
  int id;
  String cin;
  String name;
  String matricule;
  String type;
  EtatVehicule etat = new EtatVehicule(
      roue: true,
      disque: true,
      jack: true,
      fire: true,
      spanner: true,
      triangle: true,
      light: true,
      door: true,
      dumper: true,
      mirror: true,
      seat: true,
      bonnet: true,
      stemware: true,
      plus3: true,
      plus4: true,
      normal: true);
  String commentaire;
  List photos;
  List justificatifs;
  String signature;
  String kmdep;
  String kmre;
  DateTime datedep;
  DateTime datere;

  Contrat({
    required this.id,
    required this.cin,
    required this.type,
    required this.name,
    required this.matricule,
    required this.etat,
    required this.commentaire,
    required this.photos,
    required this.justificatifs,
    required this.signature,
    required this.kmdep,
    required this.kmre,
    required this.datedep,
    required this.datere,
  });

  static Contrat fromJson(Map<String, dynamic>? dataSnapshot) {
    return new Contrat(
        id: dataSnapshot!['id'],
        cin: dataSnapshot['cin'],
        type: dataSnapshot['type'],
        name: dataSnapshot['name'],
        matricule: dataSnapshot['matricule'],
        etat: dataSnapshot['etat'],
        commentaire: dataSnapshot['commentaire'],
        photos: dataSnapshot['photos'],
        justificatifs: dataSnapshot['justificatifs'],
        signature: dataSnapshot['signature'],
        kmdep: dataSnapshot['kmdep'],
        kmre: dataSnapshot['kmre'],
        datedep: dataSnapshot['datedep'],
        datere: dataSnapshot['datere']);
  }
}
