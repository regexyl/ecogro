import 'package:flutter/material.dart';
import 'package:ecogro/utils/constants.dart';
import 'package:ecogro/registration_success.dart';
import 'package:ecogro/widgets/registration_form.dart';

class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Registration'),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back, color: Constants.primaryColor,),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(36),
        child: Stack(
          children: [
            RegistrationForm(),
          ],
        ),
      ),
    );
  }
}
