import 'package:flutter/material.dart';

class BayarButton extends StatelessWidget {
  final Function() onTap;
  const BayarButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.width * .2,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(size.width * .06)),
        child: Center(
          child: Text(
            "Bayar",
            style: TextStyle(
              fontSize: size.width * .06,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
