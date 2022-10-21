import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfleet_project/contrat/reservationpage.dart';
import 'package:myfleet_project/home/contrat.page.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/locataires/clientpage.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/user/login/login.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';

class BDrawer extends StatelessWidget {
  final ClientModel client;
  BDrawer({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          DrawerHeader(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/p.png"),
                    radius: 50,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(client.agence,
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight + Alignment(0, .3),
                  child: Text(
                    client.name,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (conext) => HomePage()));
            },
            title: Text("Mon garage"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContratPage(client: client)));
            },
            title: Text("Mes contrats"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReservationPage(
                            client: client,
                          )));
            },
            title: Text("Mes réservations"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientPage(client: client)));
            },
            title: Text("Mes clients"),
          ),
          ListTile(
            onTap: () {
              logout();
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => new LoginPage()),
                  (route) => false);
            },
            title: Text("Déconnexion"),
          )
        ],
      ),
    );
  }

  void logout() async {
    await AuthProvider.sharedPreferences!.setString("id", "");
    await AuthProvider.sharedPreferences!.clear();
    await FirebaseAuth.instance.signOut();
  }
}
