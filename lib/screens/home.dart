import 'package:english_4000_hours/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:english_4000_hours/services/authentication.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final String? uid;
  late final String? email;

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser?.uid;
    email = FirebaseAuth.instance.currentUser?.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${email?.split("@").first.toUpperCase()}'),
          actions: [
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.logout,
                  semanticLabel: 'Logout',
                ),
              ),
              onTap: () async {
                bool sucess =
                    await FirebaseAuthentication.authenticate.signOut();
                sucess
                    ? Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                        (route) => false)
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('An error occured while signing out'),
                        ),
                      );
              },
            ),
          ],
        ),
        body: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User ID: $uid',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Email: $email',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
