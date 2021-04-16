import 'dart:io';
import 'package:ecogro/widgets/primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ecogro/utils/constants.dart';
import 'package:ecogro/utils/authentication.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String selectedOption = '';
  final pDateFormat = new DateFormat('yyyy/MM/dd');

  @override
  void initState() {
    super.initState();
    _getCurrentUID(context);
  }

  String _uid;
  Future<String> _getCurrentUID(BuildContext context) async {
    final uid = await context.read<AuthenticationService>().getCurrentUID();
    setState(() {
      _uid = uid;
    });
    return uid;
  }

  //Item input
  String uid;
  String store;
  DateTime purchaseDate = DateTime.now();
  int exDay = 3;
  DateTime expiryDate = DateTime.now().add(Duration(days: 3));
  String item;
  String name;
  int quantity;

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

  CollectionReference items = FirebaseFirestore.instance.collection('items');

  Future<void> addItem() {
    return items.add({
      'uid': _uid,
      'name': name,
      'item': item,
      'quantity': quantity,
      'purchaseDate': purchaseDate,
      'expiryDate': expiryDate,
      'store': store,
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedOption = ModalRoute.of(context).settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
        backgroundColor: Colors.white,
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
                        errorText:
                            store == '' ? 'Please enter a store name.' : null,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    onChanged: (String val) {
                      setState(() => {store = val});
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
                        errorText:
                            name == '' ? 'Please enter an item name.' : null,
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    onChanged: (String val) {
                      setState(() => {name = val});
                    },
                  ),
                ),

                // TextField with dropdown list
                ListTile(
                  title: TextField(
                    controller: TextEditingController()..text = item,
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
                            item = value;
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
            PrimaryButton(
            text: "Add",
            onPressed: () {
              addItem();
            }),
            Container(height: 14),
            PrimaryButton(
            text: "Save",
            onPressed: () => {
              Navigator.pop(context, 'Back')
            },
          )
          ],
        ),
      ),
    );
  }
}
