import 'package:flutter/material.dart';

class AdminDashboardScreen
    extends StatelessWidget {

  const AdminDashboardScreen({
    super.key,
  });

  static const Color _violet =
      Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {

    final isDark =

        Theme.of(context)
                .brightness ==

            Brightness.dark;

    return Scaffold(

      backgroundColor:

          isDark

              ? const Color(
                  0xFF0B0B14)

              : const Color(
                  0xFFF5F7FF),

      appBar: AppBar(

        elevation: 0,

        backgroundColor:
            Colors.transparent,

        title: const Text(

          "Admin Dashboard",

          style: TextStyle(

            fontWeight:
                FontWeight.w800,
          ),
        ),
      ),

      body: ListView(

        padding:
            const EdgeInsets.all(
                20),

        children: [

          Container(

            padding:
                const EdgeInsets.all(
                    24),

            decoration:
                BoxDecoration(

              gradient:
                  const LinearGradient(

                colors: [

                  Color(
                      0xFF4C3FD4),

                  Color(
                      0xFF6C63FF),
                ],
              ),

              borderRadius:
                  BorderRadius.circular(
                      30),
            ),

            child: const Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  "Campus Control Center 🚀",

                  style: TextStyle(

                    color:
                        Colors.white,

                    fontSize: 26,

                    fontWeight:
                        FontWeight.w900,
                  ),
                ),

                SizedBox(height: 14),

                Text(

                  "Manage communities, notices, events and campus operations.",

                  style: TextStyle(

                    color:
                        Colors.white70,

                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
              height: 28),

          buildAdminTile(

            title:
                "Create Official Community",

            subtitle:
                "Launch new verified campus communities.",

            icon:
                Icons.groups_rounded,
          ),

          buildAdminTile(

            title:
                "Campus Notices",

            subtitle:
                "Post official announcements to all students.",

            icon:
                Icons.campaign_rounded,
          ),

          buildAdminTile(

            title:
                "Events Management",

            subtitle:
                "Manage hackathons, workshops and campus events.",

            icon:
                Icons.event_rounded,
          ),

          buildAdminTile(

            title:
                "Community Moderation",

            subtitle:
                "Monitor and manage campus communities.",

            icon:
                Icons.admin_panel_settings_rounded,
          ),
        ],
      ),
    );
  }

  static Widget buildAdminTile({

    required String title,

    required String subtitle,

    required IconData icon,
  }) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      padding:
          const EdgeInsets.all(
              20),

      decoration:
          BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
                24),
      ),

      child: Row(

        children: [

          Container(

            padding:
                const EdgeInsets
                    .all(14),

            decoration:
                BoxDecoration(

              color: _violet
                  .withOpacity(
                      0.12),

              borderRadius:
                  BorderRadius.circular(
                      18),
            ),

            child: Icon(

              icon,

              color: _violet,
            ),
          ),

          const SizedBox(
              width: 18),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  title,

                  style:
                      const TextStyle(

                    fontSize: 17,

                    fontWeight:
                        FontWeight.w800,
                  ),
                ),

                const SizedBox(
                    height: 8),

                Text(

                  subtitle,

                  style:
                      TextStyle(

                    color:
                        Colors.grey
                            .shade700,

                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}