import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfleet_project/home/home.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/user/singup/signup.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  String _email = "", _password = "";
  String _error = "";
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Backgroundlog(
      text: "Connexion",
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.6,
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                      ),
                      TextFormField(
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "E-mail",
                            icon: Icon(
                              Icons.email_rounded,
                              color: Colors.black,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Obligatoire*";
                          }
                          if (!value.contains("@")) {
                            return "E-mail invalide";
                          }
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      TextFormField(
                        obscureText: obscure,
                        decoration: InputDecoration(
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              child: Icon(
                                !obscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                            ),
                            labelText: "Mot de passe",
                            icon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Obligatoire*";
                          }
                          if (value.length < 8) {
                            return "Mot de passe invalide";
                          }
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FlatButton(
                    color: kprimary,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    onPressed: signIn,
                    child: Text(
                      "Connexion",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FlatButton(
                    color: ksecondary,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Créer un compte",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            // AlreadyHaveAnAccountCheck(
            //   press: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => SignUpPage()));
            //   },
            // )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      User? user = result.user;

      if (user != null) {
        await AuthProvider.init();
        AuthProvider.sharedPreferences!.setString("id", user.uid).then((value) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (conext) => HomePage()));
        });
      }
    } catch (err) {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("E-mail ou mot de passe est incorrect"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }
}

class Backgroundlog extends StatelessWidget {
  final String text;
  final Widget child;
  const Backgroundlog({
    required this.child,
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Image.asset("assets/bot.png", width: size.width * 1),
          ),
          Positioned(
            top: 70,
            child: Image.asset("assets/logo.png", width: size.width * 0.6),
          ),
          Positioned(
            top: 150,
            left: 20,
            child: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  "     à MyFleet.",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
