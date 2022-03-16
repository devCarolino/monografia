import 'package:flutter/material.dart';
import 'package:monografia/paleta-cores.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.inputAction,
     required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey[500]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  icon,
                  size: 20,
                  color: kWhite.withOpacity(0.5),
                ),
              ),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: hintText,
            ),
            obscureText: true,
            style: kBodyText,
            textInputAction: inputAction,

          ),
        ),
      ),
    );
  }
}
