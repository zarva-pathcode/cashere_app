import 'package:flutter/material.dart';

import 'food.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  final Size size;
  final VoidCallback onTap;

  const FoodCard({
    Key? key,
    required this.food,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04)
            .copyWith(top: size.width * 0.04),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(size.width * 0.08),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.width * 0.06),
                child: Image.asset(
                  food.photo!,
                  height: size.width * 0.35,
                  width: size.width * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: size.width * 0.04),
            Text(
              "Rp. ${food.price}",
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.1,
                color: Colors.orange,
                height: size.width * 0.0025,
              ),
            ),
            Text(
              food.name!,
              style: TextStyle(
                fontSize: size.width * 0.05,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
