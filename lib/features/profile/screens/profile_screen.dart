
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/user_model.dart';

import '../../communities/screens/communities_screen.dart';

import '../../home/screens/home_screen.dart';

import '../services/profile_service.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  final TextEditingController
      nameController =
      TextEditingController();

  final ProfileService
      profileService =
      ProfileService();

  UserModel? currentUserData;

  bool isLoading = false;

  bool isEditing = false;

  String selectedDepartment =
      'Computer Science Engineering';

  final List<String> departments = [

    'Computer Science Engineering',

    'Computer & Communication Engineering',

    'Electronics & Communication',

    'Electrical & Electronics',

    'Mechanical Engineering',

    'Civil Engineering',

    'Artificial Intelligence & DS',

    'Information Technology',
  ];

  static const _violet =
      Color(0xFF6C63FF);

  static const _violetLight =
      Color(0xFF9D8FFF);

  static const _green =
      Color(0xFF00C896);

  static const _orange =
      Color(0xFFFF8C42);

  static const _pink =
      Color(0xFFE84393);

  @override
  void initState() {

    super.initState();

    loadProfile();
  }

  Future<void> loadProfile()
  async {

    final firebaseUser =

        FirebaseAuth
            .instance
            .currentUser;

    if (firebaseUser == null) {

      return;
    }

    final userData =

        await profileService
            .getProfile(
      firebaseUser.uid,
    );

    if (userData != null) {

      currentUserData =
          userData;

      nameController.text =
          userData.name;

      if (userData
          .department
          .isNotEmpty) {

        selectedDepartment =
            userData.department;
      }

      if (!mounted) return;

      setState(() {});
    }
  }

  @override
  void dispose() {

    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isDark =

        Theme.of(context)
                .brightness ==

            Brightness.dark;

    final firebaseUser =

        FirebaseAuth
            .instance
            .currentUser;

    final isOfficialStudent =

        currentUserData
                ?.isOfficialStudent ??

            false;

    return Scaffold(

      backgroundColor:

          isDark

              ? const Color(
                  0xFF0F0F1A)

              : const Color(
                  0xFFF0F2FF),

      body: Stack(

        children: [

          // =========================
          // BACKGROUND BLOBS
          // =========================

          Positioned(

            top: -80,

            right: -60,

            child: Container(

              height: 320,

              width: 320,

              decoration:
                  BoxDecoration(

                shape:
                    BoxShape.circle,

                color:
                    _violet.withOpacity(

                  isDark
                      ? 0.15
                      : 0.08,
                ),
              ),
            ),
          ),

          Positioned(

            top: 160,

            left: -80,

            child: Container(

              height: 220,

              width: 220,

              decoration:
                  BoxDecoration(

                shape:
                    BoxShape.circle,

                color:
                    _pink.withOpacity(

                  isDark
                      ? 0.08
                      : 0.05,
                ),
              ),
            ),
          ),

          SafeArea(

            child: SingleChildScrollView(

              physics:
                  const BouncingScrollPhysics(),

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Column(

                children: [

                  const SizedBox(
                      height: 16),

                  // =========================
                  // TOP BAR
                  // =========================

                  Row(

                    children: [

                      Expanded(

                        child: Text(

                          isOfficialStudent

                              ? 'Student Dashboard'

                              : 'Your Profile',

                          textAlign:
                              TextAlign.center,

                          style:
                              TextStyle(

                            fontSize:
                                20,

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
                      ),

                      PopupMenuButton(

                        color:

                            isDark

                                ? const Color(
                                    0xFF1E1E2E)

                                : Colors
                                    .white,

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                                  16),
                        ),

                        icon: Container(

                          padding:
                              const EdgeInsets
                                  .all(10),

                          decoration:
                              BoxDecoration(

                            color:

                                isDark

                                    ? Colors
                                        .white
                                        .withOpacity(
                                            0.07)

                                    : Colors
                                        .white,

                            borderRadius:
                                BorderRadius.circular(
                                    14),

                            border:
                                Border.all(

                              color:

                                  isDark

                                      ? Colors
                                          .white
                                          .withOpacity(
                                              0.1)

                                      : Colors
                                          .grey
                                          .withOpacity(
                                              0.15),
                            ),
                          ),

                          child: Icon(

                            Icons
                                .more_vert_rounded,

                            size: 18,

                            color:

                                isDark

                                    ? Colors
                                        .white

                                    : const Color(
                                        0xFF1A1A2E),
                          ),
                        ),

                        itemBuilder:
                            (context) => [

                          PopupMenuItem(

                            child:
                                const Row(

                              children: [

                                Icon(

                                  Icons
                                      .edit_rounded,

                                  color:
                                      _violet,

                                  size: 18,
                                ),

                                SizedBox(
                                    width:
                                        10),

                                Text(
                                    'Edit Profile'),
                              ],
                            ),

                            onTap: () {

                              Future.delayed(

                                Duration.zero,

                                () {

                                  setState(() {

                                    isEditing =
                                        true;
                                  });
                                },
                              );
                            },
                          ),

                          PopupMenuItem(

                            child:
                                const Row(

                              children: [

                                Icon(

                                  Icons
                                      .home_rounded,

                                  color:
                                      _violet,

                                  size: 18,
                                ),

                                SizedBox(
                                    width:
                                        10),

                                Text(
                                    'Go Home'),
                              ],
                            ),

                            onTap: () {

                              Future.delayed(

                                Duration.zero,

                                () {

                                  Navigator.pushReplacement(

                                    context,

                                    MaterialPageRoute(

                                      builder:
                                          (_) =>

                                              const HomeScreen(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 24),

                  // =========================
                  // PROFILE HERO CARD
                  // =========================

                  Container(

                    decoration:
                        BoxDecoration(

                      gradient:
                          const LinearGradient(

                        colors: [

                          Color(
                              0xFF4C3FD4),

                          _violet,

                          _violetLight,
                        ],

                        begin:
                            Alignment
                                .topLeft,

                        end:
                            Alignment
                                .bottomRight,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                              32),

                      boxShadow: [

                        BoxShadow(

                          color:
                              _violet
                                  .withOpacity(
                                      0.35),

                          blurRadius:
                              28,

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
                          const EdgeInsets
                              .all(24),

                      child: Column(

                        children: [

                          // =========================
                          // PROFILE IMAGE
                          // =========================

                          Stack(

                            children: [

                              Container(

                                height: 96,

                                width: 96,

                                decoration:
                                    BoxDecoration(

                                  shape:
                                      BoxShape.circle,

                                  color: Colors
                                      .white
                                      .withOpacity(
                                          0.2),

                                  border:
                                      Border.all(

                                    color: Colors
                                        .white
                                        .withOpacity(
                                            0.4),

                                    width: 3,
                                  ),
                                ),

                                child:
                                    currentUserData
                                                ?.profileImage
                                                .isNotEmpty ??

                                            false

                                        ? ClipOval(

                                            child: Image
                                                .network(

                                              currentUserData!
                                                  .profileImage,

                                              fit: BoxFit
                                                  .cover,
                                            ),
                                          )

                                        : const Icon(

                                            Icons
                                                .person_rounded,

                                            size:
                                                52,

                                            color:
                                                Colors.white,
                                          ),
                              ),

                              Positioned(

                                bottom: 2,

                                right: 2,

                                child: Container(

                                  padding:
                                      const EdgeInsets
                                          .all(7),

                                  decoration:
                                      const BoxDecoration(

                                    shape:
                                        BoxShape.circle,

                                    color:
                                        Colors.white,
                                  ),

                                  child:
                                      const Icon(

                                    Icons
                                        .edit_rounded,

                                    size: 14,

                                    color:
                                        _violet,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                              height: 14),

                          Text(

                            nameController
                                    .text
                                    .isEmpty

                                ? isOfficialStudent

                                    ? 'Campus Student'

                                    : 'Campus Visitor'

                                : nameController
                                    .text,

                            style:
                                const TextStyle(

                              fontSize:
                                  24,

                              fontWeight:
                                  FontWeight.w800,

                              color:
                                  Colors.white,
                            ),
                          ),

                          const SizedBox(
                              height: 4),

                          Text(

                            firebaseUser
                                    ?.email ??

                                '',

                            style:
                                TextStyle(

                              color: Colors
                                  .white
                                  .withOpacity(
                                      0.75),

                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(
                              height: 14),

                          // =========================
                          // ROLE BADGE
                          // =========================

                          Container(

                            padding:
                                const EdgeInsets.symmetric(

                              horizontal:
                                  16,

                              vertical:
                                  8,
                            ),

                            decoration:
                                BoxDecoration(

                              color: Colors
                                  .white
                                  .withOpacity(
                                      0.18),

                              borderRadius:
                                  BorderRadius.circular(
                                      20),
                            ),

                            child: Row(

                              mainAxisSize:
                                  MainAxisSize.min,

                              children: [

                                Icon(

                                  isOfficialStudent

                                      ? Icons
                                          .verified_rounded

                                      : Icons
                                          .person_outline_rounded,

                                  color:
                                      Colors.white,

                                  size: 16,
                                ),

                                const SizedBox(
                                    width:
                                        6),

                                Text(

                                  currentUserData
                                              ?.role ==

                                          'guest'

                                      ? 'Guest Access'

                                      : currentUserData
                                              ?.role ??

                                          'User',

                                  style:
                                      const TextStyle(

                                    color:
                                        Colors.white,

                                    fontWeight:
                                        FontWeight.w700,

                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                              height: 16),

                          Wrap(

                            spacing: 10,

                            runSpacing: 8,

                            alignment:
                                WrapAlignment
                                    .center,

                            children: [

                              _infoPill(

                                Icons
                                    .school_rounded,

                                selectedDepartment
                                    .split(
                                        ' ')
                                    .first,
                              ),

                              if (isOfficialStudent)

                                _infoPill(

                                  Icons
                                      .badge_rounded,

                                  currentUserData
                                                  ?.registerNo
                                                  .isEmpty ??

                                              true

                                      ? 'ERP Enabled'

                                      : currentUserData!
                                          .registerNo,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 24),

                  // =========================
                  // EDIT PROFILE
                  // =========================

                  if (isEditing) ...[

                    _buildCard(

                      isDark: isDark,

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(

                            'Edit Profile',

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
                              height: 20),

                          buildTextField(

                            controller:
                                nameController,

                            hint:
                                'Your Name',

                            icon: Icons
                                .person_rounded,

                            isDark:
                                isDark,
                          ),

                          const SizedBox(
                              height: 16),

                          buildDropdown(

                            value:
                                selectedDepartment,

                            items:
                                departments,

                            icon: Icons
                                .school_rounded,

                            isDark:
                                isDark,

                            onChanged:
                                (v) {

                              setState(() {

                                selectedDepartment =
                                    v!;
                              });
                            },
                          ),

                          const SizedBox(
                              height: 20),

                          SizedBox(

                            width:
                                double.infinity,

                            height: 54,

                            child:
                                ElevatedButton(

                              style:
                                  ElevatedButton.styleFrom(

                                backgroundColor:
                                    _violet,

                                elevation:
                                    0,

                                shape:
                                    RoundedRectangleBorder(

                                  borderRadius:
                                      BorderRadius.circular(
                                          18),
                                ),
                              ),

                              onPressed:
                                  () async {

                                setState(() {

                                  isLoading =
                                      true;
                                });

                                await profileService
                                    .saveProfile(

                                  user:
                                      UserModel(

                                    uid:
                                        firebaseUser!.uid,

                                    name:
                                        nameController
                                            .text
                                            .trim(),

                                    email:
                                        firebaseUser
                                            .email!,

                                    department:
                                        selectedDepartment,

                                    semester:
                                        currentUserData
                                                ?.semester ??

                                            '',

                                    role:
                                        currentUserData
                                                ?.role ??

                                            'guest',

                                    registerNo:
                                        currentUserData
                                                ?.registerNo ??

                                            '',

                                    isOfficialStudent:
                                        currentUserData
                                                ?.isOfficialStudent ??

                                            false,

                                    profileImage:
                                        currentUserData
                                                ?.profileImage ??

                                            '',

                                    joinedClubs:
                                        currentUserData
                                                ?.joinedClubs ??

                                            [],

                                    joinedCommunities:
                                        currentUserData
                                                ?.joinedCommunities ??

                                            [],

                                    activities:
                                        currentUserData
                                                ?.activities ??

                                            [],

                                    // =========================
                                    // NEW REALTIME FIELDS
                                    // =========================

                                    isOnline:
                                        currentUserData
                                                ?.isOnline ??

                                            false,

                                    isTyping:
                                        currentUserData
                                                ?.isTyping ??

                                            false,

                                    currentCommunity:
                                        currentUserData
                                                ?.currentCommunity ??

                                            "",

                                    lastSeen:
                                        currentUserData
                                            ?.lastSeen,
                                  ),
                                );

                                setState(() {

                                  isLoading =
                                      false;

                                  isEditing =
                                      false;
                                });

                                showMessage(

                                  'Profile Updated Successfully',

                                  _green,
                                );

                                await loadProfile();
                              },

                              child:
                                  isLoading

                                      ? const SizedBox(

                                          height:
                                              22,

                                          width:
                                              22,

                                          child:
                                              CircularProgressIndicator(

                                            color:
                                                Colors.white,

                                            strokeWidth:
                                                2.5,
                                          ),
                                        )

                                      : const Text(

                                          'Save Changes',

                                          style:
                                              TextStyle(

                                            color:
                                                Colors.white,

                                            fontSize:
                                                16,

                                            fontWeight:
                                                FontWeight.w700,
                                          ),
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                        height: 20),
                  ],

                  // =========================
                  // ROLE BASED ERP
                  // =========================

                  if (isOfficialStudent) ...[

                    _sectionLabel(
                      'Academic ERP',
                      isDark,
                    ),

                    const SizedBox(
                        height: 14),

                    _buildFeatureTile(

                      title:
                          'Attendance',

                      subtitle:
                          'Track attendance analytics',

                      icon: Icons
                          .fact_check_rounded,

                      color:
                          _green,

                      isDark:
                          isDark,

                      onTap:
                          () {},
                    ),

                    _buildFeatureTile(

                      title:
                          'Internal Marks',

                      subtitle:
                          'Track semester performance',

                      icon: Icons
                          .bar_chart_rounded,

                      color:
                          _orange,

                      isDark:
                          isDark,

                      onTap:
                          () {},
                    ),

                    _buildFeatureTile(

                      title:
                          'Communities',

                      subtitle:
                          'Explore clubs & communities',

                      icon: Icons
                          .groups_rounded,

                      color:
                          _pink,

                      isDark:
                          isDark,

                      onTap:
                          () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder:
                                (_) =>

                                    const CommunitiesScreen(),
                          ),
                        );
                      },
                    ),
                  ]

                  else ...[

                    _sectionLabel(
                      'Campus Access',
                      isDark,
                    ),

                    const SizedBox(
                        height: 14),

                    _buildFeatureTile(

                      title:
                          'Events',

                      subtitle:
                          'Explore public campus events',

                      icon: Icons
                          .event_rounded,

                      color:
                          _violet,

                      isDark:
                          isDark,

                      onTap:
                          () {},
                    ),

                    _buildFeatureTile(

                      title:
                          'Announcements',

                      subtitle:
                          'View public campus updates',

                      icon: Icons
                          .campaign_rounded,

                      color:
                          _green,

                      isDark:
                          isDark,

                      onTap:
                          () {},
                    ),
                  ],

                  const SizedBox(
                      height: 28),

                  // =========================
                  // COMMUNITIES
                  // =========================

                  if (isOfficialStudent) ...[

                    _sectionLabel(
                      'My Communities',
                      isDark,
                    ),

                    const SizedBox(
                        height: 14),

                    currentUserData ==
                                null ||

                            currentUserData!
                                .joinedCommunities
                                .isEmpty

                        ? buildEmptyState(

                            title:
                                "You're not in any communities",

                            subtitle:
                                'Join communities and build your campus network',

                            icon: Icons
                                .groups_rounded,

                            isDark:
                                isDark,
                          )

                        : Column(

                            children:

                                currentUserData!
                                    .joinedCommunities
                                    .map(

                              (community) {

                                return buildCard(

                                  title:
                                      community,

                                  icon: Icons
                                      .groups_rounded,

                                  color:
                                      _pink,

                                  isDark:
                                      isDark,
                                );
                              },
                            ).toList(),
                          ),

                    const SizedBox(
                        height: 28),
                  ],

                  // =========================
                  // ACTIVITIES
                  // =========================

                  _sectionLabel(

                    isOfficialStudent

                        ? 'Student Activities'

                        : 'Recent Activity',

                    isDark,
                  ),

                  const SizedBox(
                      height: 14),

                  currentUserData ==
                              null ||

                          currentUserData!
                              .activities
                              .isEmpty

                      ? buildEmptyState(

                          title:
                              isOfficialStudent

                                  ? 'No activities yet'

                                  : 'No recent activity',

                          subtitle:
                              'Your activities will appear here',

                          icon: Icons
                              .local_activity_rounded,

                          isDark:
                              isDark,
                        )

                      : Column(

                          children:

                              currentUserData!
                                  .activities
                                  .map(

                            (activity) {

                              return buildCard(

                                title:
                                    activity,

                                icon: Icons
                                    .emoji_events_rounded,

                                color:
                                    _violet,

                                isDark:
                                    isDark,
                              );
                            },
                          ).toList(),
                        ),

                  const SizedBox(
                      height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // INFO PILL
  // =========================

  Widget _infoPill(
    IconData icon,
    String label,
  ) {

    return Container(

      padding:
          const EdgeInsets.symmetric(

        horizontal: 12,

        vertical: 6,
      ),

      decoration:
          BoxDecoration(

        color: Colors.white
            .withOpacity(0.18),

        borderRadius:
            BorderRadius.circular(
                12),
      ),

      child: Row(

        mainAxisSize:
            MainAxisSize.min,

        children: [

          Icon(

            icon,

            color:
                Colors.white,

            size: 14,
          ),

          const SizedBox(
              width: 6),

          Text(

            label,

            style:
                const TextStyle(

              color:
                  Colors.white,

              fontSize: 12,

              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({

    required bool isDark,

    required Widget child,
  }) {

    return Container(

      width: double.infinity,

      padding:
          const EdgeInsets.all(
              22),

      decoration:
          BoxDecoration(

        color:

            isDark

                ? const Color(
                    0xFF1C1C2E)

                : Colors.white,

        borderRadius:
            BorderRadius.circular(
                24),
      ),

      child: child,
    );
  }

  Widget _sectionLabel(

    String label,

    bool isDark,
  ) {

    return Align(

      alignment:
          Alignment.centerLeft,

      child: Text(

        label,

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
      ),
    );
  }

  Widget _buildFeatureTile({

    required String title,

    required String subtitle,

    required IconData icon,

    required Color color,

    required bool isDark,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        margin:
            const EdgeInsets.only(
          bottom: 12,
        ),

        padding:
            const EdgeInsets.all(
                16),

        decoration:
            BoxDecoration(

          color:

              isDark

                  ? const Color(
                      0xFF1C1C2E)

                  : Colors.white,

          borderRadius:
              BorderRadius.circular(
                  22),
        ),

        child: Row(

          children: [

            Container(

              padding:
                  const EdgeInsets
                      .all(12),

              decoration:
                  BoxDecoration(

                color:
                    color.withOpacity(
                        0.12),

                borderRadius:
                    BorderRadius.circular(
                        14),
              ),

              child: Icon(

                icon,

                color: color,

                size: 22,
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

                      fontSize: 15,

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

                  const SizedBox(
                      height: 4),

                  Text(

                    subtitle,

                    style:
                        TextStyle(

                      fontSize: 13,

                      color:

                          isDark

                              ? Colors
                                  .grey
                                  .shade500

                              : Colors
                                  .grey
                                  .shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard({

    required String title,

    required IconData icon,

    required Color color,

    required bool isDark,
  }) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      padding:
          const EdgeInsets.all(
              16),

      decoration:
          BoxDecoration(

        color:

            isDark

                ? const Color(
                    0xFF1C1C2E)

                : Colors.white,

        borderRadius:
            BorderRadius.circular(
                20),
      ),

      child: Row(

        children: [

          Container(

            padding:
                const EdgeInsets
                    .all(12),

            decoration:
                BoxDecoration(

              color:
                  color.withOpacity(
                      0.12),

              borderRadius:
                  BorderRadius.circular(
                      14),
            ),

            child: Icon(

              icon,

              color: color,

              size: 22,
            ),
          ),

          const SizedBox(
              width: 16),

          Expanded(

            child: Text(

              title,

              style:
                  TextStyle(

                fontSize: 15,

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
          ),
        ],
      ),
    );
  }

  Widget buildEmptyState({

    required String title,

    required String subtitle,

    required IconData icon,

    required bool isDark,
  }) {

    return Container(

      width:
          double.infinity,

      padding:
          const EdgeInsets.all(
              28),

      decoration:
          BoxDecoration(

        color:

            isDark

                ? const Color(
                    0xFF1C1C2E)

                : Colors.white,

        borderRadius:
            BorderRadius.circular(
                24),
      ),

      child: Column(

        children: [

          Container(

            padding:
                const EdgeInsets
                    .all(18),

            decoration:
                BoxDecoration(

              color:
                  Colors.grey
                      .withOpacity(
                          0.08),

              shape:
                  BoxShape.circle,
            ),

            child: Icon(

              icon,

              size: 42,

              color: Colors
                  .grey
                  .shade400,
            ),
          ),

          const SizedBox(
              height: 16),

          Text(

            title,

            style:
                TextStyle(

              fontSize: 16,

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
              height: 8),

          Text(

            subtitle,

            textAlign:
                TextAlign.center,

            style:
                TextStyle(

              fontSize: 13,

              height: 1.5,

              color:

                  isDark

                      ? Colors
                          .grey
                          .shade500

                      : Colors
                          .grey
                          .shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({

    required TextEditingController
        controller,

    required String hint,

    required IconData icon,

    required bool isDark,
  }) {

    return TextField(

      controller: controller,

      style: TextStyle(

        color:

            isDark

                ? Colors.white

                : Colors.black,
      ),

      decoration:
          InputDecoration(

        hintText: hint,

        prefixIcon: Icon(

          icon,

          color: _violet,
        ),

        filled: true,

        fillColor:

            isDark

                ? const Color(
                    0xFF2A2A3E)

                : const Color(
                    0xFFF3F4FF),

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

  Widget buildDropdown({

    required String value,

    required List<String>
        items,

    required IconData icon,

    required bool isDark,

    required Function(String?)
        onChanged,
  }) {

    return DropdownButtonFormField(

      initialValue: value,

      dropdownColor:

          isDark

              ? const Color(
                  0xFF2A2A3E)

              : Colors.white,

      style: TextStyle(

        color:

            isDark

                ? Colors.white

                : Colors.black,
      ),

      decoration:
          InputDecoration(

        prefixIcon: Icon(

          icon,

          color: _violet,
        ),

        filled: true,

        fillColor:

            isDark

                ? const Color(
                    0xFF2A2A3E)

                : const Color(
                    0xFFF3F4FF),

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
                  18),

          borderSide:
              BorderSide.none,
        ),
      ),

      items: items.map(

        (item) {

          return DropdownMenuItem(

            value: item,

            child: Text(item),
          );
        },
      ).toList(),

      onChanged: onChanged,
    );
  }

  void showMessage(

    String message,

    Color color,
  ) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        behavior:
            SnackBarBehavior
                .floating,

        backgroundColor:
            color,

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