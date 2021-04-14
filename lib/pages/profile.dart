import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecogro/utils/authentication.dart';
import 'package:ecogro/utils/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Profile Screen', style: TextStyle(fontSize: 40)),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text('Sign out'),
              style: ElevatedButton.styleFrom(primary: Constants.primaryColor),
            )
          ],
        )
      )
    );
  }
}