import 'package:flutter/material.dart';

class StoryAvatar
    extends StatelessWidget {

  final String name;

  final String image;

  const StoryAvatar({

    super.key,

    required this.name,

    required this.image,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding:
          const EdgeInsets.only(
        right: 16,
      ),

      child: Column(

        children: [

          Container(

            padding:
                const EdgeInsets.all(3),

            decoration:
                const BoxDecoration(

              shape: BoxShape.circle,

              gradient: LinearGradient(

                colors: [

                  Color(0xFFFF8C42),

                  Color(0xFF6C63FF),
                ],
              ),
            ),

            child: CircleAvatar(

              radius: 32,

              backgroundImage:
                  NetworkImage(image),
            ),
          ),

          const SizedBox(height: 8),

          Text(

            name,

            style: const TextStyle(

              fontSize: 13,

              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}