import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/models/voiture.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';

class AjoutVoiture extends StatefulWidget {
  final ClientModel clientModel;

  const AjoutVoiture({Key? key, required this.clientModel}) : super(key: key);

  @override
  _AjoutVoitureState createState() => _AjoutVoitureState();
}

class _AjoutVoitureState extends State<AjoutVoiture> {
  String marque = "";
  String modele = "";
  String couleur = Colors.black.value.toString();
  String matricule = "";
  String photo = "";
  String carburant = "";
  String km = "";
  String vidange = "";
  int taille = 0;
  List<String> carburantList = ["GASOIL", "ESSENCE", "ELECTRIQUE", "HYBRIDE"];
  final form = GlobalKey<FormState>();
  List<String> modeleList = [];
  void readdata() async {
    try {
      await FirebaseFirestore.instance
          .collection("clients")
          .doc(AuthProvider.sharedPreferences!.getString("id"))
          .collection('garage')
          .get()
          .then((dataSnapshot) {
        setState(() {
          taille = dataSnapshot.docs.length;
        });
      });
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    readdata();

    Size size = MediaQuery.of(context).size;
    if (taille == widget.clientModel.nbcars) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: ksecondary,
            leading: Text(
              "",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            leadingWidth: size.width * 0.3,
            title: Text(
              widget.clientModel.agence.toUpperCase(),
              style:
                  TextStyle(color: Colors.black, fontSize: size.width * 0.05),
            ),
            centerTitle: true,
            actions: [
              Image.asset(
                "assets/logo.png",
              ),
            ],
          ),
          body:
              ListView(padding: EdgeInsets.only(left: 5.0), children: <Widget>[
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
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
                    radius: size.width * 0.08,
                    backgroundImage: NetworkImage(widget.clientModel.logo),
                    child: Text(""),
                  )
                ],
              ),
            ),
            Container(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    Text(
                        "Abonnement terminée, Veuillez contactez l'administrateur !"),
                  ],
                ))
          ]));
    }
    return Scaffold(
      appBar: AppBar(
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
                    Text(
                        "${(taille + 1).toString()} / ${widget.clientModel.nbcars}"),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: size.width * 0.08,
                      backgroundImage: AssetImage("assets/p.png"),
                      child: Text(""),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
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
                      "Ajouter une voiture",
                      style: TextStyle(
                          fontSize: size.width * 0.08,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Container(
                      width: double.infinity,
                      child: Form(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          matricule.isEmpty
                              ? Container()
                              : Image.network(matricule),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              width: size.width * 0.3,
                              child: DropdownButton<String>(
                                value: marque.isEmpty ? marqueList[0] : marque,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                underline: Container(
                                  height: 2,
                                  color: ksecondary,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    marque = newValue!;
                                  });
                                },
                                items: marqueList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              width: size.width * 0.5,
                              child: dropdownButton(marque)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RaisedButton(
                                elevation: 3.0,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        titlePadding: const EdgeInsets.all(0.0),
                                        contentPadding:
                                            const EdgeInsets.all(0.0),
                                        content: SingleChildScrollView(
                                          child: ColorPicker(
                                            pickerColor: Colors.black,
                                            onColorChanged: (value) {
                                              setState(() {
                                                couleur =
                                                    value.value.toString();
                                              });
                                            },
                                            colorPickerWidth: 300.0,
                                            pickerAreaHeightPercent: 0.7,
                                            enableAlpha: true,
                                            displayThumbColor: true,
                                            showLabel: true,
                                            paletteType: PaletteType.hsv,
                                            pickerAreaBorderRadius:
                                                const BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(2.0),
                                              topRight:
                                                  const Radius.circular(2.0),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Text('Couleur de votre voiture'),
                                color: kprimary,
                                textColor: Colors.white,
                              ),
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  color: Color(int.parse(couleur)),
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: 120,
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  photo = value;
                                });
                              },
                              decoration:
                                  InputDecoration(labelText: "Immatriculation"),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  width: size.width * 0.3,
                                  child: DropdownButton<String>(
                                    value: carburant.isEmpty
                                        ? carburantList[0]
                                        : carburant,
                                    icon: const Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: ksecondary,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        carburant = newValue!;
                                      });
                                    },
                                    items: carburantList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )),
                              Container(
                                width: 70,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: "KM"),
                                  onChanged: (value) {
                                    setState(() {
                                      km = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 150,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Prochain Vidange"),
                              onChanged: (value) {
                                setState(() {
                                  vidange = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ))),
                ),
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: FlatButton(
                        color: kprimary,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        onPressed: () {
                          if (matricule.isNotEmpty &&
                              marque.isNotEmpty &&
                              modele.isNotEmpty &&
                              carburant.isNotEmpty &&
                              km.isNotEmpty &&
                              photo.isNotEmpty) {
                            CarModel car = new CarModel(
                                photo: matricule,
                                marque: marque,
                                modele: modele,
                                couleur: couleur!,
                                matricule: photo,
                                carburant: carburant,
                                km: km,
                                prochainvidange: vidange,
                                isfree: true);
                            FirebaseFirestore.instance
                                .collection('clients')
                                .doc(widget.clientModel.uid)
                                .collection('garage')
                                .doc(car.matricule)
                                .set(car.toJson())
                                .then((value) {
                              Navigator.pop(context);
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Voiture bien ajoutée"),
                                  backgroundColor: Theme.of(context).errorColor,
                                ),
                              );
                            });
                          } else {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Tous les champs sont obligatoires"),
                                backgroundColor: Theme.of(context).errorColor,
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Ajouter",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getCar(String marque, String modele) {
    try {
      FirebaseFirestore.instance
          .collection('autos')
          .doc(marque.toLowerCase() + '-' + modele.toLowerCase())
          .get()
          .then((value) {
        setState(() {
          matricule = value.get("photo");
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Widget dropdownButton(String marque) {
    List<String> items;
    switch (marque) {
      case "PEUGEOT":
        items = peugeot;
        break;
      case "RENAULT":
        items = renault;
        break;
      case "DACIA":
        items = dacia;
        break;
      case "CITROEN":
        items = citroen;
        break;
      case "FORD":
        items = ford;
        break;
      case "OPEL":
        items = opel;
        break;
      case "SUZUKI":
        items = suzuki;
        break;

      case "KIA":
        items = kia;
        break;
      case "HYUNDAI":
        items = hyundai;
        break;
      case "HONDA":
        items = honda;
        break;
      case "FIAT":
        items = fiat;
        break;
      case "SKODA":
        items = skoda;
        break;
      case "VOLKSWAGEN":
        items = volkswagen;
        break;
      case "TOYOTA":
        items = toyota;
        break;
      case "ALFAROMEO":
        items = alfaromeo;
        break;
      case "AUDI":
        items = audi;
        break;
      case "BMW":
        items = bmw;
        break;
      case "MERCEDES":
        items = mercedes;
        break;
      case "MAZDA":
        items = mazda;
        break;
      case "NISSAN":
        items = nissan;
        break;
      default:
        items = peugeot;
    }

    String valeur = items[0];
    return DropdownButton<String>(
      value: modele.isEmpty ? valeur : modele,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: ksecondary,
      ),
      onChanged: (String? newValue) {
        setState(() {
          modele = newValue!;
          getCar(marque, modele);
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
