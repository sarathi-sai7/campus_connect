import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/event_model.dart';
import '../../../models/user_model.dart';

import '../../profile/services/profile_service.dart';

import '../services/event_service.dart';

class EventsScreen
    extends StatefulWidget {

  const EventsScreen({
    super.key,
  });

  @override
  State<EventsScreen>
      createState() =>
          _EventsScreenState();
}

class _EventsScreenState
    extends State<EventsScreen> {

  final EventService
      eventService =
      EventService();

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
      descriptionController =
      TextEditingController();

  final TextEditingController
      locationController =
      TextEditingController();

  UserModel? currentUser;

  bool isLoading = true;

  String selectedCategory =
      "Hackathon";

  DateTime selectedDate =
      DateTime.now();

  final List<String> categories = [

    "Hackathon",

    "Workshop",

    "Seminar",

    "Technical",

    "Sports",

    "Cultural",

    "Placement",
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

                    showCreateEventDialog(
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

                        "Campus Events",

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
                            "Search events...",

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
            // REALTIME EVENTS
            // =========================

            Expanded(

              child:
                  StreamBuilder<
                      List<EventModel>>(

                stream:
                    eventService
                        .getEvents(),

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

                  List<EventModel>
                      events =

                      snapshot.data ??
                          [];

                  // SEARCH

                  if (searchController
                      .text
                      .isNotEmpty) {

                    events =
                        events.where((event) {

                      return event.title
                              .toLowerCase()
                              .contains(

                                searchController
                                    .text
                                    .toLowerCase(),
                              ) ||

                          event.category
                              .toLowerCase()
                              .contains(

                                searchController
                                    .text
                                    .toLowerCase(),
                              );

                    }).toList();
                  }

                  if (events.isEmpty) {

                    return buildEmptyState(
                      isDark,
                    );
                  }

                  return ListView.builder(

                    padding:
                        const EdgeInsets.all(
                            20),

                    itemCount:
                        events.length,

                    itemBuilder:
                        (context,
                            index) {

                      return buildEventCard(

                        event:
                            events[index],

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
  // EVENT CARD
  // =========================

  Widget buildEventCard({

    required EventModel event,

    required bool isDark,
  }) {

    bool registered =
        eventService.isRegistered(

      event: event,
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

              Container(

                padding:
                    const EdgeInsets
                        .all(16),

                decoration:
                    BoxDecoration(

                  gradient:
                      const LinearGradient(

                    colors: [

                      Color(
                          0xFF6C63FF),

                      Color(
                          0xFF9D8FFF),
                    ],
                  ),

                  borderRadius:
                      BorderRadius.circular(
                          18),
                ),

                child: const Icon(

                  Icons
                      .event_rounded,

                  color:
                      Colors.white,
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

                      event.title,

                      style:
                          const TextStyle(

                        fontSize: 18,

                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                        height: 6),

                    Text(

                      event.category,

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

            event.description,

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

          const SizedBox(height: 18),

          Row(

            children: [

              Icon(

                Icons.location_on_rounded,

                size: 18,

                color:
                    Colors.grey
                        .shade500,
              ),

              const SizedBox(
                  width: 6),

              Text(
                event.location,
              ),

              const Spacer(),

              Icon(

                Icons.people_rounded,

                size: 18,

                color:
                    Colors.grey
                        .shade500,
              ),

              const SizedBox(
                  width: 6),

              Text(

                "${event.participantsCount}",
              ),
            ],
          ),

          const SizedBox(height: 22),

          SizedBox(

            width:
                double.infinity,

            height: 52,

            child: ElevatedButton(

              style:
                  ElevatedButton.styleFrom(

                backgroundColor:

                    registered

                        ? Colors.red

                        : const Color(
                            0xFF6C63FF),

                shape:
                    RoundedRectangleBorder(

                  borderRadius:
                      BorderRadius.circular(
                          16),
                ),
              ),

              onPressed: () async {

                if (!(currentUser
                        ?.isOfficialStudent ??
                    false)) {

                  showMessage(

                    "Only official students can register for events",
                  );

                  return;
                }

                if (registered) {

                  await eventService
                      .leaveEvent(
                    event,
                  );

                  showMessage(
                    "Event registration cancelled",
                  );

                } else {

                  await eventService
                      .registerEvent(
                    event,
                  );

                  showMessage(
                    "Successfully registered 🎉",
                  );
                }
              },

              child: Text(

                registered

                    ? "Cancel Registration"

                    : "Register Event",

                style:
                    const TextStyle(

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

            Icons.event_busy_rounded,

            size: 90,

            color:
                Colors.grey
                    .shade500,
          ),

          const SizedBox(height: 20),

          Text(

            "No Events Available",

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

            "Events will appear here in realtime.",

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
  // CREATE EVENT DIALOG
  // =========================

  void showCreateEventDialog(
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

                "Create Event",

                style: TextStyle(

                  fontSize: 24,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              buildField(
                titleController,
                "Event Title",
                isDark,
              ),

              const SizedBox(height: 18),

              buildField(
                descriptionController,
                "Description",
                isDark,
                maxLines: 3,
              ),

              const SizedBox(height: 18),

              buildField(
                locationController,
                "Location",
                isDark,
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

              const SizedBox(height: 18),

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

                    await eventService
                        .createEvent(

                      title:
                          titleController
                              .text
                              .trim(),

                      description:
                          descriptionController
                              .text
                              .trim(),

                      category:
                          selectedCategory,

                      location:
                          locationController
                              .text
                              .trim(),

                      eventDate:
                          selectedDate,

                      isOfficial:
                          true,
                    );

                    if (!mounted) {
                      return;
                    }

                    Navigator.pop(
                        context);

                    titleController
                        .clear();

                    descriptionController
                        .clear();

                    locationController
                        .clear();

                    showMessage(
                      "Event Created 🚀",
                    );
                  },

                  child: const Text(

                    "Create Event",

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