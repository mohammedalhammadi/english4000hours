import 'package:english_4000_hours/services/authentication.dart';
import 'package:english_4000_hours/screens/home.dart';
import 'package:english_4000_hours/screens/register.dart';
import 'package:english_4000_hours/screens/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  RegExp emailFormat = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'English4000Hours',
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter your username or email';
                              } else if (!emailFormat.hasMatch(value)) {
                                return 'this is not a valid email format';
                              }
                              return null;
                            },
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
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'password should be atleast 6 characters';
                              }
                              return null;
                            },
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              label: const Text('Password'),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                //Navigate to Reset Password
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ResetPassword(),
                                  ),
                                );
                              },
                              child: const Text('Forgot Password'),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  bool authenticUser =
                                      await FirebaseAuthentication.authenticate
                                          .signInWithEmail(
                                              emailAddressController.text,
                                              passwordController.text);
                                  authenticUser
                                      ? Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                          (route) => false,
                                        )
                                      : ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              'Entered email or password is not correct',
                                            ),
                                          ),
                                        );
                                }
                              },
                              child: const Text(
                                'Login',
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
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const Text("Don't have and account? "),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Register(),
                                      ),
                                    );
                                  },
                                  child: const Text('Register'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            child: InkWell(
                              onTap: () {},
                              child: Ink(
                                color: const Color(0xFFFFFFFF),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Container(
                                          constraints: const BoxConstraints(
                                            maxHeight: 30.0,
                                            maxWidth: 30.0,
                                          ),
                                          child: Image.asset(
                                              'assets/images/Google_G_Logo.png')),
                                      const SizedBox(width: 12),
                                      const Text(
                                        'Sign in with Google',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onTap: () async {
                              UserCredential userCredential =
                                  await FirebaseAuthentication.authenticate
                                      .signInWithGoogle();
                              String user = userCredential.toString();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(userCredential.user!.uid),
                                duration: const Duration(seconds: 2),
                              ));
                              userCredential.additionalUserInfo;
                            },
                          ),
                        ],
                      ),
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
