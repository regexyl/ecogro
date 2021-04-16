import 'package:flutter/material.dart';
import 'package:ecogro/registration.dart';
import 'package:ecogro/utils/constants.dart';
import 'package:ecogro/widgets/login_form.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment(0, 1),
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/cauliflower.png"),
                  ),
                ),
              ),
              Positioned(
                bottom: 80.0,
                width: size.width,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Not sure of\nwhat's in the\nfridge?",
                              style: TextStyle(
                                height: 1.2,
                                fontSize: 44.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      LoginForm(),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 22.0),
                          child: TextButton(
                            child: Text(
                              'Create an account.',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Constants.primaryColor
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => Registration())
                                );
                            }
                          ),
                        ),
                      )
                    ]),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
