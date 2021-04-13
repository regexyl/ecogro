import 'package:ecogro/utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ecogro/pages/home.dart';
import 'package:ecogro/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:ecogro/widgets/input_widget.dart';
import 'package:ecogro/widgets/primary_button.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Container(
      child: Column(
        children: [
          InputWidget(
            hintText: "Email",
            suffixIcon: FlutterIcons.mail_oct,
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
            height: 25.0,
          ),
          PrimaryButton(
            text: "Login",
            onPressed: () {
              // Helper.nextPage(context, Home()); // original template directs user to homepage
              context.read<AuthenticationService>().signIn(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
            },
          )
        ],
      ),
    );
  }
}
