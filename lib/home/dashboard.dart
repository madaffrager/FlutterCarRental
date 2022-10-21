import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfleet_project/garage/voiture_page.dart';
import 'package:myfleet_project/home/contrat.page.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/locataires/clientpage.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/user/login/login.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';
import 'package:myfleet_project/widgets/drawer.dart';

class Dashboard extends StatefulWidget {
  final ClientModel client;
  const Dashboard({Key? key, required this.client}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: BDrawer(client: widget.client),
      appBar: AppBar(
        backgroundColor: ksecondary,
        leadingWidth: size.width * 0.1,
        title: Text(
          widget.client.agence.toUpperCase(),
          style: TextStyle(color: Colors.black, fontSize: size.width * 0.05),
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            "assets/logo.png",
            width: 100,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 5.0),
        children: <Widget>[
          SizedBox(height: 8.0),
          Container(
            height: size.height,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: size.height * 0.04,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child: Image.network(
                          widget.client.logo,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Bonjour ${widget.client.name.toUpperCase()}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        " ${widget.client.agence.toUpperCase()}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: FlatButton(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.garage_outlined,
                                            color: kprimary,
                                          ),
                                          Text(
                                            "  Mon Garage",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Container(
                              width: size.width * 0.4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: FlatButton(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ContratPage(
                                                    client: widget.client,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.notes,
                                            color: kprimary,
                                          ),
                                          Text(
                                            "  Mes Contrats",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: FlatButton(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ClientPage(
                                                    client: widget.client,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.group_outlined,
                                            color: kprimary,
                                          ),
                                          Text(
                                            "  Mes Clients",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Container(
                              width: size.width * 0.4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: FlatButton(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    color: Colors.white,
                                    onPressed: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person_outline,
                                            color: kprimary,
                                          ),
                                          Text(
                                            "  Mes Données",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: size.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FlatButton(
                              color: kprimary,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 40),
                              onPressed: () {
                                logout();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (conext) => LoginPage()));
                              },
                              child: Text(
                                "Se déconnecter",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
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
