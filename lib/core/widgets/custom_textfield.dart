import 'package:flutter/material.dart';

class CustomTextField
    extends StatelessWidget {

  final String hintText;

  final TextEditingController
      controller;

  final bool obscureText;

  const CustomTextField({

    super.key,

    required this.hintText,

    required this.controller,

    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {

    final isDark =

        Theme.of(context).brightness ==
            Brightness.dark;

    return TextField(

      controller: controller,

      obscureText: obscureText,

      style: TextStyle(

        color:
            isDark
                ? Colors.white
                : Colors.black87,

        fontSize: 16,
      ),

      decoration: InputDecoration(

        hintText: hintText,

        hintStyle: TextStyle(

          color:

              isDark
                  ? Colors.grey.shade400
                  : Colors.grey.shade600,
        ),

        filled: true,

        fillColor:

            isDark

                ? const Color(0xFF1E1E1E)

                : Colors.white,

        contentPadding:
            const EdgeInsets.symmetric(

          horizontal: 20,
          vertical: 18,
        ),

        border: OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(18),

          borderSide: BorderSide.none,
        ),

        enabledBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(18),

          borderSide: BorderSide(

            color:

                isDark

                    ? Colors.grey.shade800

                    : Colors.grey.shade200,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(18),

          borderSide: const BorderSide(

            color: Color(0xFF6C63FF),

            width: 1.5,
          ),
        ),
      ),
    );
  }
}