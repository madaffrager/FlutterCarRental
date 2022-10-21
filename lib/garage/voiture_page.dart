import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myfleet_project/garage/voiture_detail.dart';
import 'package:myfleet_project/models/user.dart';
import 'package:myfleet_project/models/voiture.dart';
import 'package:myfleet_project/widgets/config.dart';
import 'package:myfleet_project/widgets/const.dart';

class GaragePage extends StatelessWidget {
  final ClientModel client;

  const GaragePage({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 15.0),
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('clients')
                  .doc(AuthProvider.sharedPreferences!.getString("id"))
                  .collection('garage')
                  .orderBy('marque', descending: true)
                  .snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kprimary,
                          ),
                        ),
                      )
                    : dataSnapshot.data!.docs.length == 0
                        ? noGarage()
                        : GridView.builder(
                            itemCount: dataSnapshot.data!.docs.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) => _buildCard(
                                CarModel.fromJson(dataSnapshot.data!.docs[index]
                                    .data() as Map<String, dynamic>),
                                context));
              },
            ))),
        SizedBox(height: 15.0)
      ],
    );
  }

  Widget _buildCard(CarModel car, context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VoitureDetail(
                    car: car,
                    client: client,
                  )));
        },
        child: Container(
            width: 200,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0)
              ],
            ),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Matricule : ",
                          style: TextStyle(
                              color: car.isfree
                                  ? Color(0xff1ab696)
                                  : Color(0xfff77b7b)),
                        ),
                        Text(car.matricule,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: car.isfree
                                    ? Color(0xff1ab696)
                                    : Color(0xfff77b7b)))
                      ])),
              Hero(
                  tag: car.matricule,
                  child: Container(
                      height: 100,
                      width: 100.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(car.photo),
                              fit: BoxFit.fill)))),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'Varela',
                            fontSize: 12.0)),
                    Text(
                        '${car.marque.toUpperCase()} ${car.modele.toUpperCase()}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'Varela',
                            fontSize: 12.0)),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        color: Color(int.parse(car.couleur)),
                      ),
                    )
                  ],
                ),
              ),
            ])));
  }

  noGarage() {
    return Card(
      color: Colors.white,
      child: Container(
        height: 100,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.car_rental,
              color: Colors.black,
              size: 40,
            ),
            Text(
              "Veuillez ajouter une voiture à votre garage.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
