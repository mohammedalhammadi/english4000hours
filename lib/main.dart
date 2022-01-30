import 'package:english_4000_hours/screens/home.dart';
import 'package:english_4000_hours/screens/register.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/register': (context) => const Register(),
        // '/resetPassword': (const) => const ResetPassword(),
        '/home': (context) => const HomePage(),
      },
      // home: const Login(),
    );
  }
}
