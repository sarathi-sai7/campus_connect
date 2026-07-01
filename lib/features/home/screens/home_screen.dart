import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/user_model.dart';

import '../../../providers/user_provider.dart';

import '../../auth/services/auth_service.dart';

import '../../auth/screens/login_screen.dart';

import '../../profile/screens/profile_screen.dart';

import '../../settings/screens/settings_screen.dart';

import '../../communities/screens/communities_screen.dart';

import '../../events/screens/events_screen.dart';

import '../../forums/screens/forum_screen.dart';

import '../../notifications/screens/notifications_screen.dart';

import '../../admin/screens/admin_dashboard_screen.dart';

import '../../notifications/services/notification_service.dart';

class HomeScreen
    extends ConsumerStatefulWidget {

  const HomeScreen({
    super.key,
  });

  @override
  ConsumerState<HomeScreen>
      createState() =>
          _HomeScreenState();
}

class _HomeScreenState
    extends ConsumerState<HomeScreen>

    with
        SingleTickerProviderStateMixin {

  late AnimationController
      _animController;

  late Animation<double>
      _fadeAnim;

  User? get firebaseUser =>

      FirebaseAuth
          .instance
          .currentUser;

  final NotificationService
      notificationService =
      NotificationService();

  static const _violet =
      Color(0xFF6C63FF);

  static const _violetLight =
      Color(0xFF8B80FF);

  static const _pink =
      Color(0xFFE84393);

  static const _orange =
      Color(0xFFFF8C42);

  static const _green =
      Color(0xFF00C896);

  static const _blue =
      Color(0xFF2979FF);

  @override
  void initState() {

    super.initState();

    _animController =
        AnimationController(

      vsync: this,

      duration:
          const Duration(
        milliseconds: 700,
      ),
    );

    _fadeAnim = CurvedAnimation(

      parent: _animController,

      curve: Curves.easeOut,
    );

    _animController.forward();
  }

  @override
  void dispose() {

    _animController.dispose();

    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final isDark =

        Theme.of(context)
                .brightness ==

            Brightness.dark;

   final firebaseUser =
    FirebaseAuth
        .instance
        .currentUser;

final userAsync = ref.watch(

  userProvider(
    firebaseUser?.uid ?? "",
  ),
);
    

    return Scaffold(

      backgroundColor:

          isDark

              ? const Color(
                  0xFF0B0B14)

              : const Color(
                  0xFFF5F7FF),

      drawer:
          buildDrawer(

        isDark,

        userAsync.value,
      ),

      body:
          userAsync.when(

        data: (user) {
          final isSuperAdmin =
    user?.role ==
        "super_admin";

final isStudent =
    user?.role ==
        "student";

          return FadeTransition(

            opacity: _fadeAnim,

            child: SafeArea(

              child:
                  CustomScrollView(

                physics:
                    const BouncingScrollPhysics(),

                slivers: [

                  SliverToBoxAdapter(

                    child:
                        buildHeader(

                      isDark,

                      user,
                    ),
                  ),

                  SliverToBoxAdapter(

                    child: Padding(

                      padding:
                          const EdgeInsets.only(
                        top: 26,
                      ),

                      child:
                          buildQuickActions(
                        user,
                        isDark,
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(

                    child:
                        buildCommunitySection(
                      user,
                      isDark,
                    ),
                  ),

                 // SliverToBoxAdapter(

                  //  child:
                   //     buildPublicSection(
                   //   isDark,
                   // ),
                  //),

                 if (user != null &&
    user.role == "student")

                    SliverToBoxAdapter(

                      child:
                          buildStudentSection(

                        user,

                        isDark,
                      ),
                    ),

                if (user != null &&
    user.role == "guest")

                    SliverToBoxAdapter(

                      child:
                          buildGuestSection(
                        isDark,
                      ),
                    ),

                  const SliverToBoxAdapter(

                    child: SizedBox(
                      height: 40,
                    ),
                  ),
                  if (isSuperAdmin)

  SliverToBoxAdapter(

    child: Padding(

      padding:
          const EdgeInsets.only(
        top: 20,
      ),

      child: Container(

        margin:
            const EdgeInsets.symmetric(
          horizontal: 20,
        ),

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

              Color(
                  0xFF4C3FD4),

              Color(
                  0xFF6C63FF),

              Color(
                  0xFF9D8FFF),
            ],
          ),

          borderRadius:
              BorderRadius.circular(
                  30),

          boxShadow: [

            BoxShadow(

              color:
                  _violet.withOpacity(
                0.25,
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
                          .all(14),

                  decoration:
                      BoxDecoration(

                    color: Colors
                        .white
                        .withOpacity(
                            0.16),

                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),

                  child: const Icon(

                    Icons
                        .admin_panel_settings_rounded,

                    color:
                        Colors.white,

                    size: 30,
                  ),
                ),

                const Spacer(),

                Container(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal: 14,

                    vertical: 8,
                  ),

                  decoration:
                      BoxDecoration(

                    color: Colors
                        .white
                        .withOpacity(
                            0.15),

                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),

                  child: const Text(

                    "SUPER ADMIN",

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize: 11,

                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
                height: 24),

            const Text(

              "Campus Control Center",

              style: TextStyle(

                color:
                    Colors.white,

                fontSize: 24,

                fontWeight:
                    FontWeight.w900,
              ),
            ),

            const SizedBox(
                height: 10),

            Text(

              "Manage official communities, events, notices and campus operations.",

              style: TextStyle(

                color: Colors.white
                    .withOpacity(
                        0.82),

                height: 1.6,
              ),
            ),

            const SizedBox(
                height: 24),

            GestureDetector(

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                                AdminDashboardScreen(),
                  ),
                );
              },

              child: Container(

                padding:
                    const EdgeInsets.symmetric(

                  horizontal: 18,

                  vertical: 16,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),

                child: const Row(

                  children: [

                    Icon(

                      Icons
                          .dashboard_customize_rounded,

                      color:
                          _violet,
                    ),

                    SizedBox(
                        width: 14),

                    Expanded(

                      child: Text(

                        "Open Admin Dashboard",

                        style:
                            TextStyle(

                          color:
                              _violet,

                          fontWeight:
                              FontWeight.w800,

                          fontSize:
                              16,
                        ),
                      ),
                    ),

                    Icon(

                      Icons
                          .arrow_forward_ios_rounded,

                      color:
                          _violet,

                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
                ],
              ),
            ),
          );
        },

        loading: () =>
            const Center(

          child:
              CircularProgressIndicator(
            color: _violet,
          ),
        ),

        error: (e, _) =>
            Center(
          child: Text(
            e.toString(),
          ),
        ),
      ),
    );
  }

  // HEADER

  Widget buildHeader(

    bool isDark,

    UserModel? user,
  ) {

    return Container(

      padding:
          const EdgeInsets.only(

        left: 20,
        right: 20,
        top: 12,
        bottom: 32,
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
              Radius.circular(36),

          bottomRight:
              Radius.circular(36),
        ),
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment
                .start,

        children: [

          Row(

            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [

              Builder(

                builder: (ctx) {

                  return GestureDetector(

                    onTap: () {

                      Scaffold.of(ctx)
                          .openDrawer();
                    },

                    child:
                        _glassButton(

                      Icons.menu_rounded,
                    ),
                  );
                },
              ),

              Row(

                children: [

                  if (firebaseUser !=
                      null)

                    StreamBuilder<int>(

                      stream:
                          notificationService
                              .getUnreadCount(

                        firebaseUser!.uid,
                      ),

                      builder:
                          (context,
                              snapshot) {

                        final unread =
                            snapshot.data ??
                                0;

                        return Stack(

                          children: [

                            GestureDetector(

                              onTap: () {

                                Navigator.push(

                                  context,

                                  MaterialPageRoute(

                                    builder: (_) =>

                                        const NotificationsScreen(),
                                  ),
                                );
                              },

                              child:
                                  _glassButton(

                                Icons
                                    .notifications_rounded,
                              ),
                            ),

                            if (unread >
                                0)

                              Positioned(

                                right: 0,
                                top: 0,

                                child:
                                    Container(

                                  padding:
                                      const EdgeInsets.all(
                                    5,
                                  ),

                                  decoration:
                                      const BoxDecoration(

                                    color:
                                        Colors.red,

                                    shape:
                                        BoxShape.circle,
                                  ),

                                  child:
                                      Text(

                                    unread >
                                            99

                                        ? "99+"

                                        : unread
                                            .toString(),

                                    style:
                                        const TextStyle(

                                      color:
                                          Colors.white,

                                      fontSize:
                                          9,

                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                  const SizedBox(
                      width: 12),

                  GestureDetector(

                    onTap: () {

                      if (firebaseUser ==
                          null) {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                                const LoginScreen(),
                          ),
                        );

                      } else {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (_) =>

                                const ProfileScreen(),
                          ),
                        );
                      }
                    },

                    child: Container(

                      height: 46,
                      width: 46,

                      decoration:
                          BoxDecoration(

                        shape:
                            BoxShape.circle,

                        color:
                            Colors.white,
                      ),

                      child: Icon(

                        firebaseUser ==
                                null

                            ? Icons
                                .login_rounded

                            : Icons
                                .person_rounded,

                        color:
                            _violet,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
              height: 28),

          Text(

            _greet(),

            style: TextStyle(

              color: Colors.white
                  .withOpacity(0.8),

              fontSize: 14,
            ),
          ),

          const SizedBox(height: 8),

          Text(

            user == null

                ? "Welcome 👋"

                : "Hey ${user.name.split(' ').first} 👋",

            style:
                const TextStyle(

              fontSize: 30,

              fontWeight:
                  FontWeight.w800,

              color:
                  Colors.white,
            ),
          ),

          const SizedBox(
              height: 10),

          Text(

            user == null

    ? "Explore campus life"

    : user.role == "super_admin"

        ? "Manage your campus ecosystem"

        : user.role == "student"

            ? "Your student hub is ready"

            : "Explore public campus updates",
            style: TextStyle(

              color: Colors.white
                  .withOpacity(0.75),

              fontSize: 14,

              height: 1.5,
            ),
          ),

          const SizedBox(
              height: 24),

          // MODERN SEARCH

          Container(

  height: 58,

  decoration: BoxDecoration(

    color:

        isDark

            ? const Color(
                0xFF1A1A28)

            : Colors.white,

    borderRadius:
        BorderRadius.circular(
            22),

    boxShadow: [

      BoxShadow(

        color: Colors.black
            .withOpacity(
                0.04),

        blurRadius: 18,

        offset:
            const Offset(0, 8),
      ),
    ],
  ),

  child: TextField(

    style: TextStyle(

      color:

          isDark

              ? Colors.white

              : Colors.black,
    ),

    decoration: InputDecoration(

      border:
          InputBorder.none,

      hintText:
          "Search communities, events...",

      hintStyle: TextStyle(

        color:

            isDark

                ? Colors
                    .grey
                    .shade500

                : Colors
                    .grey
                    .shade600,
      ),

      prefixIcon: Icon(

        Icons.search_rounded,

        color:

            isDark

                ? Colors
                    .grey
                    .shade400

                : Colors
                    .grey
                    .shade700,
      ),

      suffixIcon: Container(

        margin:
            const EdgeInsets.all(
                8),

        decoration:
            BoxDecoration(

          color: _violet,

          borderRadius:
              BorderRadius.circular(
                  14),
        ),

        child: const Icon(

          Icons.tune_rounded,

          color: Colors.white,

          size: 20,
        ),
      ),

      contentPadding:
          const EdgeInsets.symmetric(
        vertical: 18,
      ),
    ),
  ),
)
        ],
      ),
    );
  }

  // QUICK ACTIONS

  Widget buildQuickActions(

    UserModel? user,

    bool isDark,
  ) {

   final isStudent =
    user?.role == "student";

    return Padding(

      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          _sectionHeader(

            "Quick Access",

            isDark: isDark,
          ),

          const SizedBox(
              height: 18),

          SizedBox(

            height: 110,

            child: ListView(

              scrollDirection:
                  Axis.horizontal,

              physics:
                  const BouncingScrollPhysics(),

              children: [

                quickBubble(

                  Icons.event_rounded,

                  "Events",

                  _orange,

                  () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>

                            const EventsScreen(),
                      ),
                    );
                  },
                ),

                quickBubble(

                  Icons.forum_rounded,

                  "Forums",

                  _pink,

                  () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>

                            const ForumScreen(),
                      ),
                    );
                  },
                ),

                quickBubble(

                  Icons
                      .campaign_rounded,

                  "Notices",

                  _green,

                  () {},
                ),

                if (isStudent)

                  quickBubble(

                    Icons
                        .groups_rounded,

                    "Communities",

                    _violet,

                    () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>

                              const CommunitiesScreen(),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget quickBubble(

    IconData icon,

    String label,

    Color color,

    VoidCallback onTap,
  ) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        width: 92,

        margin:
            const EdgeInsets.only(
          right: 14,
        ),

        child: Column(

          children: [

            Container(

              height: 68,
              width: 68,

              decoration:
                  BoxDecoration(

                shape:
                    BoxShape.circle,

                color:
                    color.withOpacity(
                  0.12,
                ),
              ),

              child: Icon(

                icon,

                color: color,

                size: 30,
              ),
            ),

            const SizedBox(
                height: 10),

            Text(

              label,

              textAlign:
                  TextAlign.center,

              maxLines: 1,

              overflow:
                  TextOverflow.ellipsis,

              style: TextStyle(

                color: color,

                fontWeight:
                    FontWeight.w700,

                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // COMMUNITIES

 Widget buildCommunitySection(

  UserModel? user,

  bool isDark,
) {

  if (user == null ||

      (user.role != "student" &&
       user.role != "super_admin")) {

    return const SizedBox();
  }

  return Padding(

    padding:
        const EdgeInsets.only(
      top: 18,
    ),

    child: Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Padding(

          padding:
              const EdgeInsets.symmetric(
            horizontal: 20,
          ),

          child: _sectionHeader(

            "Communities",

            isDark: isDark,
          ),
        ),

        const SizedBox(
            height: 18),

        SizedBox(

          height: 165,

          child: StreamBuilder(

            stream:
                FirebaseFirestore
                    .instance
                    .collection(
                        "communities")
                    .snapshots(),

            builder:
                (context, snapshot) {

              if (!snapshot.hasData) {

                return const Center(

                  child:
                      CircularProgressIndicator(),
                );
              }

              final docs =
                  snapshot.data!.docs;

              if (docs.isEmpty) {

                return const Center(

                  child: Text(
                    "No communities yet",
                  ),
                );
              }

              return ListView.builder(

                scrollDirection:
                    Axis.horizontal,

                physics:
                    const BouncingScrollPhysics(),

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                itemCount:
                    docs.length,

                itemBuilder:
                    (context, index) {

                  final data =
                      docs[index].data();

                  return GestureDetector(

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>

                              const CommunitiesScreen(),
                        ),
                      );
                    },

                    child: Container(

                      width: 170,

                      margin:
                          const EdgeInsets.only(
                        right: 16,
                      ),

                      padding:
                          const EdgeInsets.all(
                              18),

                      decoration:
                          BoxDecoration(

                        color:

                            isDark

                                ? const Color(
                                    0xFF1A1A28)

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

                            child: const Icon(

                              Icons
                                  .groups_rounded,

                              color:
                                  _violet,
                            ),
                          ),

                          const Spacer(),

                          Text(

                            data["name"] ??
                                "",

                            maxLines: 1,

                            overflow:
                                TextOverflow
                                    .ellipsis,

                            style:
                                TextStyle(

                              fontWeight:
                                  FontWeight
                                      .w800,

                              fontSize: 16,

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

                            "${data["membersCount"] ?? 0} members",

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
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}
  // ANNOUNCEMENTS

  Widget buildPublicSection(
    bool isDark,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
        top: 20,
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Padding(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            child: _sectionHeader(

              "Campus Feed",

              isDark: isDark,
            ),
          ),

          const SizedBox(
              height: 16),

          buildFeedCard(

            "National Hackathon 2026",

            "Registrations are open now 🚀",

            Icons.code_rounded,

            _violet,

            isDark,
          ),

          buildFeedCard(

            "AI Workshop",

            "Open workshop for all students.",

            Icons.smart_toy_rounded,

            _orange,

            isDark,
          ),

          buildFeedCard(

            "Placement Drive",

            "Top companies visiting campus.",

            Icons.work_rounded,

            _green,

            isDark,
          ),
        ],
      ),
    );
  }

  Widget buildFeedCard(

    String title,

    String subtitle,

    IconData icon,

    Color color,

    bool isDark,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(

        left: 20,
        right: 20,
        bottom: 14,
      ),

      padding:
          const EdgeInsets.all(18),

      decoration:
          BoxDecoration(

        color:

            isDark

                ? const Color(
                    0xFF1A1A28)

                : Colors.white,

        borderRadius:
            BorderRadius.circular(
                26),
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

          const SizedBox(
              width: 16),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  title,

                  style:
                      TextStyle(

                    fontWeight:
                        FontWeight
                            .w700,

                    fontSize: 15,

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

                  subtitle,

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
    );
  }

  // STUDENT HUB

  Widget buildStudentSection(

    UserModel user,

    bool isDark,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
        top: 18,
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Padding(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            child: _sectionHeader(

              "Student Hub",

              isDark: isDark,
            ),
          ),

          const SizedBox(
              height: 18),

          SizedBox(

            height: 180,

            child: ListView(

              scrollDirection:
                  Axis.horizontal,

              physics:
                  const BouncingScrollPhysics(),

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              children: [

                modernMiniCard(

                  "Attendance",

                  "92%",

                  Icons
                      .fact_check_rounded,

                  _green,

                  isDark,
                ),

                modernMiniCard(

                  "Marks",

                  "8.7 CGPA",

                  Icons
                      .bar_chart_rounded,

                  _orange,

                  isDark,
                ),

                modernMiniCard(

                  "Communities",

                  "${user.joinedCommunities.length}",

                  Icons
                      .groups_rounded,

                  _violet,

                  isDark,
                ),

                modernMiniCard(

                  "Activities",

                  "${user.activities.length}",

                  Icons
                      .local_activity_rounded,

                  _pink,

                  isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget modernMiniCard(

    String title,

    String value,

    IconData icon,

    Color color,

    bool isDark,
  ) {

    return Container(

      width: 150,

      margin:
          const EdgeInsets.only(
        right: 16,
      ),

      padding:
          const EdgeInsets.all(20),

      decoration:
          BoxDecoration(

        color:

            isDark

                ? const Color(
                    0xFF1A1A28)

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

          Container(

            padding:
                const EdgeInsets.all(
              12,
            ),

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

          const Spacer(),

          Text(

            value,

            style:
                TextStyle(

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
              height: 6),

          Text(

            title,

            style: TextStyle(

              color:

                  isDark

                      ? Colors.grey
                          .shade400

                      : Colors.grey
                          .shade700,
            ),
          ),
        ],
      ),
    );
  }

  // GUEST

  Widget buildGuestSection(
    bool isDark,
  ) {

    return Container(

      margin:
          const EdgeInsets.all(20),

      padding:
          const EdgeInsets.all(24),

      decoration:
          BoxDecoration(

        borderRadius:
            BorderRadius.circular(
                28),

        gradient:
            LinearGradient(

          colors: [

            _violet.withOpacity(
                0.08),

            _pink.withOpacity(
                0.06),
          ],
        ),
      ),

      child: Column(

        children: [

          const Icon(

            Icons.lock_rounded,

            size: 50,

            color: _violet,
          ),

          const SizedBox(
              height: 16),

          Text(

            "Official Student Access",

            style:
                TextStyle(

              fontSize: 20,

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

            "Login with official college email to unlock ERP and communities.",

            textAlign:
                TextAlign.center,

            style:
                TextStyle(

              height: 1.5,

              color:

                  isDark

                      ? Colors.grey
                          .shade400

                      : Colors.grey
                          .shade700,
            ),
          ),
        ],
      ),
    );
  }

  // DRAWER

  Widget buildDrawer(

    bool isDark,

    UserModel? user,
  ) {

    return Drawer(

      backgroundColor:

          isDark

              ? const Color(
                  0xFF12121F)

              : Colors.white,

      child: Column(

        children: [

          DrawerHeader(

            decoration:
                const BoxDecoration(

              gradient:
                  LinearGradient(

                colors: [

                  Color(
                      0xFF4C3FD4),

                  Color(
                      0xFF6C63FF),
                ],
              ),
            ),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                const CircleAvatar(

                  radius: 32,

                  backgroundColor:
                      Colors.white,

                  child: Icon(

                    Icons.person,

                    size: 34,
                  ),
                ),

                const Spacer(),

                Text(

                 user == null

    ? "Guest User"

    : user.role ==
            "super_admin"

        ? "Super Admin"

        : user.role ==
                "student"

            ? "Official Student"

            : "Guest User"  ,
                  style:
                      const TextStyle(

                    color:
                        Colors.white,

                    fontSize: 22,

                    fontWeight:
                        FontWeight.w800,
                  ),
                ),

                const SizedBox(
                    height: 6),

                Text(

                  firebaseUser
                          ?.email ??

                      "",

                  style:
                      TextStyle(

                    color: Colors.white
                        .withOpacity(
                            0.8),
                  ),
                ),
              ],
            ),
          ),

          _drawerTile(

            Icons.settings_rounded,

            "Settings",

            isDark,

            () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) =>

                      const SettingsScreen(),
                ),
              );
            },
          ),

          const Spacer(),

          if (firebaseUser != null)

            Padding(

              padding:
                  const EdgeInsets.all(
                      16),

              child:
                  GestureDetector(

                onTap: () async {

  await ref
      .read(authServiceProvider)
      .logoutUser();

  if (!mounted) return;

 await ref
    .read(authServiceProvider)
    .logoutUser();

if (!mounted) return;

Navigator.pop(context);
},

                child: Container(

                  padding:
                      const EdgeInsets.all(
                          14),

                  decoration:
                      BoxDecoration(

                    color: Colors.red
                        .withOpacity(
                            0.08),

                    borderRadius:
                        BorderRadius.circular(
                            16),
                  ),

                  child:
                      const Row(

                    children: [

                      Icon(

                        Icons
                            .logout_rounded,

                        color:
                            Colors.red,
                      ),

                      SizedBox(
                          width:
                              14),

                      Text(

                        "Logout",

                        style:
                            TextStyle(

                          color:
                              Colors.red,

                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _drawerTile(

    IconData icon,

    String title,

    bool isDark,

    VoidCallback onTap,
  ) {

    return ListTile(

      leading: Icon(

        icon,

        color: _violet,
      ),

      title: Text(

        title,

        style:
            TextStyle(

          color:

              isDark

                  ? Colors.white

                  : const Color(
                      0xFF1A1A2E),
        ),
      ),

      onTap: onTap,
    );
  }

  Widget _sectionHeader(

    String title, {

    required bool isDark,
  }) {

    return Text(

      title,

      style: TextStyle(

        fontSize: 22,

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

  Widget _glassButton(
    IconData icon,
  ) {

    return Container(

      padding:
          const EdgeInsets.all(10),

      decoration:
          BoxDecoration(

        color: Colors.white
            .withOpacity(0.18),

        borderRadius:
            BorderRadius.circular(
                14),
      ),

      child: Icon(

        icon,

        color: Colors.white,

        size: 22,
      ),
    );
  }

  String _greet() {

    final hour =
        DateTime.now().hour;

    if (hour < 12) {

      return "Good Morning ☀️";
    }

    if (hour < 17) {

      return "Good Afternoon 🌤";
    }

    return "Good Evening 🌙";
  }
}