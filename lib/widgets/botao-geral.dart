import 'package:flutter/material.dart';

import '../paleta-cores.dart';


class RoundedButton extends StatefulWidget {
   RoundedButton(
  { required this.buttonName,
       required this.onPressed,
  }
  );

 final  String? buttonName;
 final VoidCallback onPressed;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.08,
      width: size.width * 0.8,
      child: ElevatedButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            kBodyText.copyWith(fontWeight: FontWeight.bold),
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        ),
        child: Text(
          widget.buttonName!,
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}