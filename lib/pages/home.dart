import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecogro/utils/constants.dart';
import 'package:ecogro/widgets/home_page_one.dart';
import 'package:ecogro/widgets/home_page_three.dart';
import 'package:ecogro/widgets/home_page_two.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int current = 0;

  void nextPage() {
    setState(() {
      current += 1;
    });
  }

  void prevPage() {
    setState(() {
      current -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePageOne(nextPage: nextPage, prevPage: prevPage),
      HomePageTwo(nextPage: nextPage, prevPage: prevPage),
      HomePageThree(nextPage: nextPage, prevPage: prevPage),
    ];

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: current > 0
            ? GestureDetector(
                onTap: () {
                  this.prevPage();
                },
                child: Icon(FlutterIcons.keyboard_backspace_mdi),
              )
            : null,
        iconTheme: IconThemeData(
          color: Constants.primaryColor,
        ),
      ),
      backgroundColor: current == 0 ? Constants.primaryColor : Colors.white,
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: pages[current],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
           icon: new Icon(Icons.home),
           label: 'Home',
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.list_alt),
           label: 'Record',
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.add_circle),
           label: 'Add'
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.card_giftcard),
           label: 'Rewards'
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.person),
           label: 'Profile'
         ),
        ],
        selectedItemColor: Constants.primaryColor,
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
