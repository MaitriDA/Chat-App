import 'package:baatein/screens/homePage.dart';
import 'package:baatein/screens/setProfile.dart';
import 'package:baatein/utils/landingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication/authService.dart';
import 'authentication/firebaseAuthService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => FirebaseAuthService(),
      dispose: (_, AuthService authService) => authService.dispose(),
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xFF0C2637),
            fontFamily: "Montserrat",
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => LandingPage(),
          "/home": (context) => HomePage(),
          "/setProfile": (context) => SetProfile()
        },
      ),
    );
  }
}
