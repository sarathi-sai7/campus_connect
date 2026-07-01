import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/chat_message_model.dart';

import '../../../models/community_model.dart';

import '../../../models/user_model.dart';

import '../../profile/services/profile_service.dart';

import '../services/chat_service.dart';

class CommunityChatScreen
    extends StatefulWidget {

  final CommunityModel community;

  const CommunityChatScreen({

    super.key,

    required this.community,
  });

  @override
  State<CommunityChatScreen>
      createState() =>
          _CommunityChatScreenState();
}

class _CommunityChatScreenState
    extends State<
        CommunityChatScreen> {

  final ChatService
      chatService =
      ChatService();

  final ProfileService
      profileService =
      ProfileService();

  final TextEditingController
      messageController =
      TextEditingController();

  final ScrollController
      scrollController =
      ScrollController();

  UserModel? currentUser;

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    loadUser();
  }

  Future<void> loadUser() async {

    final firebaseUser =

        FirebaseAuth
            .instance
            .currentUser;

    if (firebaseUser == null) {

      setState(() {

        isLoading = false;
      });

      return;
    }

    currentUser =

        await profileService
            .getProfile(
      firebaseUser.uid,
    );

    if (!mounted) return;

    setState(() {

      isLoading = false;
    });
  }

  @override
  void dispose() {

    messageController.dispose();

    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isDark =

        Theme.of(context)
                .brightness ==

            Brightness.dark;

    return Scaffold(

      resizeToAvoidBottomInset:
          true,

      backgroundColor:

          isDark

              ? const Color(
                  0xFF0F0F1A)

              : const Color(
                  0xFFF5F7FF),

      body: SafeArea(

        child: Column(

          children: [

            buildHeader(
              isDark,
            ),

            Expanded(

              child:
                  StreamBuilder<
                      List<
                          ChatMessageModel>>(

                stream:
                    chatService
                        .getMessages(

                  widget.community.id,
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

                  List<
                          ChatMessageModel>
                      messages =

                      snapshot.data ??
                          [];

                  if (messages.isEmpty) {

                    return buildEmptyState(
                      isDark,
                    );
                  }

                  WidgetsBinding
                      .instance
                      .addPostFrameCallback(
                    (_) {

                      if (scrollController
                          .hasClients) {

                        scrollController
                            .animateTo(

                          scrollController
                              .position
                              .maxScrollExtent,

                          duration:
                              const Duration(
                            milliseconds:
                                300,
                          ),

                          curve:
                              Curves.easeOut,
                        );
                      }
                    },
                  );

                  return ListView.builder(

                    controller:
                        scrollController,

                    physics:
                        const BouncingScrollPhysics(),

                    padding:
                        const EdgeInsets.all(
                            20),

                    itemCount:
                        messages.length,

                    itemBuilder:
                        (context,
                            index) {

                      return AnimatedContainer(

                        duration:
                            const Duration(
                          milliseconds:
                              250,
                        ),

                        child:
                            buildMessageBubble(

                          message:
                              messages[
                                  index],

                          isDark:
                              isDark,
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            buildMessageBox(
              isDark,
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // HEADER
  // =========================

  Widget buildHeader(
    bool isDark,
  ) {

    return Container(

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

      child: Row(

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

                color: Colors.white
                    .withOpacity(
                        0.15),

                borderRadius:
                    BorderRadius.circular(
                        14),
              ),

              child: const Icon(

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

          CircleAvatar(

            radius: 24,

            backgroundColor:
                Colors.white
                    .withOpacity(
                        0.2),

            child: Text(

              widget.community.name[0]
                  .toUpperCase(),

              style:
                  const TextStyle(

                color:
                    Colors.white,

                fontWeight:
                    FontWeight.bold,

                fontSize: 20,
              ),
            ),
          ),

          const SizedBox(
              width: 14),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  widget.community
                      .name,

                  style:
                      const TextStyle(

                    color:
                        Colors.white,

                    fontSize: 20,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 4),

                Text(

                  "${widget.community.membersCount} members online",

                  style:
                      TextStyle(

                    color: Colors
                        .white
                        .withOpacity(
                            0.8),
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
  // MESSAGE BUBBLE
  // =========================

  Widget buildMessageBubble({

    required ChatMessageModel
        message,

    required bool isDark,
  }) {

    bool isMe =

        FirebaseAuth
            .instance
            .currentUser
            ?.uid ==

        message.senderId;

    return Align(

      alignment:

          isMe

              ? Alignment
                  .centerRight

              : Alignment
                  .centerLeft,

      child: GestureDetector(

        onLongPress: () async {

          if (!isMe) return;

          showDialog(

            context: context,

            builder: (context) {

              return AlertDialog(

                title: const Text(
                  "Delete Message?",
                ),

                content:
                    const Text(

                  "This message will be removed permanently.",
                ),

                actions: [

                  TextButton(

                    onPressed: () {

                      Navigator.pop(
                          context);
                    },

                    child:
                        const Text(
                      "Cancel",
                    ),
                  ),

                  TextButton(

                    onPressed:
                        () async {

                      Navigator.pop(
                          context);

                      await chatService
                          .deleteMessage(

                        communityId:
                            widget.community.id,

                        messageId:
                            message.id,
                      );
                    },

                    child:
                        const Text(

                      "Delete",

                      style:
                          TextStyle(
                        color:
                            Colors.red,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },

        child: Container(

          constraints:
              const BoxConstraints(
            maxWidth: 300,
          ),

          margin:
              const EdgeInsets.only(
            bottom: 14,
          ),

          padding:
              const EdgeInsets.all(
                  16),

          decoration:
              BoxDecoration(

            color:

                isMe

                    ? const Color(
                        0xFF6C63FF)

                    : (isDark

                        ? const Color(
                            0xFF1E1E1E)

                        : Colors
                            .white),

            borderRadius:
                BorderRadius.only(

              topLeft:
                  const Radius.circular(
                      22),

              topRight:
                  const Radius.circular(
                      22),

              bottomLeft:

                  isMe

                      ? const Radius
                          .circular(
                          22)

                      : const Radius
                          .circular(
                          8),

              bottomRight:

                  isMe

                      ? const Radius
                          .circular(
                          8)

                      : const Radius
                          .circular(
                          22),
            ),

            boxShadow: [

              BoxShadow(

                color: Colors.black
                    .withOpacity(
                        0.04),

                blurRadius: 10,

                offset:
                    const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              if (!isMe)

                Padding(

                  padding:
                      const EdgeInsets.only(
                    bottom: 6,
                  ),

                  child: Text(

                    message.senderName,

                    style:
                        const TextStyle(

                      color:
                          Color(
                        0xFF6C63FF,
                      ),

                      fontWeight:
                          FontWeight.bold,

                      fontSize: 12,
                    ),
                  ),
                ),

              Text(

                message.message,

                style: TextStyle(

                  color:

                      isMe

                          ? Colors.white

                          : (isDark

                              ? Colors
                                  .white

                              : Colors
                                  .black),

                  height: 1.6,

                  fontSize: 15,
                ),
              ),

              const SizedBox(
                  height: 8),

              Align(

                alignment:
                    Alignment
                        .bottomRight,

                child: Text(

                  formatTime(
                    message.createdAt,
                  ),

                  style:
                      TextStyle(

                    color:

                        isMe

                            ? Colors
                                .white70

                            : Colors
                                .grey,

                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // MESSAGE BOX
  // =========================

  Widget buildMessageBox(
    bool isDark,
  ) {

    return Container(

      padding:
          const EdgeInsets.all(
              16),

      decoration: BoxDecoration(

        color:

            isDark

                ? const Color(
                    0xFF151522)

                : Colors.white,

        boxShadow: [

          BoxShadow(

            color: Colors.black
                .withOpacity(
                    0.05),

            blurRadius: 10,
          ),
        ],
      ),

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment.end,

        children: [

          Expanded(

            child: Container(

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 4,
              ),

              decoration:
                  BoxDecoration(

                color:

                    isDark

                        ? const Color(
                            0xFF1E1E1E)

                        : const Color(
                            0xFFF3F5FF),

                borderRadius:
                    BorderRadius.circular(
                        20),
              ),

              child: TextField(

                controller:
                    messageController,

                textCapitalization:
                    TextCapitalization
                        .sentences,

                minLines: 1,

                maxLines: 5,

                style: TextStyle(

                  color:

                      isDark

                          ? Colors.white

                          : Colors.black,
                ),

                decoration:
                    InputDecoration(

                  border:
                      InputBorder.none,

                  hintText:
                      "Type a message...",

                  hintStyle:
                      TextStyle(

                    color:

                        isDark

                            ? Colors.grey

                            : Colors
                                .grey
                                .shade600,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
              width: 12),

          GestureDetector(

            onTap: () async {

              if (messageController
                  .text
                  .trim()
                  .isEmpty) {

                return;
              }

              await sendMessage();
            },

            child:
                AnimatedContainer(

              duration:
                  const Duration(
                milliseconds: 200,
              ),

              padding:
                  const EdgeInsets
                      .all(16),

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

                shape:
                    BoxShape.circle,
              ),

              child: const Icon(

                Icons.send_rounded,

                color:
                    Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // SEND MESSAGE
  // =========================

  Future<void> sendMessage()
      async {

    if (messageController.text
        .trim()
        .isEmpty) {

      return;
    }

    await chatService
        .sendMessage(

      communityId:
          widget.community.id,

      senderName:
          currentUser?.name ??
              "Student",

      message:
          messageController.text
              .trim(),
    );

    messageController.clear();
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

            Icons
                .chat_bubble_outline_rounded,

            size: 90,

            color:
                Colors.grey
                    .shade500,
          ),

          const SizedBox(
              height: 20),

          Text(

            "No Messages Yet",

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

          const SizedBox(
              height: 12),

          Text(

            "No messages yet.\nBe the first to start the conversation 🚀",

            textAlign:
                TextAlign.center,

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
        ],
      ),
    );
  }

  // =========================
  // TIME FORMAT
  // =========================

  String formatTime(
    DateTime time,
  ) {

    int hour = time.hour;

    int minute = time.minute;

    String period =
        hour >= 12 ? "PM" : "AM";

    hour = hour > 12
        ? hour - 12
        : hour;

    if (hour == 0) {

      hour = 12;
    }

    return "$hour:${minute.toString().padLeft(2, '0')} $period";
  }
}