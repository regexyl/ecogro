import 'package:ecogro/utils/authentication.dart';
import 'package:ecogro/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecogro/widgets/tab_menu.dart';
import 'package:ecogro/widgets/item_card.dart';
import 'package:ecogro/widgets/ad_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Save user ID to state
  @override
  void initState() {
    super.initState();
     _getCurrentUID(context);
  }

  // Get current user ID
  String _uid;
  Future<String> _getCurrentUID(BuildContext context) async {
    final uid = await context.read<AuthenticationService>().getCurrentUID();
    setState(() {
      _uid = uid;
    });
    return uid;
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
                    // All widgets below are vertically scrollable
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
                      children: [
                        TabMenu(['Urgent', 'These can wait', 'Forgotten'])
                      ],
                    ),
                    Container(
                      height: 14.0,
                    ),
                    ItemCard(),
                    Container(
                      height: 32.0,
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
                      children: [
                        TabMenu(['All', 'Wellcome', "PARKnSHOP", 'Market Place'])
                      ],
                    ),
                    Container(
                      height: 14.0,
                    ),
                    AdCard(),
                  ])));
        }

        return LoadScreen();
      },
    );
  }
}
