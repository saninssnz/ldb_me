import 'package:flutter/material.dart';

Widget headerWidget(BuildContext context, String title) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Image.asset(
            'assets/icons/riyadh-loreal.png',
            height: 100,
          ),
          SizedBox(height: 20,),
          if(title != "")
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0868A3),
            ),
          ),
        ],
      ),
    ),
  );
}