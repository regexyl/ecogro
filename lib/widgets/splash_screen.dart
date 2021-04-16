import 'package:flutter/material.dart';
import 'package:ecogro/utils/constants.dart';

class LoadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ecogro_logo_white.png',
              width: 200,
            ),
            
          ],
        ),
      ),
    );
  }
}