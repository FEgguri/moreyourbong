import 'package:flutter/material.dart';

@override
AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0xFFF8F4E8),
    surfaceTintColor: Colors.transparent,
    elevation: 4,
    shadowColor: Colors.black.withOpacity(0.15),
    centerTitle: true, // 가운데 정렬
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 55,
          width: 55,
          fit: BoxFit.contain,
        ),
        //SizedBox(width: 8),
        Text(
          'MoreYourBong',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
