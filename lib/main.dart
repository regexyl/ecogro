import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecogro/pages/request_service_flow.dart';
import 'package:ecogro/utils/constants.dart';
import 'package:ecogro/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        // if (snapshot.hasError) {
        //   return SomethingWentWrong();
        // }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ScreenUtilInit(
            designSize: Size(375, 812),
            //allowFontScaling: false,
            builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: Constants.primaryColor,
                scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 1),
                visualDensity: VisualDensity.adaptivePlatformDensity,
                textTheme: GoogleFonts.openSansTextTheme(),
              ),
              initialRoute: "/",
              onGenerateRoute: _onGenerateRoute,
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        // return Loading();
      },
    );
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
        return RequestServiceFlow();
      });
    default:
      return MaterialPageRoute(builder: (BuildContext context) {
        return Login();
      });
  }
}
