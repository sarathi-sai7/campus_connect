import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../../models/community_model.dart';

import '../../chat/screens/community_chat_screen.dart';

import 'apply_community_sheet.dart';

import 'manage_members_screen.dart';

import 'community_requests_screen.dart';

class CommunityDetailsScreen
    extends StatefulWidget {

  final CommunityModel community;

  const CommunityDetailsScreen({

    super.key,

    required this.community,
  });

  @override
  State<CommunityDetailsScreen>
      createState() =>
          _CommunityDetailsScreenState();
}

class _CommunityDetailsScreenState
    extends State<
        CommunityDetailsScreen> {

  static const Color _violet =
      Color(0xFF6C63FF);

  static const Color _pink =
      Color(0xFFE84393);

  static const Color _orange =
      Color(0xFFFF8C42);

  static const Color _green =
      Color(0xFF00C896);

  static const Color _red =
      Color(0xFFFF4D6D);

  bool isLoading = false;

  Future<String> getRequestStatus()
  async {

    final uid =
        FirebaseAuth
            .instance
            .currentUser
            ?.uid;

    if (uid == null) {

      return "none";
    }

    final snapshot =

        await FirebaseFirestore
            .instance
            .collection(
                "community_requests")
            .where(
              "communityId",
              isEqualTo:
                  widget.community.id,
            )
            .where(
              "userId",
              isEqualTo: uid,
            )
            .limit(1)
            .get();

    if (snapshot.docs.isEmpty) {

      return "none";
    }

    return snapshot
        .docs
        .first["status"];
  }

  Future<void> leaveCommunity()
  async {

    final uid =
        FirebaseAuth
            .instance
            .currentUser
            ?.uid;

    if (uid == null) {

      return;
    }

    // PREVENT HEAD LEAVING

    if (widget.community.head ==
        uid) {

      showMessage(
        "Community head cannot leave",
      );

      return;
    }

    setState(() {

      isLoading = true;
    });

    await FirebaseFirestore
        .instance
        .collection("communities")
        .doc(widget.community.id)
        .update({

      "members":
          FieldValue.arrayRemove(
        [uid],
      ),

      "membersCount":
          FieldValue.increment(
        -1,
      ),

      "admins":
          FieldValue.arrayRemove(
        [uid],
      ),

      "coHeads":
          FieldValue.arrayRemove(
        [uid],
      ),

      "moderators":
          FieldValue.arrayRemove(
        [uid],
      ),
    });

    if (!mounted) return;

    setState(() {

      isLoading = false;
    });

    showMessage(
      "Left community",
    );
  }

  @override
  Widget build(BuildContext context) {

    final isDark =

        Theme.of(context)
                .brightness ==

            Brightness.dark;

    final uid =
        FirebaseAuth
            .instance
            .currentUser
            ?.uid;

    final joined =
        widget.community.members
            .contains(uid);

    final isHead =
        widget.community.head ==
            uid;

    final isAdmin =
        widget.community.admins
            .contains(uid);

    final canManage =
        isHead || isAdmin;

    return Scaffold(

      backgroundColor:

          isDark

              ? const Color(
                  0xFF0B0B14)

              : const Color(
                  0xFFF5F7FF),

      body: FutureBuilder<String>(

        future: getRequestStatus(),

        builder:
            (context, snapshot) {

          final requestStatus =

              snapshot.data ??
                  "none";

          return Stack(

            children: [

              // =========================
              // HERO SECTION
              // =========================

              SizedBox(

                height: 340,

                width: double.infinity,

                child: Stack(

                  fit: StackFit.expand,

                  children: [

                    Container(

                      decoration:
                          const BoxDecoration(

                        gradient:
                            LinearGradient(

                          begin:
                              Alignment
                                  .topLeft,

                          end:
                              Alignment
                                  .bottomRight,

                          colors: [

                            Color(
                                0xFF4C3FD4),

                            Color(
                                0xFF6C63FF),

                            Color(
                                0xFF9D8FFF),
                          ],
                        ),
                      ),

                      child:
                          const Center(

                        child: Icon(

                          Icons
                              .groups_rounded,

                          size: 110,

                          color:
                              Colors.white,
                        ),
                      ),
                    ),

                    Container(

                      decoration:
                          BoxDecoration(

                        gradient:
                            LinearGradient(

                          begin:
                              Alignment
                                  .topCenter,

                          end:
                              Alignment
                                  .bottomCenter,

                          colors: [

                            Colors.black
                                .withOpacity(
                                    0.15),

                            Colors.black
                                .withOpacity(
                                    0.72),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =========================
              // MAIN CONTENT
              // =========================

              SafeArea(

                child:
                    SingleChildScrollView(

                  physics:
                      const BouncingScrollPhysics(),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      // =========================
                      // TOP BAR
                      // =========================

                      Padding(

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal:
                              20,

                          vertical:
                              14,
                        ),

                        child: Row(

                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,

                          children: [

                            GestureDetector(

                              onTap: () {

                                Navigator.pop(
                                    context);
                              },

                              child:
                                  glassButton(

                                Icons
                                    .arrow_back_ios_new_rounded,
                              ),
                            ),

                            Row(

                              children: [

                                if (widget
                                    .community
                                    .isOfficial)

                                  Container(

                                    padding:
                                        const EdgeInsets.symmetric(

                                      horizontal:
                                          12,

                                      vertical:
                                          8,
                                    ),

                                    decoration:
                                        BoxDecoration(

                                      color:
                                          Colors.white
                                              .withOpacity(
                                                  0.18),

                                      borderRadius:
                                          BorderRadius.circular(
                                              18),
                                    ),

                                    child:
                                        const Row(

                                      children: [

                                        Icon(

                                          Icons
                                              .verified_rounded,

                                          color:
                                              Colors.white,

                                          size:
                                              18,
                                        ),

                                        SizedBox(
                                            width:
                                                8),

                                        Text(

                                          "Official",

                                          style:
                                              TextStyle(

                                            color:
                                                Colors.white,

                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                const SizedBox(
                                    width: 12),

                                glassButton(

                                  Icons
                                      .bookmark_border_rounded,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 120),

                      // =========================
                      // COMMUNITY TITLE
                      // =========================

                      Padding(

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(

                              widget
                                  .community
                                  .name,

                              maxLines: 2,

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  const TextStyle(

                                fontSize:
                                    34,

                                fontWeight:
                                    FontWeight.w900,

                                color:
                                    Colors.white,

                                height:
                                    1.1,
                              ),
                            ),

                            const SizedBox(
                                height: 14),

                            Wrap(

                              spacing: 10,

                              runSpacing: 10,

                              children: [

                                buildChip(

                                  widget
                                      .community
                                      .category,

                                  _violet,
                                ),

                                buildChip(
                                  "Active",
                                  _green,
                                ),

                                if (widget
                                    .community
                                    .approvalRequired)

                                  buildChip(
                                    "Approval Required",
                                    _orange,
                                  ),
                              ],
                            ),

                            const SizedBox(
                                height: 22),

                            Row(

                              children: [

                                buildStat(

                                  Icons
                                      .groups_rounded,

                                  "${widget.community.membersCount} Members",
                                ),

                                const SizedBox(
                                    width: 24),

                                buildStat(

                                  Icons
                                      .event_rounded,

                                  "12 Events",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 34),

                      // =========================
                      // MAIN CARD
                      // =========================

                      Container(

                        width: double.infinity,

                        decoration:
                            BoxDecoration(

                          color:

                              isDark

                                  ? const Color(
                                      0xFF12121F)

                                  : Colors
                                      .white,

                          borderRadius:
                              const BorderRadius.only(

                            topLeft:
                                Radius.circular(
                                    38),

                            topRight:
                                Radius.circular(
                                    38),
                          ),
                        ),

                        child: Padding(

                          padding:
                              const EdgeInsets.all(
                                  24),

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Center(

                                child: Container(

                                  width: 72,

                                  height: 5,

                                  decoration:
                                      BoxDecoration(

                                    color: Colors
                                        .grey
                                        .withOpacity(
                                            0.3),

                                    borderRadius:
                                        BorderRadius.circular(
                                            20),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                  height: 30),

                              // =========================
                              // ABOUT
                              // =========================

                              sectionTitle(
                                "About Community",
                                isDark,
                              ),

                              const SizedBox(
                                  height: 16),

                              Text(

                                widget
                                    .community
                                    .description,

                                style:
                                    TextStyle(

                                  fontSize:
                                      15,

                                  height:
                                      1.8,

                                  color:

                                      isDark

                                          ? Colors
                                              .grey
                                              .shade400

                                          : Colors
                                              .grey
                                              .shade700,
                                ),
                              ),

                              const SizedBox(
                                  height: 34),

                              // =========================
                              // BENEFITS
                              // =========================

                              sectionTitle(
                                "Community Benefits",
                                isDark,
                              ),

                              const SizedBox(
                                  height: 18),

                              buildRequirement(
                                "Realtime discussions",
                                isDark,
                              ),

                              buildRequirement(
                                "Networking opportunities",
                                isDark,
                              ),

                              buildRequirement(
                                "Hackathons & events",
                                isDark,
                              ),

                              buildRequirement(
                                "Certificates & recognition",
                                isDark,
                              ),

                              const SizedBox(
                                  height: 34),

                              // =========================
                              // ACTIVITIES
                              // =========================

                              sectionTitle(
                                "Recent Activities",
                                isDark,
                              ),

                              const SizedBox(
                                  height: 18),

                              buildActivityCard(

                                "AI Hackathon",

                                "120+ participants",

                                Icons
                                    .emoji_events_rounded,

                                _orange,

                                isDark,
                              ),

                              buildActivityCard(

                                "Flutter Workshop",

                                "Realtime app development",

                                Icons
                                    .flutter_dash_rounded,

                                _violet,

                                isDark,
                              ),

                              // =========================
                              // ADMIN CONTROLS
                              // =========================

                              if (canManage) ...[

                                const SizedBox(
                                    height:
                                        34),

                                sectionTitle(
                                  "Admin Controls",
                                  isDark,
                                ),

                                const SizedBox(
                                    height:
                                        20),

                                GestureDetector(

                                  onTap: () {

                                    Navigator.push(

                                      context,

                                      MaterialPageRoute(

                                        builder: (_) =>

                                            ManageMembersScreen(

                                          community:
                                              widget.community,
                                        ),
                                      ),
                                    );
                                  },

                                  child:
                                      adminCard(

                                    title:
                                        "Manage Members",

                                    subtitle:
                                        "Assign co-heads, moderators and manage members.",

                                    icon:
                                        Icons.groups_rounded,

                                    color:
                                        _violet,
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                        16),

                                GestureDetector(

                                  onTap: () {

                                    Navigator.push(

                                      context,

                                      MaterialPageRoute(

                                        builder: (_) =>

                                            CommunityRequestsScreen(

                                          communityId:
                                              widget.community.id,

                                          communityName:
                                              widget.community.name,
                                        ),
                                      ),
                                    );
                                  },

                                  child:
                                      adminCard(

                                    title:
                                        "Join Requests",

                                    subtitle:
                                        "Approve or reject student applications.",

                                    icon:
                                        Icons.mark_email_unread_rounded,

                                    color:
                                        _orange,
                                  ),
                                ),
                              ],

                              const SizedBox(
                                  height: 120),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // =========================
              // BOTTOM BUTTON
              // =========================

              Positioned(

                left: 24,
                right: 24,
                bottom: 24,

                child: buildBottomButton(

                  joined,

                  requestStatus,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // =========================
  // BOTTOM BUTTON
  // =========================

  Widget buildBottomButton(

    bool joined,

    String requestStatus,
  ) {

    // JOINED

    if (joined) {

      return Row(

        children: [

          Expanded(

            child: SizedBox(

              height: 60,

              child:
                  ElevatedButton.icon(

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      _violet,

                  elevation: 0,

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            22),
                  ),
                ),

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>

                          CommunityChatScreen(

                        community:
                            widget.community,
                      ),
                    ),
                  );
                },

                icon: const Icon(

                  Icons.chat_rounded,

                  color: Colors.white,
                ),

                label: const Text(

                  "Open Chat",

                  style: TextStyle(

                    color: Colors.white,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          SizedBox(

            height: 60,
            width: 60,

            child: ElevatedButton(

              style:
                  ElevatedButton.styleFrom(

                backgroundColor:
                    _red,

                elevation: 0,

                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(
                          22),
                ),
              ),

              onPressed:

                  isLoading

                      ? null

                      : leaveCommunity,

              child:

                  isLoading

                      ? const SizedBox(

                          height: 18,
                          width: 18,

                          child:
                              CircularProgressIndicator(
                            color:
                                Colors.white,
                            strokeWidth: 2,
                          ),
                        )

                      : const Icon(

                          Icons
                              .logout_rounded,

                          color:
                              Colors.white,
                        ),
            ),
          ),
        ],
      );
    }

    // PENDING

    if (requestStatus ==
        "pending") {

      return SizedBox(

        height: 60,

        child: ElevatedButton.icon(

          style:
              ElevatedButton.styleFrom(

            backgroundColor:
                Colors.orange,

            elevation: 0,

            shape:
                RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(
                      22),
            ),
          ),

          onPressed: () {},

          icon: const Icon(

            Icons.access_time_rounded,

            color: Colors.white,
          ),

          label: const Text(

            "Request Pending",

            style: TextStyle(

              color: Colors.white,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      );
    }

    // APPLY

    return SizedBox(

      height: 60,

      child: ElevatedButton.icon(

        style:
            ElevatedButton.styleFrom(

          backgroundColor:
              _violet,

          elevation: 0,

          shape:
              RoundedRectangleBorder(

            borderRadius:
                BorderRadius.circular(
                    22),
          ),
        ),

        onPressed: () {

          showModalBottomSheet(

            context: context,

            isScrollControlled:
                true,

            backgroundColor:
                Colors.transparent,

            builder: (_) =>

                ApplyCommunitySheet(

              community:
                  widget.community,
            ),
          );
        },

        icon: const Icon(

          Icons.send_rounded,

          color: Colors.white,
        ),

        label: const Text(

          "Apply To Join",

          style: TextStyle(

            fontSize: 17,

            fontWeight:
                FontWeight.w700,

            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // =========================
  // GLASS BUTTON
  // =========================

  Widget glassButton(
    IconData icon,
  ) {

    return Container(

      padding:
          const EdgeInsets.all(12),

      decoration:
          BoxDecoration(

        color: Colors.white
            .withOpacity(0.18),

        borderRadius:
            BorderRadius.circular(
                18),
      ),

      child: Icon(

        icon,

        color: Colors.white,
      ),
    );
  }

  // =========================
  // SECTION TITLE
  // =========================

  Widget sectionTitle(

    String title,

    bool isDark,
  ) {

    return Text(

      title,

      style: TextStyle(

        fontSize: 20,

        fontWeight:
            FontWeight.w800,

        color:

            isDark

                ? Colors.white

                : const Color(
                    0xFF1A1A2E),
      ),
    );
  }

  // =========================
  // CHIP
  // =========================

  Widget buildChip(

    String text,

    Color color,
  ) {

    return Container(

      padding:
          const EdgeInsets.symmetric(

        horizontal: 14,
        vertical: 8,
      ),

      decoration:
          BoxDecoration(

        color:
            color.withOpacity(0.2),

        borderRadius:
            BorderRadius.circular(
                20),
      ),

      child: Text(

        text,

        style: TextStyle(

          color: color,

          fontWeight:
              FontWeight.w700,
        ),
      ),
    );
  }

  // =========================
  // STAT
  // =========================

  Widget buildStat(

    IconData icon,

    String label,
  ) {

    return Row(

      children: [

        Icon(

          icon,

          color: Colors.white
              .withOpacity(0.9),

          size: 18,
        ),

        const SizedBox(width: 8),

        Text(

          label,

          style: TextStyle(

            color: Colors.white
                .withOpacity(0.9),

            fontWeight:
                FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // =========================
  // REQUIREMENT
  // =========================

  Widget buildRequirement(

    String text,

    bool isDark,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 14,
      ),

      child: Row(

        children: [

          const Icon(

            Icons.check_circle_rounded,

            color: _green,

            size: 20,
          ),

          const SizedBox(width: 12),

          Expanded(

            child: Text(

              text,

              style: TextStyle(

                fontWeight:
                    FontWeight.w600,

                color:

                    isDark

                        ? Colors.white

                        : const Color(
                            0xFF1A1A2E),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // ACTIVITY CARD
  // =========================

  Widget buildActivityCard(

    String title,

    String subtitle,

    IconData icon,

    Color color,

    bool isDark,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 14,
      ),

      padding:
          const EdgeInsets.all(18),

      decoration:
          BoxDecoration(

        color:

            isDark

                ? const Color(
                    0xFF1B1B2B)

                : const Color(
                    0xFFF5F6FF),

        borderRadius:
            BorderRadius.circular(
                24),
      ),

      child: Row(

        children: [

          Container(

            padding:
                const EdgeInsets.all(
                    12),

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                0.12,
              ),

              borderRadius:
                  BorderRadius.circular(
                      18),
            ),

            child: Icon(

              icon,

              color: color,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  title,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style: TextStyle(

                    fontWeight:
                        FontWeight.w800,

                    fontSize: 16,

                    color:

                        isDark

                            ? Colors.white

                            : const Color(
                                0xFF1A1A2E),
                  ),
                ),

                const SizedBox(height: 6),

                Text(

                  subtitle,

                  style: TextStyle(

                    color:

                        isDark

                            ? Colors
                                .grey
                                .shade400

                            : Colors
                                .grey
                                .shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // ADMIN CARD
  // =========================

  Widget adminCard({

    required String title,

    required String subtitle,

    required IconData icon,

    required Color color,
  }) {

    return Container(

      padding:
          const EdgeInsets.all(
              22),

      decoration:
          BoxDecoration(

        gradient:
            LinearGradient(

          colors: [

            color,

            color.withOpacity(
              0.75,
            ),
          ],
        ),

        borderRadius:
            BorderRadius.circular(
                28),
      ),

      child: Row(

        children: [

          Container(

            padding:
                const EdgeInsets
                    .all(14),

            decoration:
                BoxDecoration(

              color: Colors
                  .white
                  .withOpacity(
                      0.18),

              borderRadius:
                  BorderRadius.circular(
                      18),
            ),

            child: Icon(

              icon,

              color:
                  Colors.white,
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

                    color:
                        Colors.white,

                    fontSize:
                        18,

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

                    color: Colors
                        .white
                        .withOpacity(
                            0.85),

                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const Icon(

            Icons
                .arrow_forward_ios_rounded,

            color:
                Colors.white,
          ),
        ],
      ),
    );
  }

  // =========================
  // SNACKBAR
  // =========================

  void showMessage(
    String message,
  ) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        behavior:
            SnackBarBehavior
                .floating,

        backgroundColor:
            _violet,

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
                  18),
        ),

        content: Text(
          message,
        ),
      ),
    );
  }
}