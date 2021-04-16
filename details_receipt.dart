import 'package:cloud_firestore/cloud_firestore.dart';

import 'package_firestore/cloud_firestore.dart';
import 'package:ecogro/item.dart';
import 'package:flutter/material.dart';
import 'package:ecogro/utils/constants.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class ReceiptDetails extends StatefulWidget {
  List<Item> totalItems;
  ReceiptDetails({@required this.totalItems});
  @override
  _ReceiptDetailsState createState({}) => _ReceiptDetailsState();
}

class _ReceiptDetailsState extends State<ReceiptDetails> {
  List<Item> totalItems;
  final pDateFormat = new DateFormat('yyyy/MM/dd');
  String storeName = "";
  DateTime purchaseDate = new DateTime.now();

  _ReceiptDetailsState({@required this.totalItems});

  CollectionReference items = FirebaseFirestore.instance.collection('items');

  Future<void> addDataToFirestore(Item item) async {
    // return items
    //     .add({
    //       'store': item.storeName,
    //       'purchaseDate': item.purchaseDate,
    //       'status': 'UNFINISHED',
    //       'name': item.itemName,
    //       'item': item.itemName,
    //       'type': item.itemType,
    //       'uid': item.itemName,

    //       /// to be added
    //       'store': item.storeName,
    //       'quantity': item.itemName,

    //       /// to be added
    //       'expiryDate': item.expiryDate,
    //     })
    //     .then((value) => print("User Added"))
    //     .catchError((error) => print('Failed to add item: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Colors.white,
        ),
        body: Column(children: <Widget>[
          TextField(
            //For Store Name
            controller: TextEditingController()
              ..text = totalItems.isEmpty ? null : totalItems[0].storeName,
            keyboardType: TextInputType.text,
            //style: Theme.of(context).textTheme.headline6,
            decoration: InputDecoration(
                labelText: 'Store',
                errorText:
                    storeName == '' ? 'Please enter a store name.' : null,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            onChanged: (String val) {
              setState(() => {storeName = val});
              for (var i = 0; i < totalItems.length; i++) {
                totalItems[i].storeName = val;
              }
            },
          ),
          ListTile(
            title: TextField(
              controller: TextEditingController()
                ..text = pDateFormat.format(purchaseDate),
              enabled: false,
              decoration: InputDecoration(
                  labelText: 'Purchase Date',
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
            trailing: IconButton(
              iconSize: 40.0,
              icon: Expanded(
                  child: Icon(
                Icons.date_range,
                color: Theme.of(context).primaryColor,
              )),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2025),
                ).then((DateTime value) {
                  if (value != null) {
                    setState(() => {purchaseDate = value});
                    for (var i = 0; i < totalItems.length; i++) {
                      totalItems[i].purchaseDate = value;
                    }
                  }
                });
              },
            ),
          ),
          ListView.builder(
            itemCount: totalItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text('$totalItems[index].name'),
                  subtitle: Text(
                      'Expected expiry date: $totalItems[index].expiryDate'),
                  trailing: Expanded(
                    child: IconButton(
                      iconSize: 40.0,
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        //Change to add_item part
                      },
                    ),
                  ));
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Constants.primaryColor,
              ),
              onPressed: () {
                //addDataToFirestore();
                //addNewItem();
              },
              child: Text('Add'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Constants.primaryColor,
              ),
              onPressed: () {
                for (var i = 0; i < totalItems.length; i++) {
                  addDataToFirestore(totalItems[i]);
                }
                //addDataToFirestore();
                Navigator.pop(context, 'Back');
              },
              child: Text('Save'),
            ),
          ),
        ]));
  }
}
