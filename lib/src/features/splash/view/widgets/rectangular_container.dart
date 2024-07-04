import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RectangularContainer extends StatelessWidget {
  const RectangularContainer({
    super.key,
    this.value,
    this.borderColor = Colors.black38,
    this.rectangleColor = Colors.grey,
  });

  final String? value;
  final Color borderColor;
  final Color rectangleColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15.h,
      width: 50.h,
      child: Container(
        decoration: BoxDecoration(
          color: rectangleColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border(
              top: BorderSide(width: 10, color: borderColor),
              right: BorderSide(width: 10, color: borderColor),
              left: BorderSide(width: 10, color: borderColor),
              bottom: BorderSide(width: 10, color: borderColor)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(value ?? "",
                  style: TextStyle(
                    fontSize: 3.h,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ))),
        ),
      ),
    );
  }
}
