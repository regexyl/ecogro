import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String selectedOption = '';

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

  readTextFromImage() async {
    result = '';
    FirebaseVisionImage imageToRead = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizer = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizer.processImage(imageToRead);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            setState(() {
              result = result + ' ' + word.text;
            });
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedOption = ModalRoute.of(context).settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedOption),
        actions: [
          ElevatedButton(
            onPressed: getImageFromGallery,
            child: Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 100),
          isImageLoaded
              ? Center(
                  child: Container(
                  height: 250.0,
                  width: 250.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(pickedImage), fit: BoxFit.cover)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: readTextFromImage,
        child: Icon(Icons.check),
      ),
    );
  }
}
