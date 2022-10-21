import 'package:flutter/material.dart';

class CarModel {
  String photo;
  String marque;
  String modele;
  String couleur;
  String matricule;
  String carburant;
  String km;
  String prochainvidange;
  bool isfree;

  CarModel({
    required this.photo,
    required this.marque,
    required this.modele,
    required this.couleur,
    required this.matricule,
    required this.carburant,
    required this.km,
    required this.prochainvidange,
    required this.isfree,
  });

  static CarModel fromJson(Map<String, dynamic> dataSnapshot) {
    return new CarModel(
        photo: dataSnapshot["photo"],
        marque: dataSnapshot["marque"],
        modele: dataSnapshot["modele"],
        couleur: dataSnapshot["couleur"],
        matricule: dataSnapshot["matricule"],
        carburant: dataSnapshot["carburant"],
        km: dataSnapshot["km"],
        isfree: dataSnapshot["isfree"],
        prochainvidange: dataSnapshot["prochainvidange"].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['photo'] = this.photo;
    data['marque'] = this.marque;
    data['modele'] = this.modele;
    data['couleur'] = this.couleur;
    data['matricule'] = this.matricule;
    data['carburant'] = this.carburant;
    data['km'] = this.km;
    data['prochainvidange'] = this.prochainvidange;
    data['isfree'] = this.isfree;

    return data;
  }
}
