import 'package:flutter/material.dart';
import 'package:ecogro/utils/constants.dart';

class TabMenu extends StatelessWidget {
  final List<String> _tabs;

  TabMenu(this._tabs);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabs.length,
        child: TabBar(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 4,
              color: Constants.primaryColor,
            ),
            insets: EdgeInsets.only(
              left: 0,
              right: 14,
              bottom: 4)),
            isScrollable: true,
            labelPadding: EdgeInsets.only(left: 0, right: 16),
            tabs: _tabs
              .map((label) => 
              Tab(child: Text('$label', style: TextStyle(fontSize: 16),),)
            )
          .toList(),
        ),

        );
  }
}
