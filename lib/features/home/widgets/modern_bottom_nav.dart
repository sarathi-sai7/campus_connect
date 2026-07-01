import 'package:flutter/material.dart';

class ModernBottomNav
    extends StatelessWidget {

  const ModernBottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin:
          const EdgeInsets.all(18),

      padding:
          const EdgeInsets.symmetric(
        vertical: 14,
      ),

      decoration: BoxDecoration(

        color:
            Theme.of(context)
                .cardColor,

        borderRadius:
            BorderRadius.circular(
                30),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(
                    0.08),

            blurRadius: 20,

            offset:
                const Offset(0, 8),
          ),
        ],
      ),

      child: const Row(

        mainAxisAlignment:
            MainAxisAlignment
                .spaceAround,

        children: [

          Icon(
            Icons.home_rounded,
            size: 30,
          ),

          Icon(
            Icons.search_rounded,
            size: 30,
          ),

          Icon(
            Icons.add_box_rounded,
            size: 30,
          ),

          Icon(
            Icons.favorite_rounded,
            size: 30,
          ),

          Icon(
            Icons.person_rounded,
            size: 30,
          ),
        ],
      ),
    );
  }
}