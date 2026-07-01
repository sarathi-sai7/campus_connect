import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/forum_post_model.dart';
import '../../../models/user_model.dart';

import '../../profile/services/profile_service.dart';

import '../services/forum_service.dart';

class ForumScreen extends StatefulWidget {

  const ForumScreen({
    super.key,
  });

  @override
  State<ForumScreen>
      createState() =>
          _ForumScreenState();
}

class _ForumScreenState
    extends State<ForumScreen> {

  final ForumService
      forumService =
      ForumService();

  final ProfileService
      profileService =
      ProfileService();

  final TextEditingController
      searchController =
      TextEditingController();

  final TextEditingController
      titleController =
      TextEditingController();

  final TextEditingController
      contentController =
      TextEditingController();

  UserModel? currentUser;

  bool isLoading = true;

  String selectedCategory =
      "General";

  final List<String> categories = [

    "General",

    "Placement",

    "Hackathon",

    "Coding",

    "Academics",

    "Internship",

    "Research",
  ];

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

      floatingActionButton:

          currentUser
                      ?.isOfficialStudent ??

                  false

              ? FloatingActionButton(

                  backgroundColor:
                      const Color(
                    0xFF6C63FF,
                  ),

                  child: const Icon(
                    Icons.add_rounded,
                    color:
                        Colors.white,
                  ),

                  onPressed: () {

                    showCreatePostDialog(
                      isDark,
                    );
                  },
                )

              : null,

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

                      const Text(

                        "Discussion Forum",

                        style: TextStyle(

                          color:
                              Colors.white,

                          fontSize: 24,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 24),

                  Container(

                    height: 56,

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

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

                    child: TextField(

                      controller:
                          searchController,

                      onChanged: (_) {

                        setState(() {});
                      },

                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                      ),

                      decoration:
                          InputDecoration(

                        border:
                            InputBorder
                                .none,

                        hintText:
                            "Search discussions...",

                        hintStyle:
                            TextStyle(

                          color: Colors
                              .white
                              .withOpacity(
                                  0.7),
                        ),

                        icon:
                            const Icon(

                          Icons
                              .search_rounded,

                          color:
                              Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // =========================
            // REALTIME POSTS
            // =========================

            Expanded(

              child:
                  StreamBuilder<
                      List<
                          ForumPostModel>>(

                stream:
                    forumService
                        .getPosts(),

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

                  List<ForumPostModel>
                      posts =

                      snapshot.data ??
                          [];

                  // SEARCH

                  if (searchController
                      .text
                      .isNotEmpty) {

                    posts =
                        posts.where((post) {

                      return post.title
                              .toLowerCase()
                              .contains(

                                searchController
                                    .text
                                    .toLowerCase(),
                              ) ||

                          post.content
                              .toLowerCase()
                              .contains(

                                searchController
                                    .text
                                    .toLowerCase(),
                              );

                    }).toList();
                  }

                  if (posts.isEmpty) {

                    return buildEmptyState(
                      isDark,
                    );
                  }

                  return ListView.builder(

                    padding:
                        const EdgeInsets.all(
                            20),

                    itemCount:
                        posts.length,

                    itemBuilder:
                        (context,
                            index) {

                      return buildPostCard(

                        post:
                            posts[index],

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
  // POST CARD
  // =========================

  Widget buildPostCard({

    required ForumPostModel
        post,

    required bool isDark,
  }) {

    bool liked =
        forumService.isLiked(
      post: post,
    );

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color:

            isDark

                ? const Color(
                    0xFF1E1E1E)

                : Colors.white,

        borderRadius:
            BorderRadius.circular(
                24),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Row(

            children: [

              CircleAvatar(

                radius: 24,

                backgroundColor:
                    const Color(
                  0xFF6C63FF,
                ),

                child: Text(

                  post.authorName
                      .isNotEmpty

                      ? post.authorName[0]
                            .toUpperCase()

                      : "S",

                  style:
                      const TextStyle(

                    color:
                        Colors.white,

                    fontWeight:
                        FontWeight.bold,
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

                      post.authorName,

                      style:
                          const TextStyle(

                        fontWeight:
                            FontWeight
                                .bold,

                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                        height: 4),

                    Text(

                      post.category,

                      style:
                          const TextStyle(

                        color:
                            Color(
                          0xFF6C63FF,
                        ),

                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(

            post.title,

            style:
                const TextStyle(

              fontSize: 20,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Text(

            post.content,

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

          const SizedBox(height: 20),

          Row(

            children: [

              GestureDetector(

                onTap: () async {

                  if (liked) {

                    await forumService
                        .unlikePost(
                      post,
                    );

                  } else {

                    await forumService
                        .likePost(
                      post,
                    );
                  }
                },

                child: Row(

                  children: [

                    Icon(

                      liked

                          ? Icons
                              .favorite_rounded

                          : Icons
                              .favorite_border_rounded,

                      color:

                          liked

                              ? Colors.red

                              : Colors
                                  .grey,
                    ),

                    const SizedBox(
                        width: 6),

                    Text(

                      "${post.likes.length}",
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 24),

              Row(

                children: [

                  const Icon(
                    Icons
                        .chat_bubble_outline_rounded,
                  ),

                  const SizedBox(
                      width: 6),

                  Text(

                    "${post.commentsCount}",
                  ),
                ],
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

  Widget buildEmptyState(
      bool isDark) {

    return Center(

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment
                .center,

        children: [

          Icon(

            Icons.forum_rounded,

            size: 90,

            color:
                Colors.grey
                    .shade500,
          ),

          const SizedBox(height: 20),

          Text(

            "No Discussions Yet",

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

            "Realtime discussions will appear here.",

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
  // CREATE POST DIALOG
  // =========================

  void showCreatePostDialog(
      bool isDark) {

    showModalBottomSheet(

      context: context,

      isScrollControlled: true,

      backgroundColor:
          Colors.transparent,

      builder: (context) {

        return Container(

          padding:
              EdgeInsets.only(

            left: 24,
            right: 24,
            top: 24,

            bottom:
                MediaQuery.of(context)
                        .viewInsets
                        .bottom +
                    24,
          ),

          decoration: BoxDecoration(

            color:

                isDark

                    ? const Color(
                        0xFF1E1E1E)

                    : Colors.white,

            borderRadius:
                const BorderRadius.only(

              topLeft:
                  Radius.circular(
                      30),

              topRight:
                  Radius.circular(
                      30),
            ),
          ),

          child: Column(

            mainAxisSize:
                MainAxisSize.min,

            children: [

              const Text(

                "Create Discussion",

                style: TextStyle(

                  fontSize: 24,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              buildField(
                titleController,
                "Discussion Title",
                isDark,
              ),

              const SizedBox(height: 18),

              buildField(
                contentController,
                "Write your discussion...",
                isDark,
                maxLines: 5,
              ),

              const SizedBox(height: 18),

              DropdownButtonFormField(

                initialValue:
                    selectedCategory,

                items:
                    categories.map((category) {

                  return DropdownMenuItem(

                    value:
                        category,

                    child:
                        Text(category),
                  );
                }).toList(),

                onChanged: (value) {

                  setState(() {

                    selectedCategory =
                        value!;
                  });
                },

                decoration:
                    InputDecoration(

                  filled: true,

                  fillColor:

                      isDark

                          ? const Color(
                              0xFF2A2A2A)

                          : const Color(
                              0xFFF4F6FF),

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                            18),

                    borderSide:
                        BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(

                width:
                    double.infinity,

                height: 56,

                child: ElevatedButton(

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        const Color(
                      0xFF6C63FF,
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                              18),
                    ),
                  ),

                  onPressed: () async {

                    await forumService
                        .createPost(

                      title:
                          titleController
                              .text
                              .trim(),

                      content:
                          contentController
                              .text
                              .trim(),

                      category:
                          selectedCategory,

                      authorName:
                          currentUser
                                  ?.name ??

                              "Student",
                    );

                    if (!mounted) {
                      return;
                    }

                    Navigator.pop(
                        context);

                    titleController
                        .clear();

                    contentController
                        .clear();

                    showMessage(
                      "Discussion Posted 🚀",
                    );
                  },

                  child: const Text(

                    "Post Discussion",

                    style: TextStyle(

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
        );
      },
    );
  }

  Widget buildField(

    TextEditingController controller,

    String hint,

    bool isDark, {

    int maxLines = 1,
  }) {

    return TextField(

      controller: controller,

      maxLines: maxLines,

      decoration: InputDecoration(

        hintText: hint,

        filled: true,

        fillColor:

            isDark

                ? const Color(
                    0xFF2A2A2A)

                : const Color(
                    0xFFF4F6FF),

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
                  18),

          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }

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
            const Color(
          0xFF6C63FF,
        ),

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
                  16),
        ),

        content: Text(

          message,

          style:
              const TextStyle(
            color:
                Colors.white,
          ),
        ),
      ),
    );
  }
}