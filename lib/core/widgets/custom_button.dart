import 'package:flutter/material.dart';

class CustomButton
    extends StatelessWidget {

  final String text;

  final VoidCallback onPressed;

  const CustomButton({

    super.key,

    required this.text,

    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(

      width: double.infinity,

      height: 58,

      child: ElevatedButton(

        onPressed: onPressed,

        style: ElevatedButton.styleFrom(

          elevation: 0,

          backgroundColor:
              const Color(0xFF6C63FF),

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(
                    18),
          ),
        ),

        child: Text(

          text,

          style: const TextStyle(

            fontSize: 16,

            fontWeight:
                FontWeight.bold,

            color: Colors.white,
          ),
        ),
      ),
    );
  }
}