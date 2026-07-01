import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/user_model.dart';

class ProfileService {

  final FirebaseFirestore _firestore =

      FirebaseFirestore.instance;

  // =========================
  // SAVE PROFILE
  // =========================

  Future<void> saveProfile({

    required UserModel user,
  }) async {

    await _firestore

        .collection("users")

        .doc(user.uid)

        .set(

          user.toMap(),

          SetOptions(
            merge: true,
          ),
        );
  }

  // =========================
  // GET PROFILE
  // =========================

  Future<UserModel?> getProfile(

    String uid,
  ) async {

    try {

      final doc =

          await _firestore

              .collection("users")

              .doc(uid)

              .get();

      if (doc.exists) {

        return UserModel.fromMap(
          doc.data()!,
        );
      }

      return null;

    } catch (e) {

      return null;
    }
  }

  // =========================
  // REALTIME PROFILE STREAM
  // =========================

  Stream<UserModel?> getProfileStream(

    String uid,
  ) {

    return _firestore

        .collection("users")

        .doc(uid)

        .snapshots()

        .map((doc) {

      if (doc.exists) {

        return UserModel.fromMap(
          doc.data()!,
        );
      }

      return null;
    });
  }

  // =========================
  // UPDATE PROFILE
  // =========================

  Future<void> updateProfile({

    required String uid,

    required Map<String, dynamic>
        data,
  }) async {

    await _firestore

        .collection("users")

        .doc(uid)

        .update(data);
  }

  // =========================
  // ONLINE STATUS
  // =========================

  Future<void> updateOnlineStatus({

    required String uid,

    required bool isOnline,
  }) async {

    await _firestore

        .collection("users")

        .doc(uid)

        .update({

      "isOnline": isOnline,

      "lastSeen":
          Timestamp.now(),
    });
  }

  // =========================
  // TYPING STATUS
  // =========================

  Future<void> updateTypingStatus({

    required String uid,

    required bool isTyping,

    required String communityId,
  }) async {

    await _firestore

        .collection("users")

        .doc(uid)

        .update({

      "isTyping": isTyping,

      "currentCommunity":
          communityId,
    });
  }

  // =========================
  // JOIN CLUB
  // =========================

  Future<void> joinClub({

    required String uid,

    required String club,
  }) async {

    await _firestore

        .collection("users")

        .doc(uid)

        .update({

      "joinedClubs":

          FieldValue.arrayUnion(
        [club],
      ),
    });
  }

  // =========================
  // LEAVE CLUB
  // =========================

  Future<void> leaveClub({

    required String uid,

    required String club,
  }) async {

    await _firestore

        .collection("users")

        .doc(uid)

        .update({

      "joinedClubs":

          FieldValue.arrayRemove(
        [club],
      ),
    });
  }

  // =========================
  // JOIN COMMUNITY
  // =========================

  Future<void> joinCommunity({

    required String uid,

    required String community,
  }) async {

    await _firestore

        .collection("users")

        .doc(uid)

        .update({

      "joinedCommunities":

          FieldValue.arrayUnion(
        [community],
      ),
    });
  }

  // =========================
  // LEAVE COMMUNITY
  // =========================

  Future<void> leaveCommunity({

    required String uid,

    required String community,
  }) async {

    await _firestore

        .collection("users")

        .doc(uid)

        .update({

      "joinedCommunities":

          FieldValue.arrayRemove(
        [community],
      ),
    });
  }

  // =========================
  // ADD ACTIVITY
  // =========================

  Future<void> addActivity({

    required String uid,

    required String activity,
  }) async {

    await _firestore

        .collection("users")

        .doc(uid)

        .update({

      "activities":

          FieldValue.arrayUnion(
        [activity],
      ),
    });
  }

  // =========================
  // CLEAR ACTIVITIES
  // =========================

  Future<void> clearActivities(

    String uid,
  ) async {

    await _firestore

        .collection("users")

        .doc(uid)

        .update({

      "activities": [],
    });
  }
}