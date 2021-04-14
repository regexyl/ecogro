import 'package:flutter/material.dart';
import 'package:ecogro/login.dart';
import 'package:ecogro/navbar.dart';
import 'package:ecogro/utils/constants.dart';

class RegistrationSuccess extends StatelessWidget {
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
              icon: Icon(
                Icons.arrow_back,
                color: Constants.primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          Container(height: 170.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Constants.primaryColor, size: 120.0,),
            ],
          ),
          Container(height: 30.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'You have created\nan account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    height: 1
                  ),
                )
              )
            ],
          ),
          Container(height: 30.0,),
          ElevatedButton(
            onPressed: () { Navigator.push(
              context,
                MaterialPageRoute(builder: (context) => NavBar())
              );
            }, 
            child: Text('Log in', style: TextStyle(fontSize: 20.0,),),
            style: ElevatedButton.styleFrom(primary: Constants.primaryColor),
          ),
        ],
      ),
    );
  }
}
