import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecogro/utils/authentication.dart';
import 'package:ecogro/utils/constants.dart';

class ItemCard extends StatefulWidget {
  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  final String ellipseBottomSVG = 'assets/svg/ellipse_bottom.svg';
  final String ellipseTopSVG = 'assets/svg/ellipse_top.svg';

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
    CollectionReference items = FirebaseFirestore.instance.collection('items');


    return FutureBuilder<QuerySnapshot>(
        future: items.where('uid', isEqualTo: _uid).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<Map<String, dynamic>> cards = [];
            cards = snapshot.data.docs.map((doc) => doc.data()).toList();

            return Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(right: 6),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    // height: 199,
                    width: 344,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Constants.primaryColor,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0,
                          right: -5,
                          child: SvgPicture.asset(
                            ellipseBottomSVG,
                            color: Colors.white60,
                          ),
                        ),
                        Positioned(
                          top: -2,
                          right: 0,
                          child: SvgPicture.asset(
                            ellipseTopSVG,
                            color: Constants.yellowColor,
                            height: 80,
                          ),
                        ),
                        Positioned(
                          // Name of item
                          left: 24,
                          top: 22,
                          child: Text(
                            '${cards[index]['name']}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Positioned(
                          // Quantity left
                          left: 24,
                          top: 50,
                          child: Text('Quantity: ${cards[index]['quantity']}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        ),
                        Positioned(
                          // Store purchased at
                          left: 24,
                          top: 88,
                          child: Text('${cards[index]['store']}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                        Positioned(
                          // Date of purchase
                          left: 24,
                          top: 110,
                          child: Text(
                              'Bought on ${DateFormat('yyyy-MM-dd').format(DateTime.parse(cards[index]['purchaseDate'].toDate().toString()))}',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                        Positioned(
                          // Days left to expiry
                          right: 26,
                          top: 4,
                          child: Text(
                            '${DateTime.parse(cards[index]['expiryDate'].toDate().toString()).difference(DateTime.now()).inDays}',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w900),
                          ),
                        ),
                        Positioned(
                            // Text - 'DAY/DAYS LEFT'
                            right: 20,
                            top: 34,
                            child: Text(
                                (DateTime.parse(cards[index]['expiryDate']
                                                .toDate()
                                                .toString())
                                            .difference(DateTime.now())
                                            .inDays ==
                                        1
                                    ? 'DAY\nLEFT'
                                    : 'DAYS\nLEFT'),
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w900),
                                textAlign: TextAlign.center)),
                        Positioned(
                            // Item image
                            right: 24,
                            bottom: 24,
                            child: SvgPicture.asset('assets/svg/${cards[index]['item']}.svg', height: 80,)
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Text("Loading");
        });
  }
}
