import 'package:flutter/material.dart';


class CustomLoader extends StatelessWidget {
  final double? top;
  final double? bottom;
  const CustomLoader({super.key, this.top, this.bottom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: top ?? 0, bottom: bottom ?? 0),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      ),
    );
  }
}
