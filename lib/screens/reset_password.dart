import 'package:english_4000_hours/services/authentication.dart';
import 'package:english_4000_hours/screens/home.dart';
import 'package:english_4000_hours/screens/register.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailAddressController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFF283593),
            Color(0xFF3949AB),
            Color(0xFF3F51B5)
          ], begin: Alignment.topLeft, end: Alignment.centerRight)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 36.0, horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Reset Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Send an email to reset password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: emailAddressController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            label: const Text('Email Address'),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40.0,
                          child: ElevatedButton(
                            onPressed: () {
                              FirebaseAuthentication.authenticate
                                  .resetPassword(emailAddressController.text);
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Send Email',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.indigo),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              //Navigate to Reset Password
                              Navigator.of(context).pop();
                            },
                            child: const Text('Back to login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
