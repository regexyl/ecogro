import 'dart:io';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String selectedOption = '';

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

  File pickedImage;
  var imageFile;

  var result = '';

  bool isImageLoaded = false;

  getImageFromGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
    });
  }

  getImageFromCamera() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
    });
  }

  // readTextFromImage() async {
  //   result = '';
  //   FirebaseVisionImage imageToRead = FirebaseVisionImage.fromFile(pickedImage);
  //   TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();
  //   VisionText readText = await recognizer.processImage(imageToRead);

  //   for (TextBlock block in readText.blocks) {
  //     for (TextLine line in block.lines) {
  //       for (TextElement word in line.elements) {
  //         setState(() {
  //           setState(() {
  //             result = result + ' ' + word.text;
  //           });
  //         });
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    selectedOption = ModalRoute.of(context).settings.arguments.toString();
    Widget _buildRow(int idx) {
      return ListTile(
        title: Text('$typeItems[idx]'),
        onTap: () {
          setState(() {
            itemType = typeItems[idx];
          });
        },
      );
    }

    Widget setupTypeDialogContainer() {
      return Container(
        child: ListView.builder(
          itemCount: typeItems.length,
          itemBuilder: (context, index) {
            return _buildRow(index);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
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
                isImageLoaded
                    ? Center(
                        child: Container(
                        height: 250.0,
                        width: 250.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(pickedImage),
                                fit: BoxFit.cover)),
                      ))
                    : Container(),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(result),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child:
                        TextButton(onPressed: () => {}, child: Text('Prev'))),
                Expanded(
                    child:
                        TextButton(onPressed: () => {}, child: Text('Next'))),
              ],
            ),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Add'),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Save'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: readTextFromImage,
      //   child: Icon(Icons.check),
      // ),
    );
  }
}
