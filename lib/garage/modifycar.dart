import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/models/voiture.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';

class ModifyCar extends StatefulWidget {
  final ClientModel client;
  final CarModel car;
  const ModifyCar({Key? key, required this.client, required this.car})
      : super(key: key);

  @override
  _ModifyCarState createState() => _ModifyCarState();
}

class _ModifyCarState extends State<ModifyCar> {
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
                      "Modification de voiture",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Suppression de voiture'),
                                  content: Text(
                                      'Confirmez la suppression de la voiture ?'),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () async {
                                          try {
                                            FirebaseFirestore.instance
                                                .collection('clients')
                                                .doc(AuthProvider
                                                    .sharedPreferences!
                                                    .getString('id'))
                                                .collection('garage')
                                                .doc('${widget.car.matricule}')
                                                .delete()
                                                .then((value) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage()));
                                            });
                                          } catch (e) {
                                            print("error");
                                          }
                                        },
                                        child: Text('Confirmer')),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Annuler'),
                                    )
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.delete, color: Colors.red))
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Hero(
                              tag: widget.car.matricule,
                              child: Image.network(widget.car.photo,
                                  height: 200.0,
                                  width: 200.0,
                                  fit: BoxFit.contain)),
                          SizedBox(height: 10.0),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, top: 5, bottom: 5, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Marque :",
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: 'Varela'),
                                    ),
                                    Text(
                                      widget.car.marque,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Varela',
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, top: 5, bottom: 5, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Genre :",
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: 'Varela'),
                                    ),
                                    Text(
                                      widget.car.modele,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Varela',
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, top: 5, bottom: 5, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Immatriculation :",
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: 'Varela'),
                                    ),
                                    Text(
                                      widget.car.matricule,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Varela',
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, top: 5, bottom: 5, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Couleur :",
                                      style: TextStyle(
                                          fontSize: 16, fontFamily: 'Varela'),
                                    ),
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        color: Color(
                                            int.parse(widget.car.couleur)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, top: 5, bottom: 5, right: 25),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Kilométrage",
                                    hintText: widget.car.km + " KM",
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      widget.car.km = value;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, top: 5, bottom: 5, right: 25),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Prochain vidange:",
                                    hintText: widget.car.prochainvidange,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      widget.car.prochainvidange = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            try {
              FirebaseFirestore.instance
                  .collection("clients")
                  .doc(AuthProvider.sharedPreferences!.getString("id"))
                  .collection("garage")
                  .doc("${widget.car.matricule}")
                  .update({
                "km": widget.car.km,
                "prochainvidange": widget.car.prochainvidange
              }).then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              });
            } catch (e) {
              print(e);
            }
          },
          backgroundColor: kprimary,
          label: Text("Valider")),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
