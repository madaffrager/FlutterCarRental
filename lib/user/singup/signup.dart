import 'package:flutter/material.dart';
import 'package:myfleet_project/user/singup/signupnext.dart';
import 'package:myfleet_project/widgets/const.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  String _password = "";
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      text: " ",
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: size.width * 0.8,
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: "Nom de gérant",
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Obligatoire*";
                        }
                        if (value.length < 3) {
                          return "Nom invalide";
                        }
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
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
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: FlatButton(
                  color: kprimary,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    _formKey.currentState!.save();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpNext(
                                  name: _name,
                                  email: _email,
                                  password: _password,
                                )));
                  },
                  child: Text(
                    "Suivant",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final String text;
  final Widget child;
  const Background({
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
        alignment: Alignment.topLeft,
        children: [
          Positioned(
            bottom: 0,
            child: Image.asset("assets/bot.png", width: size.width * 1),
          ),
          Positioned(
            top: 100,
            left: size.width * 0.25,
            child: Image.asset("assets/logo.png", width: size.width * 0.5),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kprimary),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.05,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Positioned(
            top: 150,
            left: size.width * 0.08,
            child: child,
          )
        ],
      ),
    );
  }
}
