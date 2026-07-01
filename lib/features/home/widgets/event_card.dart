import 'package:flutter/material.dart';

class EventCard
    extends StatelessWidget {

  final String title;

  final String date;

  const EventCard({

    super.key,

    required this.title,

    required this.date,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      width: 180,

      margin:
          const EdgeInsets.only(
        right: 18,
      ),

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(

        gradient:
            const LinearGradient(

          colors: [

            Color(0xFF6C63FF),

            Color(0xFF8B80FF),
          ],
        ),

        borderRadius:
            BorderRadius.circular(
                28),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          const Icon(

            Icons.event_available,

            color: Colors.white,

            size: 32,
          ),

          Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Text(

                title,

                style: const TextStyle(

                  color: Colors.white,

                  fontSize: 18,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(

                date,

                style: TextStyle(

                  color: Colors.white
                      .withOpacity(0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}