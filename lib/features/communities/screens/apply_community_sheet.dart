import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/community_model.dart';

class ApplyCommunitySheet
    extends StatefulWidget {

  final CommunityModel community;

  const ApplyCommunitySheet({

    super.key,

    required this.community,
  });

  @override
  State<ApplyCommunitySheet>
      createState() =>
          _ApplyCommunitySheetState();
}

class _ApplyCommunitySheetState
    extends State<ApplyCommunitySheet> {

  final reasonController =
      TextEditingController();

  final skillsController =
      TextEditingController();

  bool isLoading = false;

  static const Color _violet =
      Color(0xFF6C63FF);

  static const Color _violetLight =
      Color(0xFF9D8FFF);

  static const Color _green =
      Color(0xFF00C896);
  static const Color _orange =
    Color(0xFFFF8C42);

  Future<void> submitRequest()
  async {

    if (reasonController
        .text
        .trim()
        .isEmpty) {

      showMessage(
        "Please tell why you want to join",
      );

      return;
    }

    setState(() {

      isLoading = true;
    });

    final user =
        FirebaseAuth
            .instance
            .currentUser;

    await FirebaseFirestore
        .instance
        .collection(
            "community_requests")
        .add({

      "communityId":
          widget.community.id,

      "communityName":
          widget.community.name,

      "userId":
          user?.uid,

      "userName":
          user?.email,

      "reason":
          reasonController.text,

      "skills":
          skillsController.text,

      "status":
          "pending",

      "createdAt":
          Timestamp.now(),
    });

    if (!mounted) return;

    Navigator.pop(context);

    showMessage(
      "Application Submitted 🚀",
    );
  }

  @override
  Widget build(BuildContext context) {

    final isDark =

        Theme.of(context)
                .brightness ==

            Brightness.dark;

    return Container(

      height:
          MediaQuery.of(context)
                  .size
                  .height *

              0.93,

      decoration:
          BoxDecoration(

        color:

            isDark

                ? const Color(
                    0xFF0B0B14)

                : const Color(
                    0xFFF5F7FF),

        borderRadius:
            const BorderRadius.only(

          topLeft:
              Radius.circular(36),

          topRight:
              Radius.circular(36),
        ),
      ),

      child: Column(

        children: [

          // =========================
          // TOP HANDLE
          // =========================

          const SizedBox(height: 14),

          Container(

            width: 70,

            height: 5,

            decoration:
                BoxDecoration(

              color: Colors.grey
                  .withOpacity(0.3),

              borderRadius:
                  BorderRadius.circular(
                      20),
            ),
          ),

          const SizedBox(height: 24),

          Expanded(

            child:
                SingleChildScrollView(

              physics:
                  const BouncingScrollPhysics(),

              padding:
                  EdgeInsets.only(

                left: 24,
                right: 24,

                bottom:

                    MediaQuery.of(context)
                            .viewInsets
                            .bottom +

                        40,
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  // =========================
                  // HEADER CARD
                  // =========================

                  Container(

                    padding:
                        const EdgeInsets.all(
                            24),

                    decoration:
                        BoxDecoration(

                      gradient:
                          const LinearGradient(

                        begin:
                            Alignment.topLeft,

                        end:
                            Alignment.bottomRight,

                        colors: [

                          _violet,

                          _violetLight,
                        ],
                      ),

                      borderRadius:
                          BorderRadius.circular(
                              32),
                    ),

                    child: Row(

                      children: [

                        Container(

                          height: 72,
                          width: 72,

                          decoration:
                              BoxDecoration(

                            color: Colors
                                .white
                                .withOpacity(
                                    0.18),

                            borderRadius:
                                BorderRadius.circular(
                                    24),
                          ),

                          child:
                              const Icon(

                            Icons
                                .groups_rounded,

                            color:
                                Colors.white,

                            size: 34,
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

                              const Text(

                                "Apply To Join",

                                style:
                                    TextStyle(

                                  color:
                                      Colors.white,

                                  fontSize:
                                      24,

                                  fontWeight:
                                      FontWeight.w900,
                                ),
                              ),

                              const SizedBox(
                                  height: 8),

                              Text(

                                widget
                                    .community
                                    .name,

                                maxLines: 1,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    TextStyle(

                                  color: Colors
                                      .white
                                      .withOpacity(
                                          0.92),

                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // =========================
                  // COMMUNITY PREVIEW
                  // =========================

                  sectionTitle(
                    "Community Overview",
                    isDark,
                  ),

                  const SizedBox(height: 18),

                  buildInfoCard(

                    icon:
                        Icons.category_rounded,

                    title:
                        "Category",

                    value:
                        widget.community.category,

                    color:
                        _violet,

                    isDark:
                        isDark,
                  ),

                  buildInfoCard(

                    icon:
                        Icons.people_alt_rounded,

                    title:
                        "Members",

                    value:
                        "${widget.community.membersCount}+ students",

                    color:
                        _green,

                    isDark:
                        isDark,
                  ),

                  buildInfoCard(

                    icon:
                        Icons.workspace_premium_rounded,

                    title:
                        "Access",

                    value:
                        "Approval Required",

                    color:
                        _orange,

                    isDark:
                        isDark,
                  ),

                  const SizedBox(height: 30),

                  // =========================
                  // REASON FIELD
                  // =========================

                  sectionTitle(
                    "Why do you want to join?",
                    isDark,
                  ),

                  const SizedBox(height: 16),

                  modernField(

                    controller:
                        reasonController,

                    hint:
                        "Tell the community head about your interests, goals, and motivation...",

                    maxLines: 6,

                    isDark:
                        isDark,
                  ),

                  const SizedBox(height: 28),

                  // =========================
                  // SKILLS FIELD
                  // =========================

                  sectionTitle(
                    "Skills / Portfolio",
                    isDark,
                  ),

                  const SizedBox(height: 16),

                  modernField(

                    controller:
                        skillsController,

                    hint:
                        "Flutter, UI/UX, Github, AI, Figma, Portfolio...",

                    maxLines: 2,

                    isDark:
                        isDark,
                  ),

                  const SizedBox(height: 30),

                  // =========================
                  // BENEFITS CARD
                  // =========================

                  Container(

                    padding:
                        const EdgeInsets.all(
                            22),

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
                    ),

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Row(

                          children: [

                            Container(

                              padding:
                                  const EdgeInsets
                                      .all(12),

                              decoration:
                                  BoxDecoration(

                                color:
                                    _violet
                                        .withOpacity(
                                            0.12),

                                borderRadius:
                                    BorderRadius.circular(
                                        18),
                              ),

                              child:
                                  const Icon(

                                Icons
                                    .bolt_rounded,

                                color:
                                    _violet,
                              ),
                            ),

                            const SizedBox(
                                width: 14),

                            Text(

                              "What happens next?",

                              style:
                                  TextStyle(

                                fontSize:
                                    18,

                                fontWeight:
                                    FontWeight.w800,

                                color:

                                    isDark

                                        ? Colors
                                            .white

                                        : const Color(
                                            0xFF1A1A2E),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        buildStep(
                          "Your request is reviewed by community admins",
                          isDark,
                        ),

                        buildStep(
                          "You’ll receive approval notification",
                          isDark,
                        ),

                        buildStep(
                          "Once approved, you'll unlock chat & events",
                          isDark,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // =========================
                  // BUTTON
                  // =========================

                  SizedBox(

                    width: double.infinity,

                    height: 62,

                    child:
                        ElevatedButton(

                      style:
                          ElevatedButton.styleFrom(

                        elevation: 0,

                        backgroundColor:
                            _violet,

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

                              : submitRequest,

                      child:

                          isLoading

                              ? const SizedBox(

                                  height: 24,
                                  width: 24,

                                  child:
                                      CircularProgressIndicator(

                                    color:
                                        Colors.white,

                                    strokeWidth:
                                        2,
                                  ),
                                )

                              : const Row(

                                  mainAxisAlignment:
                                      MainAxisAlignment.center,

                                  children: [

                                    Icon(

                                      Icons
                                          .send_rounded,

                                      color:
                                          Colors.white,
                                    ),

                                    SizedBox(
                                        width:
                                            12),

                                    Text(

                                      "Submit Application",

                                      style:
                                          TextStyle(

                                        color:
                                            Colors.white,

                                        fontSize:
                                            16,

                                        fontWeight:
                                            FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // MODERN FIELD
  // =========================

  Widget modernField({

    required TextEditingController
        controller,

    required String hint,

    required int maxLines,

    required bool isDark,
  }) {

    return TextField(

      controller: controller,

      maxLines: maxLines,

      style: TextStyle(

        color:

            isDark

                ? Colors.white

                : Colors.black,
      ),

      decoration:
          InputDecoration(

        hintText: hint,

        hintStyle:
            TextStyle(

          color:

              isDark

                  ? Colors
                      .grey
                      .shade500

                  : Colors
                      .grey
                      .shade600,
        ),

        filled: true,

        fillColor:

            isDark

                ? const Color(
                    0xFF171726)

                : Colors.white,

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
                  24),

          borderSide:
              BorderSide.none,
        ),

        contentPadding:
            const EdgeInsets.all(
                22),
      ),
    );
  }

  // =========================
  // SECTION TITLE
  // =========================

  Widget sectionTitle(

    String text,

    bool isDark,
  ) {

    return Text(

      text,

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
  // INFO CARD
  // =========================

  Widget buildInfoCard({

    required IconData icon,

    required String title,

    required String value,

    required Color color,

    required bool isDark,
  }) {

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
                    0xFF171726)

                : Colors.white,

        borderRadius:
            BorderRadius.circular(
                24),
      ),

      child: Row(

        children: [

          Container(

            padding:
                const EdgeInsets.all(
                    14),

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

                const SizedBox(height: 6),

                Text(

                  value,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      TextStyle(

                    fontSize: 16,

                    fontWeight:
                        FontWeight.w700,

                    color:

                        isDark

                            ? Colors
                                .white

                            : const Color(
                                0xFF1A1A2E),
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
  // STEP
  // =========================

  Widget buildStep(
    String text,
    bool isDark,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 16,
      ),

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          const Padding(

            padding:
                EdgeInsets.only(
                    top: 3),

            child: Icon(

              Icons
                  .check_circle_rounded,

              color: _green,

              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(

            child: Text(

              text,

              style: TextStyle(

                height: 1.5,

                color:

                    isDark

                        ? Colors
                            .grey
                            .shade300

                        : Colors
                            .grey
                            .shade700,
              ),
            ),
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

