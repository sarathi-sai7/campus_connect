  import 'package:flutter/material.dart';

class FeedCard
    extends StatelessWidget {

  final String title;

  final String subtitle;

  final String image;

  const FeedCard({

    super.key,

    required this.title,

    required this.subtitle,

    required this.image,
  });

  @override
  Widget build(BuildContext context) {

    final isDark =

        Theme.of(context).brightness ==
            Brightness.dark;

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 22,
      ),

      decoration: BoxDecoration(

        color:

            isDark

                ? const Color(0xFF1E1E1E)

                : Colors.white,

        borderRadius:
            BorderRadius.circular(
                28),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(
                    0.05),

            blurRadius: 18,

            offset:
                const Offset(0, 10),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          ClipRRect(

            borderRadius:
                const BorderRadius.only(

              topLeft:
                  Radius.circular(28),

              topRight:
                  Radius.circular(28),
            ),

            child: Image.network(

              image,

              height: 210,

              width: double.infinity,

              fit: BoxFit.cover,
            ),
          ),

          Padding(

            padding:
                const EdgeInsets.all(18),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style: const TextStyle(

                    fontSize: 20,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(

                  subtitle,

                  style: TextStyle(

                    color:

                        isDark

                            ? Colors
                                .grey.shade400

                            : Colors
                                .grey.shade700,

                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 18),

                Row(

                  children: [

                    const Icon(

                      Icons.favorite_border,

                      size: 22,
                    ),

                    const SizedBox(width: 18),

                    const Icon(

                      Icons.chat_bubble_outline,

                      size: 22,
                    ),

                    const Spacer(),

                    Text(

                      "CampusConnect",

                      style: TextStyle(

                        color:
                            Colors.grey
                                .shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}