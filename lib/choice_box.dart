import 'package:flutter/material.dart';

class ChoiceBox extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final int index;
  final bool isSelected;
  final Function()? onTap;

  ChoiceBox({
    required this.index,
    required this.isSelected,
    required this.onTap,
    required this.height,
    required this.width,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(right: size.width * .02),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: isSelected
              ? Border.all(color: Colors.transparent)
              : Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(size.width * .03),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: size.width * .05,
              height: size.width * .003,
              fontWeight: isSelected ? FontWeight.w400 : FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
