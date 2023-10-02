import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Center(
            child: Image.asset(
              'assets/images/no_data.jpeg',
              height: 400,
            ),
          ),
          const Text(
            'No Data!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
  }
}