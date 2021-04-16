import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ecogro/utils/constants.dart';
import 'package:ecogro/pages/add_receipt.dart';
import 'package:ecogro/pages/home.dart';
import 'package:ecogro/pages/profile.dart';
import 'package:ecogro/pages/records.dart';
import 'package:ecogro/pages/rewards.dart';
import 'package:ecogro/pages/add_item.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

    int currentTab = 0;
    final List<Widget> screens = [
      Home(),
      RecordsList(),
      AddReceipt(),
      Rewards(),
      Profile(),
    ];

    final PageStorageBucket bucket = PageStorageBucket();
    Widget currentScreen = Home();

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
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: Container(
          width: 70,
          height: 70,
          child: (
            // FloatingActionButton(
            //   child: Icon(Icons.add, size: 30.0,),
            //   backgroundColor: Constants.primaryColor,
            //   onPressed: () {},
            // )
            PopupMenuButton<String>(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            offset: const Offset(-45, -200),
            icon: Icon(
              Icons.add_circle_rounded,
            ),
            iconSize: 60,
            itemBuilder: (BuildContext context) => _popUpMenuItems,
            onSelected: (String newValue) {
              if (newValue == 'Add Manually') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItemScreen(),
                    settings: RouteSettings(arguments: newValue),
                  ),
                );
              } else {
                _optionsDialogBox();
              }
            })),
          ),
        
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 66,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 76,
                      onPressed: () {
                        setState(() {
                          currentScreen = Home();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            currentTab == 0 ? Icons.home : Icons.home_outlined,
                            color: currentTab == 0 ? Constants.primaryColor : Colors.grey,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 76,
                      onPressed: () {
                        setState(() {
                          currentScreen = RecordsList();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            currentTab == 1 ? Icons.list_alt : Icons.list_alt_outlined,
                            color: currentTab == 1 ? Constants.primaryColor : Colors.grey,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 76,
                    ),
                    MaterialButton(
                      minWidth: 76,
                      onPressed: () {
                        setState(() {
                          currentScreen = Rewards();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            currentTab == 2 ? Icons.card_giftcard : Icons.card_giftcard_outlined,
                            color: currentTab == 2 ? Constants.primaryColor : Colors.grey,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 76,
                      onPressed: () {
                        setState(() {
                          currentScreen = Profile();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            currentTab == 3 ? Icons.person : Icons.person_outline,
                            color: currentTab == 3 ? Constants.primaryColor : Colors.grey,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
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
  }