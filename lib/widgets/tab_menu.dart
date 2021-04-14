import 'package:flutter/material.dart';
import 'package:ecogro/utils/constants.dart';

class TabMenu extends StatelessWidget {
  final String tab1;
  final String tab2;
  final String tab3;

  TabMenu(this.tab1, this.tab2, this.tab3);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: TabBar(
                unselectedLabelColor: Constants.primaryColor,
                labelStyle: TextStyle(fontSize: 16),
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Constants.primaryColor),
                // The following tabs should be dynamically generated, not hard-coded!
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Constants.primaryColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('$tab1'),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Constants.primaryColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('$tab2',),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Constants.primaryColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('$tab3'),
                      ),
                    ),
                  ),
                ]),
          ),
        );
  }
}
