// import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';
import 'package:ecogro/pages/add_item.dart';
import 'package:ecogro/pages/details_screen.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: 'test@gmail.com', password: '123456');
  runApp(MaterialApp(
    home: AddReceipt(),
  ));
}

const String clientId = 'vrfBezyMF2y9af6cOaYNwjnVw0dRPmX1jmp1OuD';
const String username = '2373942064';
const String apiKey = 'b57637ada1ec402aced9f780ff18ceb9';
const String url = 'https://api.veryfi.com/api/v7/partner/documents/';

const categories = [
  "Office Expense",
  "Meals & Entertainment",
  "Utilities",
  "Automobile"
];

var header = {
  "Accept": "application/json",
  "CLIENT-ID": clientId,
  "AUTHORIZATION": "apikey $username:$apiKey"
};

// Upload receipt
// upload(File imageFile) async {
//   // open a bytestream
//   var stream =
//       new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//   // get file length
//   var length = await imageFile.length();

//   // string to uri
//   var uri = Uri.parse('https://api.veryfi.com/api/v7/partner/documents/');

//   // create multipart request
//   var request = new http.MultipartRequest("POST", uri)
//     ..fields['Accept'] = 'application/json'
//     ..fields['CLIENT-ID'] = clientId
//     ..fields['AUTHORIZATION'] = "apikey $username:$apiKey"
//     ..files.add(await http.MultipartFile.fromPath(
//       'package', 'build/package.tar.gz',
//       contentType: MediaType('application', 'x-tar')));

//   // multipart that takes file
//   var multipartFile = new http.MultipartFile('file', stream, length,
//       filename: basename(imageFile.path));

//   // add file to multipart
//   request.files.add(multipartFile);

//   // send
//   var response = await request.send();
//   print(response.statusCode);

//   // listen for response
//   response.stream.transform(utf8.decoder).listen((value) {
//     print(value);
//   });
// }

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

  Future<void> _optionsDialogBox(context) {
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
                  onPressed: () {
                    print('Testing');
                    getImage('gallery');
                  },
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

    await fetchReceiptDetails(pickedImage);
  }

  Future<dynamic> fetchReceiptDetails(File pickedImage) async {
    final payload = {
      'file_name': basename(pickedImage.path),
      'file_url': pickedImage.path,
      'categories': categories
    };
    final response = await http.post(Uri.parse(url), body: payload);
    print(response);
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
