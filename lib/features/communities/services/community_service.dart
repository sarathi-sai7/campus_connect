import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/community_model.dart';

import '../../notifications/services/notification_service.dart';

class CommunityService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final NotificationService
      notificationService =
      NotificationService();

  // =========================
  // CREATE COMMUNITY
  // =========================

  Future<void> createCommunity({

    required String name,

    required String description,

    required String category,

    required bool isOfficial,
  }) async {

    try {

      String communityId =

          _firestore
              .collection(
                  "communities")
              .doc()
              .id;

      String uid =
          _auth.currentUser!.uid;

      CommunityModel community =
          CommunityModel(

        id: communityId,

        name: name,

        description:
            description,

        category: category,

        image: "",

        createdBy: uid,

        createdAt:
            DateTime.now(),

        isOfficial:
            isOfficial,

        members: [uid],

        membersCount: 1,

        // =========================
        // GOVERNANCE SYSTEM
        // =========================

        head: uid,

        coHeads: [],

        admins: [uid],

        moderators: [],

        approvalRequired: true,
      );

      await _firestore

          .collection(
              "communities")

          .doc(communityId)

          .set(
            community.toMap(),
          );

      // =========================
      // ACTIVITY FEED
      // =========================

      await _firestore

          .collection(
              "communityActivities")

          .add({

        "communityId":
            communityId,

        "userId": uid,

        "type":
            "community_created",

        "message":
            "Created $name community",

        "createdAt":
            Timestamp.now(),
      });

      // =========================
      // NOTIFICATION
      // =========================

      await notificationService
          .createNotification(

        userId: uid,

        title:
            "Community Created 🚀",

        message:
            "You created $name community",

        type: "community",

        relatedId:
            communityId,
      );

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // REALTIME COMMUNITIES
  // =========================

  Stream<List<CommunityModel>>
      getCommunities() {

    return _firestore

        .collection(
            "communities")

        .orderBy(
          "createdAt",
          descending: true,
        )

        .snapshots()

        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return CommunityModel
            .fromMap(
          doc.data(),
        );

      }).toList();
    });
  }

  // =========================
  // JOIN COMMUNITY
  // =========================

  Future<void> joinCommunity(

    CommunityModel community,
  ) async {

    try {

      String uid =
          _auth.currentUser!.uid;

      // PREVENT DUPLICATE

      if (community.members
          .contains(uid)) {

        return;
      }

      // UPDATE COMMUNITY

      await _firestore

          .collection(
              "communities")

          .doc(community.id)

          .update({

        "members":

            FieldValue.arrayUnion(
          [uid],
        ),

        "membersCount":

            FieldValue.increment(1),
      });

      // UPDATE USER

      await _firestore

          .collection("users")

          .doc(uid)

          .update({

        "joinedCommunities":

            FieldValue.arrayUnion(
          [community.name],
        ),

        "activities":

            FieldValue.arrayUnion([

          "Joined ${community.name}"
        ]),
      });

      // ACTIVITY FEED

      await _firestore

          .collection(
              "communityActivities")

          .add({

        "communityId":
            community.id,

        "userId": uid,

        "type": "join",

        "message":
            "Joined ${community.name}",

        "createdAt":
            Timestamp.now(),
      });

      // NOTIFICATION

      await notificationService
          .createNotification(

        userId: uid,

        title:
            "Community Joined",

        message:
            "You joined ${community.name}",

        type: "community",

        relatedId:
            community.id,
      );

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // LEAVE COMMUNITY
  // =========================

  Future<void> leaveCommunity(

    CommunityModel community,
  ) async {

    try {

      String uid =
          _auth.currentUser!.uid;

      // PREVENT HEAD LEAVING

      if (community.head == uid) {

        throw Exception(
          "Head cannot leave community",
        );
      }

      await _firestore

          .collection(
              "communities")

          .doc(community.id)

          .update({

        "members":

            FieldValue.arrayRemove(
          [uid],
        ),

        "membersCount":

            FieldValue.increment(-1),

        "admins":

            FieldValue.arrayRemove(
          [uid],
        ),

        "coHeads":

            FieldValue.arrayRemove(
          [uid],
        ),

        "moderators":

            FieldValue.arrayRemove(
          [uid],
        ),
      });

      await _firestore

          .collection("users")

          .doc(uid)

          .update({

        "joinedCommunities":

            FieldValue.arrayRemove(
          [community.name],
        ),
      });

      // NOTIFICATION

      await notificationService
          .createNotification(

        userId: uid,

        title:
            "Community Left",

        message:
            "You left ${community.name}",

        type: "community",

        relatedId:
            community.id,
      );

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // CHECK ROLE HELPERS
  // =========================

  bool isHead({

    required CommunityModel
        community,

    required String uid,
  }) {

    return community.head ==
        uid;
  }

  bool isAdmin({

    required CommunityModel
        community,

    required String uid,
  }) {

    return community.admins
        .contains(uid);
  }

  bool isCoHead({

    required CommunityModel
        community,

    required String uid,
  }) {

    return community.coHeads
        .contains(uid);
  }

  bool isModerator({

    required CommunityModel
        community,

    required String uid,
  }) {

    return community.moderators
        .contains(uid);
  }

  bool canApproveRequests({

    required CommunityModel
        community,

    required String uid,
  }) {

    return community.head ==
            uid ||

        community.admins
            .contains(uid) ||

        community.coHeads
            .contains(uid);
  }
  // =========================
// ADD CO HEAD
// =========================

Future<void> addCoHead({

  required String communityId,

  required String uid,
}) async {

  await _firestore

      .collection("communities")

      .doc(communityId)

      .update({

    "coHeads":

        FieldValue.arrayUnion(
      [uid],
    ),

    "admins":

        FieldValue.arrayUnion(
      [uid],
    ),
  });
}

// =========================
// REMOVE CO HEAD
// =========================

Future<void> removeCoHead({

  required String communityId,

  required String uid,
}) async {

  await _firestore

      .collection("communities")

      .doc(communityId)

      .update({

    "coHeads":

        FieldValue.arrayRemove(
      [uid],
    ),
  });
}

// =========================
// ADD MODERATOR
// =========================

Future<void> addModerator({

  required String communityId,

  required String uid,
}) async {

  await _firestore

      .collection("communities")

      .doc(communityId)

      .update({

    "moderators":

        FieldValue.arrayUnion(
      [uid],
    ),
  });
}

// =========================
// REMOVE MODERATOR
// =========================

Future<void> removeModerator({

  required String communityId,

  required String uid,
}) async {

  await _firestore

      .collection("communities")

      .doc(communityId)

      .update({

    "moderators":

        FieldValue.arrayRemove(
      [uid],
    ),
  });
}
}