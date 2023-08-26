import 'package:flutter/material.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: const[
            TextSpan(text: 'GalleryApp' ,style: TextStyle(color: Colors.orangeAccent))
          ]
        ),
      ),
    );
  }
}
