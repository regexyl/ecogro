import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecogro/utils/constants.dart';
import 'package:ecogro/pages/add_receipt.dart';
import 'package:ecogro/pages/home.dart';
import 'package:ecogro/pages/profile.dart';
import 'package:ecogro/pages/records.dart';
import 'package:ecogro/pages/rewards.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

    int currentTab = 0;
    final List<Widget> screens = [
      Home(),
      Records(),
      AddReceipt(),
      Rewards(),
      Profile(),
    ];

    final PageStorageBucket bucket = PageStorageBucket();
    Widget currentScreen = Home();

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
            FloatingActionButton(
              child: Icon(Icons.add, size: 30.0,),
              backgroundColor: Constants.primaryColor,
              onPressed: () {},
            )
          )
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                          currentScreen = Records();
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
  }

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   int current = 0;

//   void nextPage() {
//     setState(() {
//       current += 1;
//     });
//   }

//   void prevPage() {
//     setState(() {
//       current -= 1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     int _selectedIndex = 0;

//     List<Widget> pages = [
//       HomePageOne(nextPage: nextPage, prevPage: prevPage),
//       HomePageTwo(nextPage: nextPage, prevPage: prevPage),
//       HomePageThree(nextPage: nextPage, prevPage: prevPage),
//     ];

//     void _onItemTapped(int index) {
//       setState(() {
//         _selectedIndex = index;
//       });
//     }

//     return Scaffold(
//       appBar: AppBar(
//         brightness: Brightness.dark,
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         leading: current > 0
//             ? GestureDetector(
//                 onTap: () {
//                   this.prevPage();
//                 },
//                 child: Icon(FlutterIcons.keyboard_backspace_mdi),
//               )
//             : null,
//         iconTheme: IconThemeData(
//           color: Constants.primaryColor,
//         ),
//       ),
//       backgroundColor: current == 0 ? Constants.primaryColor : Colors.white,
//       body: AnimatedSwitcher(
//         duration: Duration(milliseconds: 300),
//         child: pages[current],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 0,
//         items: [
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: new Icon(Icons.list_alt),
//             label: 'Record',
//           ),
//           BottomNavigationBarItem(
//               icon: new Icon(Icons.add_circle), label: 'Add'),
//           BottomNavigationBarItem(
//               icon: new Icon(Icons.card_giftcard), label: 'Rewards'),
//           BottomNavigationBarItem(
//               icon: new Icon(Icons.person), label: 'Profile'),
//         ],
//         selectedItemColor: Constants.primaryColor,
//         unselectedItemColor: Colors.grey[760],
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//       ),
//     );
//   }
// }
