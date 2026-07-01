import 'package:flutter/material.dart';

import '../../../models/community_join_request_model.dart';

import '../services/community_request_service.dart';

class CommunityRequestsScreen
    extends StatefulWidget {

  final String communityId;

  final String communityName;

  const CommunityRequestsScreen({

    super.key,

    required this.communityId,

    required this.communityName,
  });

  @override
  State<CommunityRequestsScreen>
      createState() =>
          _CommunityRequestsScreenState();
}

class _CommunityRequestsScreenState
    extends State<CommunityRequestsScreen> {

  final CommunityRequestService
      requestService =
      CommunityRequestService();

  static const Color _violet =
      Color(0xFF6C63FF);

  static const Color _green =
      Color(0xFF00C896);

  static const Color _red =
      Color(0xFFFF4D6D);

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
                              .admin_panel_settings_rounded,

                          color:
                              Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 28),

                  const Text(

                    "Join Requests 📩",

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

                    widget.communityName,

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
            // REQUEST LIST
            // =========================

            Expanded(

              child: StreamBuilder<
                  List<
                      CommunityJoinRequestModel>>(

                stream:
                    requestService
                        .getPendingRequests(

                  widget.communityId,
                ),

                builder:

                    (context,
                        snapshot) {

                  if (snapshot
                          .connectionState ==

                      ConnectionState
                          .waiting) {

                    return const Center(

                      child:
                          CircularProgressIndicator(
                        color: _violet,
                      ),
                    );
                  }

                  final requests =
                      snapshot.data ??
                          [];

                  if (requests
                      .isEmpty) {

                    return _emptyState(
                      isDark,
                    );
                  }

                  return ListView.builder(

                    physics:
                        const BouncingScrollPhysics(),

                    padding:
                        const EdgeInsets
                            .all(20),

                    itemCount:
                        requests.length,

                    itemBuilder:
                        (context,
                            index) {

                      return requestCard(

                        requests[index],

                        isDark,
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
  // REQUEST CARD
  // =========================

  Widget requestCard(

    CommunityJoinRequestModel
        request,

    bool isDark,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 20,
      ),

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
                30),

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

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          // =========================
          // USER
          // =========================

          Row(

            children: [

              Container(

                height: 60,
                width: 60,

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
                          20),
                ),

                child:
                    const Icon(

                  Icons.person_rounded,

                  color:
                      Colors.white,

                  size: 30,
                ),
              ),

              const SizedBox(
                  width: 16),

              Expanded(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(

                      request.userName,

                      maxLines: 1,

                      overflow:
                          TextOverflow
                              .ellipsis,

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

                    const SizedBox(
                        height: 6),

                    Text(

                      request.userEmail,

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
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(
              height: 22),

          // =========================
          // REASON
          // =========================

          Text(

            "Reason",

            style: TextStyle(

              fontWeight:
                  FontWeight.w700,

              color:

                  isDark

                      ? Colors.white

                      : const Color(
                          0xFF1A1A2E),
            ),
          ),

          const SizedBox(
              height: 12),

          Container(

            width: double.infinity,

            padding:
                const EdgeInsets.all(
                    18),

            decoration:
                BoxDecoration(

              color:

                  isDark

                      ? Colors.white
                          .withOpacity(
                              0.04)

                      : const Color(
                          0xFFF5F7FF),

              borderRadius:
                  BorderRadius.circular(
                      22),
            ),

            child: Text(

              request.reason,

              style: TextStyle(

                height: 1.6,

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

          const SizedBox(
              height: 24),

          // =========================
          // ACTION BUTTONS
          // =========================

          Row(

            children: [

              Expanded(

                child:
                    ElevatedButton(

                  style:
                      ElevatedButton.styleFrom(

                    elevation: 0,

                    backgroundColor:
                        _red,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                              18),
                    ),
                  ),

                  onPressed:
                      () async {

                    await requestService
                        .rejectRequest(

                      requestId:
                          request.id,
                    );

                    if (!mounted) {
                      return;
                    }

                    showMessage(
                      "Request Rejected",
                    );
                  },

                  child:
                      const Text(

                    "Reject",

                    style:
                        TextStyle(

                      color:
                          Colors.white,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                  width: 16),

              Expanded(

                child:
                    ElevatedButton(

                  style:
                      ElevatedButton.styleFrom(

                    elevation: 0,

                    backgroundColor:
                        _green,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                              18),
                    ),
                  ),

                  onPressed:
                      () async {

                    await requestService
                        .approveRequest(

                      requestId:
                          request.id,

                      communityId:
                          request.communityId,

                      userId:
                          request.userId,
                    );

                    if (!mounted) {
                      return;
                    }

                    showMessage(
                      "Student Approved 🎉",
                    );
                  },

                  child:
                      const Text(

                    "Approve",

                    style:
                        TextStyle(

                      color:
                          Colors.white,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================
  // EMPTY STATE
  // =========================

  Widget _emptyState(
    bool isDark,
  ) {

    return Center(

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment
                .center,

        children: [

          Container(

            padding:
                const EdgeInsets
                    .all(26),

            decoration:
                BoxDecoration(

              color:
                  _violet.withOpacity(
                      0.1),

              shape:
                  BoxShape.circle,
            ),

            child: const Icon(

              Icons
                  .mark_email_read_rounded,

              size: 70,

              color: _violet,
            ),
          ),

          const SizedBox(
              height: 24),

          Text(

            "No Pending Requests",

            style: TextStyle(

              fontSize: 24,

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
              height: 10),

          Text(

            "New applications will appear here.",

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
