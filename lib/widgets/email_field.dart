import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required this.emailAddressController,
  }) : super(key: key);

  final TextEditingController emailAddressController;

  @override
  Widget build(BuildContext context) {
    RegExp emailFormat = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return TextFormField(
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
    );
  }
}
