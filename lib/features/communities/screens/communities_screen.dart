import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/community_model.dart';

import '../../../models/user_model.dart';

import '../../profile/services/profile_service.dart';

import '../services/community_service.dart';


import 'community_details_screen.dart';

class CommunitiesScreen
    extends StatefulWidget {

  const CommunitiesScreen({
    super.key,
  });

  @override
  State<CommunitiesScreen>
      createState() =>
          _CommunitiesScreenState();
}

class _CommunitiesScreenState
    extends State<CommunitiesScreen>

    with SingleTickerProviderStateMixin {

  final ProfileService
      profileService =
      ProfileService();

  final CommunityService
      communityService =
      CommunityService();

  UserModel? currentUser;

  bool isLoading = true;

  late TabController
      _tabController;

  final TextEditingController
      searchController =
      TextEditingController();

  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      descriptionController =
      TextEditingController();

  static const Color _violet =
      Color(0xFF6C63FF);

  static const Color _violetLight =
      Color(0xFF9D8FFF);

  static const Color _green =
      Color(0xFF00C896);

  static const Color _orange =
      Color(0xFFFF8C42);

  String selectedCategory =
      "Technology";

  final List<String> categories = [

    "Technology",

    "AI",

    "Coding",

    "Robotics",

    "Startup",

    "Research",

    "Gaming",

    "Photography",

    "Music",

    "Sports",

    "Hackathon",

    "UI/UX",
  ];

  @override
  void initState() {

    super.initState();

    _tabController =
        TabController(

      length: 2,

      vsync: this,
    );

    loadUser();
  }

  @override
  void dispose() {

    _tabController.dispose();

    searchController.dispose();

    nameController.dispose();

    descriptionController.dispose();

    super.dispose();
  }

  // =========================
  // LOAD USER
  // =========================

  Future<void> loadUser()
  async {

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

    final user =

        await profileService
            .getProfile(
      firebaseUser.uid,
    );

    if (!mounted) return;

    setState(() {

      currentUser = user;

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final isDark =

        Theme.of(context)
                .brightness ==

            Brightness.dark;

    if (isLoading) {

      return Scaffold(

        backgroundColor:

            isDark

                ? const Color(
                    0xFF0B0B14)

                : const Color(
                    0xFFF5F7FF),

        body: const Center(

          child:
              CircularProgressIndicator(
            color: _violet,
          ),
        ),
      );
    }

    return Scaffold(

      backgroundColor:

          isDark

              ? const Color(
                  0xFF0B0B14)

              : const Color(
                  0xFFF5F7FF),

      floatingActionButton:

          currentUser
                      ?.isOfficialStudent ??

                  false

              ? FloatingActionButton.extended(

                  elevation: 0,

                  backgroundColor:
                      _violet,

                  onPressed: () {

                    showCreateCommunityDialog(
                      isDark,
                    );
                  },

                  icon: const Icon(

                    Icons.add_rounded,

                    color:
                        Colors.white,
                  ),

                  label: const Text(

                    "Create",

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
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
                  const EdgeInsets.only(

                left: 22,
                right: 22,
                top: 18,
                bottom: 30,
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
                              .groups_rounded,

                          color:
                              Colors.white,
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
                              .notifications_none_rounded,

                          color:
                              Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 28),

                  const Text(

                    "Campus Communities 🚀",

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

                    currentUser
                                ?.isOfficialStudent ??

                            false

                        ? "Join communities, connect with students and participate in realtime discussions."

                        : "Explore public campus communities and announcements.",

                    style:
                        TextStyle(

                      color: Colors
                          .white
                          .withOpacity(
                              0.85),

                      height: 1.6,
                    ),
                  ),

                  const SizedBox(
                      height: 26),

                  // SEARCH BAR

                  Container(

                    height: 60,

                    decoration:
                        BoxDecoration(

                      color: Colors
                          .white
                          .withOpacity(
                              0.15),

                      borderRadius:
                          BorderRadius.circular(
                              22),
                    ),

                    child: TextField(

                      controller:
                          searchController,

                      style:
                          const TextStyle(

                        color:
                            Colors.white,
                      ),

                      onChanged: (_) {

                        setState(() {});
                      },

                      decoration:
                          InputDecoration(

                        border:
                            InputBorder.none,

                        prefixIcon:
                            Icon(

                          Icons
                              .search_rounded,

                          color: Colors
                              .white
                              .withOpacity(
                                  0.7),
                        ),

                        hintText:
                            "Search communities...",

                        hintStyle:
                            TextStyle(

                          color: Colors
                              .white
                              .withOpacity(
                                  0.7),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =========================
            // TAB BAR
            // =========================

            Padding(

              padding:
                  const EdgeInsets.all(
                      20),

              child: Container(

                height: 60,

                decoration:
                    BoxDecoration(

                  color:

                      isDark

                          ? const Color(
                              0xFF1A1A2A)

                          : Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                          22),
                ),

                child: TabBar(

                  controller:
                      _tabController,

                  indicator:
                      BoxDecoration(

                    gradient:
                        const LinearGradient(

                      colors: [

                        _violet,

                        _violetLight,
                      ],
                    ),

                    borderRadius:
                        BorderRadius.circular(
                            18),
                  ),

                  labelColor:
                      Colors.white,

                  unselectedLabelColor:

                      isDark

                          ? Colors
                              .grey
                              .shade500

                          : Colors
                              .grey
                              .shade700,

                  tabs: const [

                    Tab(
                      text:
                          "Discover",
                    ),

                    Tab(
                      text:
                          "Joined",
                    ),
                  ],
                ),
              ),
            ),

            // =========================
            // COMMUNITY LIST
            // =========================

            Expanded(

              child: TabBarView(

                controller:
                    _tabController,

                children: [

                  _buildCommunities(
                    isDark,
                    false,
                  ),

                  _buildCommunities(
                    isDark,
                    true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // BUILD COMMUNITIES
  // =========================

  Widget _buildCommunities(

    bool isDark,

    bool joinedOnly,
  ) {

    return StreamBuilder<
        List<CommunityModel>>(

      stream:
          communityService
              .getCommunities(),

      builder:
          (context, snapshot) {

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

        List<CommunityModel>
            communities =

            snapshot.data ?? [];

        // SEARCH

        if (searchController
            .text
            .isNotEmpty) {

          communities =
              communities.where((c) {

            return c.name
                    .toLowerCase()
                    .contains(

                      searchController
                          .text
                          .toLowerCase(),
                    ) ||

                c.category
                    .toLowerCase()
                    .contains(

                      searchController
                          .text
                          .toLowerCase(),
                    );

          }).toList();
        }

        // JOINED FILTER

        if (joinedOnly) {

          communities =
              communities.where((c) {

            return c.members
                .contains(

              FirebaseAuth
                      .instance
                      .currentUser
                      ?.uid ??

                  "",
            );

          }).toList();
        }

        if (communities
            .isEmpty) {

          return _emptyState(
            isDark,
          );
        }

        return ListView.builder(

          physics:
              const BouncingScrollPhysics(),

          padding:
              const EdgeInsets.fromLTRB(
            20,
            0,
            20,
            120,
          ),

          itemCount:
              communities.length,

          itemBuilder:
              (context, index) {

            return _communityCard(

              communities[index],

              isDark,
            );
          },
        );
      },
    );
  }

  // =========================
  // MODERN COMMUNITY CARD
  // =========================

  Widget _communityCard(

    CommunityModel community,

    bool isDark,
  ) {

    final joined =
        community.members
            .contains(

      FirebaseAuth
              .instance
              .currentUser
              ?.uid ??

          "",
    );

    return GestureDetector(

      onTap: () {

        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (_) =>

                CommunityDetailsScreen(

              community:
                  community,
            ),
          ),
        );
      },

      child: Container(

        margin:
            const EdgeInsets.only(
          bottom: 22,
        ),

        decoration:
            BoxDecoration(

          gradient:
              LinearGradient(

            begin:
                Alignment.topLeft,

            end:
                Alignment.bottomRight,

            colors:

                isDark

                    ? [

                        const Color(
                            0xFF1C1C2E),

                        const Color(
                            0xFF141420),
                      ]

                    : [

                        Colors.white,

                        const Color(
                            0xFFF8F9FF),
                      ],
          ),

          borderRadius:
              BorderRadius.circular(
                  32),

          boxShadow: [

            BoxShadow(

              color: Colors.black
                  .withOpacity(

                isDark
                    ? 0.28
                    : 0.05,
              ),

              blurRadius: 24,

              offset:
                  const Offset(
                0,
                10,
              ),
            ),
          ],
        ),

        child: Padding(

          padding:
              const EdgeInsets.all(
                  22),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Row(

                children: [

                  Hero(

                    tag:
                        community.id,

                    child: Container(

                      height: 78,
                      width: 78,

                      decoration:
                          BoxDecoration(

                        gradient:
                            const LinearGradient(

                          colors: [

                            _violet,

                            _violetLight,
                          ],
                        ),

                        borderRadius:
                            BorderRadius.circular(
                                26),
                      ),

                      child:
                          const Icon(

                        Icons
                            .groups_rounded,

                        color:
                            Colors.white,

                        size: 36,
                      ),
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

                          community.name,

                          maxLines: 1,

                          overflow:
                              TextOverflow
                                  .ellipsis,

                          style:
                              TextStyle(

                            fontSize:
                                22,

                            fontWeight:
                                FontWeight
                                    .w800,

                            color:

                                isDark

                                    ? Colors
                                        .white

                                    : const Color(
                                        0xFF1A1A2E),
                          ),
                        ),

                        const SizedBox(
                            height: 10),

                        Row(

                          children: [

                            _chip(

                              community
                                  .category,

                              _violet,
                            ),

                            const SizedBox(
                                width: 10),

                            _chip(
                              "Active",
                              _green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                  height: 24),

              Text(

                community
                    .description,

                maxLines: 3,

                overflow:
                    TextOverflow
                        .ellipsis,

                style: TextStyle(

                  fontSize: 14,

                  height: 1.7,

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
                  height: 22),

              Row(

                children: [

                  Container(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal:
                          14,

                      vertical: 10,
                    ),

                    decoration:
                        BoxDecoration(

                      color:

                          isDark

                              ? Colors
                                  .white
                                  .withOpacity(
                                      0.05)

                              : const Color(
                                  0xFFF4F5FF),

                      borderRadius:
                          BorderRadius.circular(
                              18),
                    ),

                    child: Row(

                      children: [

                        Icon(

                          Icons
                              .people_alt_rounded,

                          size: 18,

                          color: Colors
                              .grey
                              .shade500,
                        ),

                        const SizedBox(
                            width: 8),

                        Text(

                          "${community.membersCount} Members",

                          style:
                              TextStyle(

                            fontWeight:
                                FontWeight
                                    .w600,

                            color: Colors
                                .grey
                                .shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  Container(

                    padding:
                        const EdgeInsets.symmetric(

                      horizontal:
                          18,

                      vertical: 12,
                    ),

                    decoration:
                        BoxDecoration(

                      gradient:
                          LinearGradient(

                        colors:

                            joined

                                ? [

                                    Colors
                                        .redAccent,

                                    Colors
                                        .red,
                                  ]

                                : [

                                    _violet,

                                    _violetLight,
                                  ],
                      ),

                      borderRadius:
                          BorderRadius.circular(
                              18),
                    ),

                    child: Row(

                      children: [

                        Icon(

                          joined

                              ? Icons
                                  .check_circle_rounded

                              : Icons
                                  .arrow_forward_rounded,

                          color:
                              Colors.white,

                          size: 18,
                        ),

                        const SizedBox(
                            width: 8),

                        Text(

                          joined

                              ? "Joined"

                              : "Explore",

                          style:
                              const TextStyle(

                            color:
                                Colors.white,

                            fontWeight:
                                FontWeight
                                    .w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // CHIP
  // =========================

  Widget _chip(
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
            color.withOpacity(0.12),

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
                    .all(24),

            decoration:
                BoxDecoration(

              color: _violet
                  .withOpacity(
                      0.1),

              shape:
                  BoxShape.circle,
            ),

            child: const Icon(

              Icons.groups_rounded,

              size: 70,

              color: _violet,
            ),
          ),

          const SizedBox(
              height: 22),

          Text(

            "No Communities Found",

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
        ],
      ),
    );
  }

  // =========================
  // CREATE COMMUNITY
  // =========================

  void showCreateCommunityDialog(
    bool isDark,
  ) {

    showModalBottomSheet(

      context: context,

      isScrollControlled:
          true,

      backgroundColor:
          Colors.transparent,

      builder: (_) {

        return StatefulBuilder(

          builder:
              (context,
                  setModalState) {

            return Container(

              padding:
                  EdgeInsets.only(

                left: 24,
                right: 24,
                top: 28,

                bottom:

                    MediaQuery.of(
                                context)
                            .viewInsets
                            .bottom +

                        30,
              ),

              decoration:
                  BoxDecoration(

                color:

                    isDark

                        ? const Color(
                            0xFF12121F)

                        : Colors.white,

                borderRadius:
                    const BorderRadius.only(

                  topLeft:
                      Radius.circular(
                          36),

                  topRight:
                      Radius.circular(
                          36),
                ),
              ),

              child:
                  SingleChildScrollView(

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Center(

                      child: Container(

                        width: 70,

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
                        height: 26),

                    const Text(

                      "Create Community 🚀",

                      style: TextStyle(

                        fontSize: 28,

                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    Text(

                      "Build your own student network.",

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
                        height: 28),

                    TextField(

                      controller:
                          nameController,

                      decoration:
                          InputDecoration(

                        hintText:
                            "Community Name",

                        filled: true,

                        fillColor:

                            isDark

                                ? const Color(
                                    0xFF1B1B2B)

                                : const Color(
                                    0xFFF5F6FF),

                        border:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(
                                  22),

                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    TextField(

                      controller:
                          descriptionController,

                      maxLines: 4,

                      decoration:
                          InputDecoration(

                        hintText:
                            "Community Description",

                        filled: true,

                        fillColor:

                            isDark

                                ? const Color(
                                    0xFF1B1B2B)

                                : const Color(
                                    0xFFF5F6FF),

                        border:
                            OutlineInputBorder(

                          borderRadius:
                              BorderRadius.circular(
                                  22),

                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    Container(

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),

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
                                22),
                      ),

                      child:
                          DropdownButtonHideUnderline(

                        child:
                            DropdownButton<
                                String>(

                          value:
                              selectedCategory,

                          isExpanded:
                              true,

                          items:
                              categories
                                  .map((e) {

                            return DropdownMenuItem(

                              value: e,

                              child:
                                  Text(e),
                            );
                          }).toList(),

                          onChanged:
                              (v) {

                            setModalState(() {

                              selectedCategory =
                                  v!;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 34),

                    SizedBox(

                      width:
                          double.infinity,

                      height: 58,

                      child:
                          ElevatedButton(

                        style:
                            ElevatedButton.styleFrom(

                          backgroundColor:
                              _violet,

                          shape:
                              RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(
                                    22),
                          ),
                        ),

                       onPressed: () async {

  if (nameController
          .text
          .trim()
          .isEmpty ||

      descriptionController
          .text
          .trim()
          .isEmpty) {

    showMessage(
      "Fill all fields",
    );

    return;
  }

  try {

    await communityService
        .createCommunity(

      name:
          nameController.text
              .trim(),

      description:
          descriptionController
              .text
              .trim(),

      category:
          selectedCategory,

      isOfficial: true,
    );

    if (!mounted) return;

    Navigator.pop(context);

    nameController.clear();

    descriptionController.clear();

    showMessage(
      "Community Created 🎉",
    );

  } catch (e) {

    showMessage(
      "Failed to create community",
    );
  }
},

                        child:
                            const Text(

                          "Create Community",

                          style: TextStyle(

                            color:
                                Colors.white,

                            fontSize:
                                16,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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
                  16),
        ),

        content: Text(
          message,
        ),
      ),
    );
  }
}