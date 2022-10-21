import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:myfleet_project/garage/addcar.dart';
import 'package:myfleet_project/garage/voiture_page.dart';
import 'package:myfleet_project/home/dashboard.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/user/login/login.dart';

import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';
import 'package:myfleet_project/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  String uid = "";
  String agence = "";
  String adresse = "";
  String mobile1 = "";
  String mobile2 = "";
  String mobile3 = "";
  String fixe = "";
  String rcnum = "";
  String irnum = "";
  String ifnum = "";
  String icenum = "";
  String cnssnum = "";
  String logo = "";
  String cacher = "";
  int nbcars = 0;
  @override
  Widget build(BuildContext context) {
    void readdata() async {
      try {
        await FirebaseFirestore.instance
            .collection("clients")
            .doc(AuthProvider.sharedPreferences!.getString("id"))
            .get()
            .then((dataSnapshot) {
          if (dataSnapshot.exists) {
            setState(() {
              name = dataSnapshot["name"];
              uid = dataSnapshot["id"];
              agence = dataSnapshot["agence"];
              adresse = dataSnapshot["adresse"];
              mobile1 = dataSnapshot["mobile1"];
              mobile2 = dataSnapshot["mobile2"];
              mobile3 = dataSnapshot["mobile3"];
              fixe = dataSnapshot["fixe"];
              rcnum = dataSnapshot["rcnum"];
              irnum = dataSnapshot["irnum"];
              ifnum = dataSnapshot["ifnum"];
              icenum = dataSnapshot["icenum"];
              cnssnum = dataSnapshot["cnssnum"];
              logo = dataSnapshot["logo"];
              cacher = dataSnapshot["cacher"];
              nbcars = dataSnapshot["nbcars"];
            });
          }
        });
      } catch (e) {
        print("error");
      }
    }

    readdata();
    ClientModel clientModel = new ClientModel(
        name: name,
        uid: uid,
        agence: agence,
        adresse: adresse,
        mobile1: mobile1,
        mobile2: mobile2,
        mobile3: mobile3,
        fixe: fixe,
        rcnum: rcnum,
        irnum: irnum,
        ifnum: ifnum,
        icenum: icenum,
        cnssnum: cnssnum,
        logo: logo,
        cacher: cacher,
        nbcars: nbcars);
    Size size = MediaQuery.of(context).size;
    // if (clientModel.nbcars == 0) {
    //   return Scaffold(
    //       appBar: AppBar(
    //         backgroundColor: ksecondary,
    //         leading: Text(
    //           "",
    //           style: TextStyle(color: Colors.black, fontSize: 20),
    //         ),
    //         leadingWidth: size.width * 0.3,
    //         title: Column(
    //           children: [
    //             Text(
    //               agence.toUpperCase(),
    //               style: TextStyle(
    //                   color: Colors.black, fontSize: size.width * 0.05),
    //             ),
    //             Text(
    //               ville.toUpperCase(),
    //               style: TextStyle(
    //                   color: Colors.black, fontSize: size.width * 0.04),
    //             )
    //           ],
    //         ),
    //         centerTitle: true,
    //         actions: [
    //           Image.asset(
    //             "assets/logo.png",
    //           ),
    //         ],
    //       ),
    //       body:
    //           ListView(padding: EdgeInsets.only(left: 5.0), children: <Widget>[
    //         SizedBox(height: 8.0),
    //         Padding(
    //           padding: const EdgeInsets.only(right: 20),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Builder(
    //                 builder: (context) => IconButton(
    //                   onPressed: () => Scaffold.of(context).openDrawer(),
    //                   icon: Icon(Icons.menu_rounded),
    //                 ),
    //               ),
    //               CircleAvatar(
    //                 backgroundColor: Colors.white,
    //                 radius: size.width * 0.08,
    //                 backgroundImage: NetworkImage(logo),
    //                 child: Text(""),
    //               )
    //             ],
    //           ),
    //         ),
    //         Container(
    //             width: size.width,
    //             height: size.height,
    //             child: Column(
    //               children: [
    //                 Text(
    //                     "Abonnement terminée, Veuillez contactez l'administrateur !"),
    //                 RaisedButton(
    //                     onPressed: () {
    //                       logout();
    //                       Navigator.pushReplacement(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (conext) => LoginPage()));
    //                     },
    //                     child: Text("Déconnexion"))
    //               ],
    //             ))
    //       ]));
    // } else {
    return Scaffold(
      drawer: BDrawer(client: clientModel),
      appBar: AppBar(
        backgroundColor: ksecondary,
        leading: Text(
          "",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        leadingWidth: size.width * 0.3,
        title: Text(
          agence.toUpperCase(),
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
        padding: EdgeInsets.only(left: 5.0),
        children: <Widget>[
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Dashboard(client: clientModel)));
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: size.width * 0.07,
                    backgroundImage: AssetImage("assets/p.png"),
                    child: Text(""),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            child: GaragePage(
              client: ClientModel(
                  name: name,
                  uid: uid,
                  agence: agence,
                  adresse: adresse,
                  mobile1: mobile1,
                  mobile2: mobile2,
                  mobile3: mobile3,
                  fixe: fixe,
                  rcnum: rcnum,
                  irnum: irnum,
                  ifnum: ifnum,
                  icenum: icenum,
                  cnssnum: cnssnum,
                  logo: logo,
                  cacher: cacher,
                  nbcars: nbcars),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AjoutVoiture(
                        clientModel: ClientModel(
                            name: name,
                            uid: uid,
                            agence: agence,
                            adresse: adresse,
                            mobile1: mobile1,
                            mobile2: mobile2,
                            mobile3: mobile3,
                            fixe: fixe,
                            rcnum: rcnum,
                            irnum: irnum,
                            ifnum: ifnum,
                            icenum: icenum,
                            cnssnum: cnssnum,
                            logo: logo,
                            cacher: cacher,
                            nbcars: nbcars),
                      )));
        },
        backgroundColor: kprimary,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void logout() async {
    await AuthProvider.sharedPreferences!.setString("id", "");
    await AuthProvider.sharedPreferences!.clear();
    await FirebaseAuth.instance.signOut();
  }
}
