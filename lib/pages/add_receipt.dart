import 'dart:io';

import 'package:ecogro/pages/add_item.dart';
import 'package:ecogro/pages/details_screen.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: 'test@gmail.com', password: '123456');
  runApp(MaterialApp(
    home: AddReceipt(),
  ));
}

class AddReceipt extends StatefulWidget {
  @override
  _AddReceiptState createState() => _AddReceiptState();
}

class _AddReceiptState extends State<AddReceipt> {
  File pickedImage;
  var imageFile;

  var result = '';

  bool isImageLoaded = false;

  static const List<String> menuItems = [
    'Scan Reciept',
    'Scan Item',
    'Add Manually'
  ];

  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map((String value) =>
          PopupMenuItem<String>(value: value, child: Text(value)))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ecogro Add',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        // child: PopupMenuButton<String>(
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(10.0))),
        //     offset: const Offset(-45, -200),
        //     icon: Icon(
        //       Icons.add_circle_rounded,
        //     ),
        //     iconSize: 60,
        //     itemBuilder: (BuildContext context) => _popUpMenuItems,
        //     onSelected: (String newValue) {
        //       if (newValue == 'Add Manually') {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => AddItemScreen(),
        //             settings: RouteSettings(arguments: newValue),
        //           ),
        //         );
        //       } else {
        //         _optionsDialogBox();
        //       }
        //     }),
      ),
    );
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 100),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: new SingleChildScrollView(
                child: new ListBody(
              children: <Widget>[
                TextButton(
                  child: const Text(
                    'With camera',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () => {getImage('camera')},
                ),
                TextButton(
                  child: const Text(
                    'From gallery',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () => {getImage('gallery')},
                ),
              ],
            )),
          );
        });
  }

  getImage(String imageSource) async {
    var tempStore = await ImagePicker().getImage(
        source:
            imageSource == 'camera' ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
    });
  }

  // Future<http.Response> fetchReceiptDetails() {
  //   var url = Uri.parse('https://example.com/whatsit/create');
  //   var response =
  //       await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  // }

  // readTextFromImage() async {
  //   result = '';
  //   FirebaseVisionImage imageToRead = FirebaseVisionImage.fromFile(pickedImage);
  //   TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();
  //   VisionText readText = await recognizer.processImage(imageToRead);

  //   for (TextBlock block in readText.blocks) {
  //     for (TextLine line in block.lines) {
  //       for (TextElement word in line.elements) {
  //         setState(() {
  //           result = result + ' ' + word.text;
  //         });
  //       }
  //     }
  //   }
  // }
}
