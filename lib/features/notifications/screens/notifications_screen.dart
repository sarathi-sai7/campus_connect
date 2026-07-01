import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/notification_model.dart';

import '../services/notification_service.dart';

class NotificationsScreen
    extends StatefulWidget {

  const NotificationsScreen({
    super.key,
  });

  @override
  State<NotificationsScreen>
      createState() =>
          _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<
        NotificationsScreen> {

  final NotificationService
      notificationService =
      NotificationService();

  String uid =

      FirebaseAuth
              .instance
              .currentUser
              ?.uid ??

          "";

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
                  0xFF0F0F1A)

              : const Color(
                  0xFFF4F6FF),

      body: SafeArea(

        child: Column(

          children: [

            // =========================
            // HEADER
            // =========================

            Container(

              padding:
                  const EdgeInsets.all(
                      20),

              decoration:
                  const BoxDecoration(

                gradient:
                    LinearGradient(

                  colors: [

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
                          30),

                  bottomRight:
                      Radius.circular(
                          30),
                ),
              ),

              child: Column(

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
                                  .all(10),

                          decoration:
                              BoxDecoration(

                            color: Colors
                                .white
                                .withOpacity(
                                    0.15),

                            borderRadius:
                                BorderRadius.circular(
                                    14),
                          ),

                          child:
                              const Icon(

                            Icons
                                .arrow_back_ios_new_rounded,

                            color:
                                Colors.white,

                            size: 18,
                          ),
                        ),
                      ),

                      const SizedBox(
                          width: 16),

                      const Expanded(

                        child: Text(

                          "Notifications",

                          style: TextStyle(

                            color:
                                Colors
                                    .white,

                            fontSize: 24,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ),

                      GestureDetector(

                        onTap: () async {

                          await notificationService
                              .markAllAsRead(
                            uid,
                          );

                          if (!mounted) {
                            return;
                          }

                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(

                            const SnackBar(

                              content: Text(

                                "All notifications marked as read",
                              ),
                            ),
                          );
                        },

                        child: Container(

                          padding:
                              const EdgeInsets.symmetric(

                            horizontal:
                                14,

                            vertical:
                                10,
                          ),

                          decoration:
                              BoxDecoration(

                            color: Colors
                                .white
                                .withOpacity(
                                    0.15),

                            borderRadius:
                                BorderRadius.circular(
                                    14),
                          ),

                          child:
                              const Text(

                            "Read All",

                            style:
                                TextStyle(

                              color: Colors
                                  .white,

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 20),

                  const Align(

                    alignment:
                        Alignment
                            .centerLeft,

                    child: Text(

                      "Realtime updates from communities, forums, events and announcements.",

                      style: TextStyle(

                        color:
                            Colors.white,

                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // =========================
            // REALTIME NOTIFICATIONS
            // =========================

            Expanded(

              child:
                  StreamBuilder<
                      List<
                          NotificationModel>>(

                stream:
                    notificationService
                        .getNotifications(
                      uid,
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
                          CircularProgressIndicator(),
                    );
                  }

                  if (snapshot
                      .hasError) {

                    return const Center(

                      child: Text(
                        "Something went wrong",
                      ),
                    );
                  }

                  List<
                          NotificationModel>
                      notifications =

                      snapshot.data ??
                          [];

                  if (notifications
                      .isEmpty) {

                    return buildEmptyState(
                      isDark,
                    );
                  }

                  return ListView.builder(

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),

                    itemCount:
                        notifications
                            .length,

                    itemBuilder:
                        (context,
                            index) {

                      return buildNotificationCard(

                        notification:
                            notifications[
                                index],

                        isDark:
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
  // NOTIFICATION CARD
  // =========================

  Widget buildNotificationCard({

    required NotificationModel
        notification,

    required bool isDark,
  }) {

    return Dismissible(

      key: Key(notification.id),

      direction:
          DismissDirection
              .endToStart,

      background: Container(

        margin:
            const EdgeInsets.only(
          bottom: 16,
        ),

        padding:
            const EdgeInsets.symmetric(
          horizontal: 24,
        ),

        alignment:
            Alignment.centerRight,

        decoration: BoxDecoration(

          color: Colors.red,

          borderRadius:
              BorderRadius.circular(
                  22),
        ),

        child: const Icon(

          Icons.delete_rounded,

          color: Colors.white,
        ),
      ),

      onDismissed: (_) async {

        await notificationService
            .deleteNotification(
          notification.id,
        );
      },

      child: GestureDetector(

        onTap: () async {

          if (!notification
              .isRead) {

            await notificationService
                .markAsRead(
              notification.id,
            );
          }
        },

        child: Container(

          margin:
              const EdgeInsets.only(
            bottom: 16,
          ),

          padding:
              const EdgeInsets.all(
                  18),

          decoration:
              BoxDecoration(

            color:

                notification
                        .isRead

                    ? (isDark

                        ? const Color(
                            0xFF1E1E1E)

                        : Colors
                            .white)

                    : const Color(
                        0xFF6C63FF)
                        .withOpacity(
                            0.08),

            borderRadius:
                BorderRadius.circular(
                    22),

            border: Border.all(

              color:

                  notification
                          .isRead

                      ? Colors
                          .transparent

                      : const Color(
                          0xFF6C63FF)
                          .withOpacity(
                              0.2),
            ),
          ),

          child: Row(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Container(

                padding:
                    const EdgeInsets
                        .all(14),

                decoration:
                    BoxDecoration(

                  color:
                      getTypeColor(
                    notification.type,
                  ).withOpacity(0.15),

                  borderRadius:
                      BorderRadius.circular(
                          16),
                ),

                child: Icon(

                  getTypeIcon(
                    notification.type,
                  ),

                  color:
                      getTypeColor(
                    notification.type,
                  ),
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

                    Row(

                      children: [

                        Expanded(

                          child: Text(

                            notification
                                .title,

                            style:
                                TextStyle(

                              fontSize:
                                  16,

                              fontWeight:
                                  FontWeight
                                      .bold,

                              color:

                                  isDark

                                      ? Colors
                                          .white

                                      : Colors
                                          .black,
                            ),
                          ),
                        ),

                        if (!notification
                            .isRead)

                          Container(

                            height: 10,
                            width: 10,

                            decoration:
                                const BoxDecoration(

                              color:
                                  Color(
                                0xFF6C63FF,
                              ),

                              shape:
                                  BoxShape
                                      .circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(
                        height: 8),

                    Text(

                      notification
                          .message,

                      style: TextStyle(

                        height: 1.5,

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

                    Text(

                      formatTimeAgo(
                        notification
                            .createdAt,
                      ),

                      style:
                          TextStyle(

                        color: Colors
                            .grey
                            .shade500,

                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // EMPTY STATE
  // =========================

  Widget buildEmptyState(
      bool isDark) {

    return Center(

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment
                .center,

        children: [

          Icon(

            Icons.notifications_none_rounded,

            size: 90,

            color:
                Colors.grey
                    .shade500,
          ),

          const SizedBox(height: 20),

          Text(

            "No Notifications Yet",

            style: TextStyle(

              fontSize: 24,

              fontWeight:
                  FontWeight.bold,

              color:

                  isDark

                      ? Colors.white

                      : Colors.black,
            ),
          ),

          const SizedBox(height: 12),

          Text(

            "Realtime notifications will appear here.",

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
    );
  }

  // =========================
  // ICONS
  // =========================

  IconData getTypeIcon(
    String type,
  ) {

    switch (type) {

      case "community":

        return Icons.groups_rounded;

      case "event":

        return Icons.event_rounded;

      case "forum":

        return Icons.forum_rounded;

      case "announcement":

        return Icons.campaign_rounded;

      case "like":

        return Icons.favorite_rounded;

      case "erp":

        return Icons.school_rounded;

      default:

        return Icons.notifications;
    }
  }

  // =========================
  // COLORS
  // =========================

  Color getTypeColor(
    String type,
  ) {

    switch (type) {

      case "community":

        return Colors.blue;

      case "event":

        return Colors.orange;

      case "forum":

        return Colors.green;

      case "announcement":

        return Colors.purple;

      case "like":

        return Colors.red;

      case "erp":

        return Colors.teal;

      default:

        return Colors.grey;
    }
  }

  // =========================
  // TIME FORMAT
  // =========================

  String formatTimeAgo(
    DateTime dateTime,
  ) {

    final difference =

        DateTime.now()
            .difference(dateTime);

    if (difference.inSeconds <
        60) {

      return "Just now";
    }

    if (difference.inMinutes <
        60) {

      return "${difference.inMinutes}m ago";
    }

    if (difference.inHours <
        24) {

      return "${difference.inHours}h ago";
    }

    if (difference.inDays < 7) {

      return "${difference.inDays}d ago";
    }

    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
}