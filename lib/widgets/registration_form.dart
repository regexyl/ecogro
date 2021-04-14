import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:ecogro/login.dart';
import 'package:ecogro/navbar.dart';
import 'package:ecogro/utils/authentication.dart';
import 'package:ecogro/widgets/input_widget.dart';
import 'package:ecogro/widgets/primary_button.dart';

class RegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Container(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Create your\nEcoGro account.',
              style: TextStyle(fontSize:38.0,height: 1.3,fontWeight: FontWeight.w800),)
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          InputWidget(
            hintText: "Name",
            controller: nameController,
          ),
          SizedBox(
            height: 25.0,
          ),
          InputWidget(
            hintText: "Email",
            controller: emailController,
          ),
          SizedBox(
            height: 15.0,
          ),
          InputWidget(
            hintText: "Password",
            obscureText: true,
            controller: passwordController,
          ),
          SizedBox(
            height: 50.0,
          ),
          PrimaryButton(
            text: "Create account",
            onPressed: () {
              // signUp automatically logs user in after account creation
              context.read<AuthenticationService>().signUp(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavBar())
              );
            },
          )
        ]));
  }
}
