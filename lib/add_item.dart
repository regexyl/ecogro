import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ecogro/utils/constants.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String selectedOption = '';

  //final databaseRef = Firestore.instance();

  final pDateFormat = new DateFormat('yyyy/MM/dd');

  //Item input
  String storeName;
  DateTime purchaseDate = DateTime.now();
  int exDay = 3;
  DateTime expiryDate = DateTime.now().add(Duration(days: 3));
  String itemName;
  String itemType;

  List<String> itemList = [];

  static const List<String> typeItems = [
    'Bread & Bakery',
    'Fruits',
    'Frozen Foods',
    'Grains, Pasta & Sides',
    'Meat & Seafood',
    'Vegetables',
    'Others',
  ];

  final List<PopupMenuItem<String>> _popUpTypeItems = typeItems
      .map((String value) =>
          PopupMenuItem<String>(value: value, child: Text(value)))
      .toList();

  void addDataToFirestore() async {
    // await databaseRef.collection('items').document().setData({
    //   'store': storeName,
    //   'purchaseDate': purchaseDate,
    //   'status': 'UNFINISHED',
    //   'name': itemName,
    //   'item': itemName,
    //   'type': itemType,
    // });
  }

  void addNewItem() {
    setState(() {
      itemName = null;
      itemType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedOption = ModalRoute.of(context).settings.arguments.toString();
    //final firebaseUser = context.watch<User>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  title: TextField(
                    //For Store Name
                    keyboardType: TextInputType.text,
                    //style: Theme.of(context).textTheme.headline6,
                    decoration: InputDecoration(
                        labelText: 'Store',
                        errorText: storeName == ''
                            ? 'Please enter a store name.'
                            : null,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    onChanged: (String val) {
                      setState(() => {storeName = val});
                    },
                  ),
                ),

                ListTile(
                  title: TextField(
                    controller: TextEditingController()
                      ..text = pDateFormat.format(purchaseDate),
                    enabled: false,
                    decoration: InputDecoration(
                        labelText: 'Purchase Date',
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
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
                      ).then((DateTime value) => {
                            if (value != null)
                              {
                                setState(() => {purchaseDate = value})
                              }
                          });
                    },
                  ),
                ),

                ListTile(
                  title: TextField(
                    //For Item Name
                    keyboardType: TextInputType.text,
                    //style: Theme.of(context).textTheme.headline6,
                    decoration: InputDecoration(
                        labelText: 'Item Name',
                        errorText: itemName == ''
                            ? 'Please enter an item name.'
                            : null,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    onChanged: (String val) {
                      setState(() => {itemName = val});
                    },
                  ),
                ),

                // TextField with dropdown list
                ListTile(
                  title: TextField(
                    controller: TextEditingController()..text = itemType,
                    decoration: InputDecoration(
                      labelText: 'Item Type',
                      hintText: 'Please input or select a type.',
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      suffixIcon: PopupMenuButton<String>(
                        icon: const Icon(Icons.arrow_drop_down),
                        onSelected: (String value) {
                          setState(() {
                            itemType = value;
                          });
                        },
                        itemBuilder: (BuildContext context) => _popUpTypeItems,
                      ),
                    ),
                  ),
                ),
                ListTile(
                    title: TextField(
                      controller: TextEditingController()
                        ..text = pDateFormat.format(expiryDate),
                      enabled: false,
                      decoration: InputDecoration(
                          labelText: 'Expiry Date',
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)))),
                    ),
                    trailing: Expanded(
                      child: IconButton(
                        iconSize: 40.0,
                        icon: Icon(
                          Icons.date_range,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2025),
                          ).then((DateTime value) => {
                                if (value != null)
                                  {
                                    setState(() => {expiryDate = value})
                                  }
                              });
                        },
                      ),
                    )),
                SizedBox(height: 100),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Constants.primaryColor,
              ),
              onPressed: () {
                addDataToFirestore();
                addNewItem();
              },
              child: Text('Add'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Constants.primaryColor,
              ),
              onPressed: () => {
                //addDataToFirestore();
                Navigator.pop(context, 'Back')
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
