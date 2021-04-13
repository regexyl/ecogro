import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecogro/utils/constants.dart';
import 'package:ecogro/pages/login.dart';
import 'package:ecogro/utils/authentication.dart';
import 'package:ecogro/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        //allowFontScaling: false,
        // Add providers
        builder: () => MultiProvider(
              providers: [
                Provider<AuthenticationService>(
                  create: (_) => AuthenticationService(FirebaseAuth.instance),
                ),
                StreamProvider(
                  create: (context) =>
                      context.read<AuthenticationService>().authStateChanges,
                )
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primaryColor: Constants.primaryColor,
                  scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 1),
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: GoogleFonts.openSansTextTheme(),
                ),
                home: AuthenticationWrapper(),
                // initialRoute: "/",
                // onGenerateRoute: _onGenerateRoute,
              ),
            ));
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Login();
      });
    case "/repair-flow":
      return MaterialPageRoute(builder: (BuildContext context) {
        return Home();
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return Login();
      });
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>(); // listen for user
    if (firebaseUser != null) {
      return Home();
    }
    return Login();
  }
}
