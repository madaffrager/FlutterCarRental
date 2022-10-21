import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image/image.dart' as encoder;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myfleet_project/user/login/login.dart';
import 'package:myfleet_project/user/singup/signup.dart';
import 'package:myfleet_project/widgets/const.dart';
import 'package:signature/signature.dart';

class SignUpNext extends StatelessWidget {
  final name;
  final email;
  final password;
  const SignUpNext({Key? key, this.name, this.email, this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(
        email: email,
        password: password,
        name: name,
      ),
    );
  }
}

class Body extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  const Body(
      {Key? key,
      required this.name,
      required this.email,
      required this.password})
      : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  String agence = "";
  String adresse = "";
  bool second = false;
  bool third = false;
  String mobile1 = "";
  String mobile3 = "";
  String mobile2 = "";
  String rcnum = "";
  String irnum = "";
  String ifnum = "";
  String icenum = "";
  String cnssnum = "";
  String fixe = "";
  String logo = "";
  File? cacher;
  String ccacher = "";
  File? image;
  final SignatureController _controller = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      onDrawStart: () => print('onDrawStart called!'),
      onDrawEnd: () => print('onDrawEnd called!'),
      exportBackgroundColor: Colors.white);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
        text: "",
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: size.width * 0.8,
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Nom de l'agence",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Obligatoire*";
                            }
                            if (value.length < 3) {
                              return "Nom d'agence invalide";
                            }
                          },
                          onSaved: (value) {
                            agence = value!;
                          },
                        ),
                        TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                            labelText: "Adresse de Postale",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Obligatoire*";
                            }
                            if (value.length < 10) {
                              return "Adresse d'agence invalide";
                            }
                          },
                          onSaved: (value) {
                            adresse = value!;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.35,
                              child: TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Numéro Fixe",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Obligatoire*";
                                  }
                                },
                                onSaved: (value) {
                                  fixe = value!;
                                },
                              ),
                            ),
                            Container(
                              width: size.width * 0.35,
                              child: TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Numéro Mobile 1",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Obligatoire*";
                                  }
                                },
                                onSaved: (value) {
                                  mobile1 = value!;
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  second = !second;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: kprimary,
                                child: second
                                    ? Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                radius: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            second
                                ? Container(
                                    width: size.width * 0.35,
                                    child: TextFormField(
                                      autocorrect: false,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Numéro mobile 2",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Obligatoire*";
                                        }
                                      },
                                      onSaved: (value) {
                                        mobile2 = value!;
                                      },
                                    ),
                                  )
                                : Container(),
                            second && third
                                ? Container(
                                    width: 150,
                                    child: TextFormField(
                                      autocorrect: false,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Numéro Mobile 3",
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Obligatoire*";
                                        }
                                      },
                                      onSaved: (value) {
                                        mobile3 = value!;
                                      },
                                    ),
                                  )
                                : Container(),
                            second
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        third = !third;
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: kprimary,
                                      child: third
                                          ? Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                      radius: 15,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 70,
                              child: TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "RC",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Obligatoire*";
                                  }
                                },
                                onSaved: (value) {
                                  rcnum = value!;
                                },
                              ),
                            ),
                            Container(
                              width: 30,
                              child: TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "IR",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Obligatoire*";
                                  }
                                },
                                onSaved: (value) {
                                  irnum = value!;
                                },
                              ),
                            ),
                            Container(
                              width: 30,
                              child: TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "IF",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Obligatoire*";
                                  }
                                },
                                onSaved: (value) {
                                  ifnum = value!;
                                },
                              ),
                            ),
                            Container(
                              width: 30,
                              child: TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "ICE",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Obligatoire*";
                                  }
                                },
                                onSaved: (value) {
                                  icenum = value!;
                                },
                              ),
                            ),
                            Container(
                              width: 70,
                              child: TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "CNSS",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Obligatoire*";
                                  }
                                },
                                onSaved: (value) {
                                  cnssnum = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        image == null
                            ? GestureDetector(
                                onTap: chooseFile,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.black54,
                                    ),
                                    Text("Ajouter votre Logo",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54)),
                                    image != null
                                        ? Image.file(
                                            image!,
                                            width: 40,
                                          )
                                        : Container(),
                                  ],
                                ))
                            : Row(
                                children: [
                                  Image.file(
                                    image!,
                                    width: 40,
                                  ),
                                  IconButton(
                                      onPressed: clearSelection,
                                      icon: Icon(
                                        Icons.delete,
                                      )),
                                  SizedBox(width: size.width * 0.1),
                                ],
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        cacher == null
                            ? GestureDetector(
                                onTap: chooseFile2,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit_location_alt,
                                      color: Colors.black54,
                                    ),
                                    Text("Ajouter votre cachet",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54)),
                                    cacher != null
                                        ? Image.file(
                                            cacher!,
                                            width: 40,
                                          )
                                        : Container(),
                                  ],
                                ))
                            : Row(
                                children: [
                                  Image.file(
                                    cacher!,
                                    width: 40,
                                  ),
                                  IconButton(
                                      onPressed: clearSelection2,
                                      icon: Icon(
                                        Icons.delete,
                                      )),
                                  SizedBox(width: size.width * 0.1),
                                ],
                              ),
                        SizedBox(
                          height: 20,
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
                                color: Colors.purple[900],
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                onPressed: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }

                                  _formKey.currentState!.save();

                                  image != null
                                      ? uploadImageToFirebase(image!)
                                          .then((value) {
                                          uploadImageToFirebase2(cacher!)
                                              .then((value) {
                                            signUptoFirebase(widget.email,
                                                widget.password, widget.name);

                                            delay();
                                          });
                                        })
                                      : chooseFile();
                                },
                                child: Text(
                                  "Créer un compte",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }

  void clearSelection() {
    setState(() {
      image = null;
    });
  }

  void clearSelection2() {
    setState(() {
      cacher = null;
    });
  }

  Future chooseFile() async {
    try {
      await ImagePicker.platform
          .pickImage(source: ImageSource.gallery)
          .then((vale) {
        if (vale == null) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Echec de selection du logo, merci de réssayer"),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        } else {
          setState(() {
            image = File(vale.path);
          });
        }
      });
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("failed to select image"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  Future chooseFile2() async {
    try {
      await ImagePicker.platform
          .pickImage(source: ImageSource.gallery)
          .then((vale) {
        if (vale == null) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Echec de selection du cachet, merci de réssayer"),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        } else {
          setState(() {
            cacher = File(vale.path);
          });
        }
      });
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("failed to select image"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  Future uploadImageToFirebase(File image) async {
    String fileName = agence;
    try {
      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('$fileName/logos');
      firebase_storage.UploadTask uploadTask =
          firebaseStorageRef.putFile(image);
      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Logo validée"),
            backgroundColor: Theme.of(context).buttonColor,
          ),
        );
      });
      taskSnapshot.ref.getDownloadURL().then(
        (value) {
          setState(() {
            logo = value;
          });
        },
      );
      print(logo);
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("failed to upload logo"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  Future uploadImageToFirebase2(File image) async {
    String fileName = agence;
    try {
      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('$fileName/signature');
      firebase_storage.UploadTask uploadTask =
          firebaseStorageRef.putFile(image);
      firebase_storage.TaskSnapshot taskSnapshot =
          await uploadTask.whenComplete(() {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Signature validée"),
            backgroundColor: Theme.of(context).buttonColor,
          ),
        );
      });
      taskSnapshot.ref.getDownloadURL().then(
        (value) {
          setState(() {
            ccacher = value;
          });
        },
      );
      print(logo);
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("failed to upload logo"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  Future<void> signUptoFirebase(
      String email, String password, String name) async {
    User user;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((auth) {
        user = auth.user!;
        saveUserInfoToFireStore(user);
      });
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  saveUserInfoToFireStore(User user) {
    FirebaseFirestore.instance.collection("clients").doc(user.uid).set({
      "id": user.uid,
      "name": widget.name,
      "email": widget.email,
      "agence": agence,
      "adresse": adresse,
      "mobile1": mobile1,
      "mobile2": mobile2,
      "mobile3": mobile3,
      "fixe": fixe,
      "logo": logo,
      "cacher": ccacher,
      "rcnum": rcnum,
      "irnum": irnum,
      "ifnum": ifnum,
      "icenum": icenum,
      "cnssnum": cnssnum,
      "nbcars": 1,
    });
  }

  Future<void> delay() async {
    await new Future.delayed(new Duration(milliseconds: 5000), () {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Inscription en cours, merci de patienter..."),
          backgroundColor: Theme.of(context).focusColor,
        ),
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }
}
