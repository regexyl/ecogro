import 'package:ecogro/utils/authentication.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecogro/utils/authentication.dart';
import 'package:ecogro/widgets/tab_menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _uid;
  Future<String> _getCurrentUID() async {
    final uid = await context.read<AuthenticationService>().getCurrentUID();
    setState(() {
      _uid = uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(_uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Scaffold(
              body: Container(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Column(children: [
                    Container(
                      height: 80.0,
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Hi, ${data['name']}!',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w700)),
                      ],
                    )),
                    Container(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'IN YOUR PANTRY',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                    Container(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [TabMenu(['Urgent', 'Standby', 'Forgotten'])],
                    ),
                    
                    Container(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'GOOD DEALS TO CHECK OUT',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                    Container(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [TabMenu(['Wellcome', "PARKnSHOP", 'Marketplace'])],
                    ),
                  ])));
        }

        return Text("loading");
      },
    );
  }
}
