import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../../models/community_model.dart';

import '../../../models/user_model.dart';

import '../services/community_service.dart';

class ManageMembersScreen
    extends StatefulWidget {

  final CommunityModel
      community;

  const ManageMembersScreen({

    super.key,

    required this.community,
  });

  @override
  State<ManageMembersScreen>
      createState() =>
          _ManageMembersScreenState();
}

class _ManageMembersScreenState
    extends State<
        ManageMembersScreen> {

  final CommunityService
      communityService =
      CommunityService();

  static const Color _violet =
      Color(0xFF6C63FF);

  static const Color _green =
      Color(0xFF00C896);

  static const Color _orange =
      Color(0xFFFF8C42);

  static const Color _red =
      Color(0xFFFF4D6D);

  @override
  Widget build(BuildContext context) {

    final isDark =

        Theme.of(context)
                .brightness ==

            Brightness.dark;

    final currentUid =
        FirebaseAuth
            .instance
            .currentUser
            ?.uid;

    final isHead =
        widget.community.head ==
            currentUid;

    final isAdmin =
        widget.community.admins
            .contains(
      currentUid,
    );

    return Scaffold(

      backgroundColor:

          isDark

              ? const Color(
                  0xFF0B0B14)

              : const Color(
                  0xFFF5F7FF),

      body: SafeArea(

        child: Column(

          children: [

            // =========================
            // HEADER
            // =========================

            Container(

              padding:
                  const EdgeInsets.only(

                left: 22,
                right: 22,
                top: 18,
                bottom: 28,
              ),

              decoration:
                  const BoxDecoration(

                gradient:
                    LinearGradient(

                  begin:
                      Alignment.topLeft,

                  end:
                      Alignment.bottomRight,

                  colors: [

                    Color(
                        0xFF4C3FD4),

                    Color(
                        0xFF6C63FF),

                    Color(
                        0xFF9D8FFF),
                  ],
                ),

                borderRadius:
                    BorderRadius.only(

                  bottomLeft:
                      Radius.circular(
                          36),

                  bottomRight:
                      Radius.circular(
                          36),
                ),
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Row(

                    children: [

                      GestureDetector(

                        onTap: () {

                          Navigator.pop(
                              context);
                        },

                        child: Container(

                          padding:
                              const EdgeInsets
                                  .all(12),

                          decoration:
                              BoxDecoration(

                            color: Colors
                                .white
                                .withOpacity(
                                    0.15),

                            borderRadius:
                                BorderRadius.circular(
                                    18),
                          ),

                          child:
                              const Icon(

                            Icons
                                .arrow_back_ios_new_rounded,

                            color:
                                Colors.white,

                            size: 20,
                          ),
                        ),
                      ),

                      const Spacer(),

                      Container(

                        padding:
                            const EdgeInsets
                                .all(12),

                        decoration:
                            BoxDecoration(

                          color: Colors
                              .white
                              .withOpacity(
                                  0.15),

                          borderRadius:
                              BorderRadius.circular(
                                  18),
                        ),

                        child:
                            const Icon(

                          Icons
                              .manage_accounts_rounded,

                          color:
                              Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 28),

                  const Text(

                    "Manage Members 👥",

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize: 30,

                      fontWeight:
                          FontWeight.w900,
                    ),
                  ),

                  const SizedBox(
                      height: 10),

                  Text(

                    widget.community.name,

                    maxLines: 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style:
                        TextStyle(

                      color: Colors
                          .white
                          .withOpacity(
                              0.85),

                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // =========================
            // MEMBER LIST
            // =========================

            Expanded(

              child: ListView.builder(

                physics:
                    const BouncingScrollPhysics(),

                padding:
                    const EdgeInsets.all(
                        20),

                itemCount:
                    widget.community
                        .members
                        .length,

                itemBuilder:
                    (context, index) {

                  final memberId =

                      widget.community
                          .members[index];

                  return FutureBuilder<
                      DocumentSnapshot>(

                    future:
                        FirebaseFirestore
                            .instance
                            .collection(
                                "users")
                            .doc(memberId)
                            .get(),

                    builder:
                        (context,
                            snapshot) {

                      if (!snapshot
                              .hasData ||

                          !snapshot
                              .data!
                              .exists) {

                        return const SizedBox();
                      }

                      final data =

                          snapshot.data!
                              .data()
                              as Map<
                                  String,
                                  dynamic>;

                      final user =
                          UserModel
                              .fromMap(
                        data,
                      );

                      return memberCard(

                        user,

                        memberId,

                        isDark,

                        isHead,

                        isAdmin,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // MEMBER CARD
  // =========================

  Widget memberCard(

    UserModel user,

    String memberId,

    bool isDark,

    bool isHead,

    bool isAdmin,
  ) {

    final isCommunityHead =

        widget.community.head ==
            memberId;

    final isCoHead =

        widget.community.coHeads
            .contains(memberId);

    final isModerator =

        widget.community
            .moderators
            .contains(memberId);

    final currentUid =
        FirebaseAuth
            .instance
            .currentUser
            ?.uid;

    final canManage =

        currentUid != memberId &&

        (isHead || isAdmin);

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 20,
      ),

      padding:
          const EdgeInsets.all(
              20),

      decoration:
          BoxDecoration(

        color:

            isDark

                ? const Color(
                    0xFF171726)

                : Colors.white,

        borderRadius:
            BorderRadius.circular(
                28),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(

              isDark ? 0.25 : 0.05,
            ),

            blurRadius: 20,

            offset:
                const Offset(0, 10),
          ),
        ],
      ),

      child: Row(

        children: [

          // =========================
          // PROFILE
          // =========================

          Container(

            height: 64,
            width: 64,

            decoration:
                BoxDecoration(

              gradient:
                  const LinearGradient(

                colors: [

                  _violet,

                  Color(
                      0xFF9D8FFF),
                ],
              ),

              borderRadius:
                  BorderRadius.circular(
                      22),
            ),

            child:
                const Icon(

              Icons.person_rounded,

              color:
                  Colors.white,

              size: 32,
            ),
          ),

          const SizedBox(
              width: 18),

          // =========================
          // USER INFO
          // =========================

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  user.name.isEmpty

                      ? "Student"

                      : user.name,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      TextStyle(

                    fontSize: 18,

                    fontWeight:
                        FontWeight.w800,

                    color:

                        isDark

                            ? Colors.white

                            : const Color(
                                0xFF1A1A2E),
                  ),
                ),

                const SizedBox(
                    height: 8),

                Text(

                  user.email,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      TextStyle(

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
                    height: 12),

                Wrap(

                  spacing: 8,

                  runSpacing: 8,

                  children: [

                    if (isCommunityHead)

                      roleChip(
                        "Head",
                        _violet,
                      ),

                    if (isCoHead)

                      roleChip(
                        "Co-Head",
                        _orange,
                      ),

                    if (isModerator)

                      roleChip(
                        "Moderator",
                        _green,
                      ),

                    if (!isCommunityHead &&
                        !isCoHead &&
                        !isModerator)

                      roleChip(
                        "Member",
                        Colors.grey,
                      ),
                  ],
                ),
              ],
            ),
          ),

          // =========================
          // ACTION MENU
          // =========================

          if (canManage)

            PopupMenuButton(

              color:

                  isDark

                      ? const Color(
                          0xFF1E1E2E)

                      : Colors.white,

              icon: Icon(

                Icons.more_vert,

                color:

                    isDark

                        ? Colors.white

                        : Colors.black,
              ),

              itemBuilder:
                  (context) => [

                // =========================
                // CO HEAD
                // =========================

                if (!isCoHead)

                  PopupMenuItem(

                    onTap: () async {

                      await communityService
                          .addCoHead(

                        communityId:
                            widget
                                .community
                                .id,

                        uid: memberId,
                      );

                      showMessage(
                        "Promoted to Co-Head 🚀",
                      );
                    },

                    child: const Text(
                      "Make Co-Head",
                    ),
                  ),

                if (isCoHead)

                  PopupMenuItem(

                    onTap: () async {

                      await communityService
                          .removeCoHead(

                        communityId:
                            widget
                                .community
                                .id,

                        uid: memberId,
                      );

                      showMessage(
                        "Co-Head Removed",
                      );
                    },

                    child: const Text(
                      "Remove Co-Head",
                    ),
                  ),

                // =========================
                // MODERATOR
                // =========================

                if (!isModerator)

                  PopupMenuItem(

                    onTap: () async {

                      await communityService
                          .addModerator(

                        communityId:
                            widget
                                .community
                                .id,

                        uid: memberId,
                      );

                      showMessage(
                        "Moderator Added 🛡️",
                      );
                    },

                    child: const Text(
                      "Make Moderator",
                    ),
                  ),

                if (isModerator)

                  PopupMenuItem(

                    onTap: () async {

                      await communityService
                          .removeModerator(

                        communityId:
                            widget
                                .community
                                .id,

                        uid: memberId,
                      );

                      showMessage(
                        "Moderator Removed",
                      );
                    },

                    child: const Text(
                      "Remove Moderator",
                    ),
                  ),

                // =========================
                // REMOVE MEMBER
                // =========================

                PopupMenuItem(

                  onTap: () async {

                    await FirebaseFirestore
                        .instance
                        .collection(
                            "communities")
                        .doc(widget
                            .community.id)
                        .update({

                      "members":

                          FieldValue
                              .arrayRemove(
                        [memberId],
                      ),

                      "membersCount":

                          FieldValue
                              .increment(
                        -1,
                      ),
                    });

                    showMessage(
                      "Member Removed",
                    );
                  },

                  child: const Text(
                    "Remove Member",
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // =========================
  // ROLE CHIP
  // =========================

  Widget roleChip(
    String text,
    Color color,
  ) {

    return Container(

      padding:
          const EdgeInsets.symmetric(

        horizontal: 12,
        vertical: 7,
      ),

      decoration:
          BoxDecoration(

        color:
            color.withOpacity(
          0.12,
        ),

        borderRadius:
            BorderRadius.circular(
                30),
      ),

      child: Text(

        text,

        style: TextStyle(

          color: color,

          fontWeight:
              FontWeight.w700,

          fontSize: 12,
        ),
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