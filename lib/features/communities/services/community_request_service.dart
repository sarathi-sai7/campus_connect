import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/community_join_request_model.dart';

import '../../../models/community_model.dart';

class CommunityRequestService {

  final FirebaseFirestore
      _firestore =
      FirebaseFirestore.instance;

  // =========================
  // APPLY TO JOIN COMMUNITY
  // =========================

  Future<void> applyToJoin({

    required CommunityModel
        community,

    required String userName,

    required String userEmail,

    required String reason,
  }) async {

    final uid =
        FirebaseAuth
            .instance
            .currentUser
            ?.uid;

    if (uid == null) return;

    // CHECK EXISTING REQUEST

    final existing =

        await _firestore
            .collection(
                "communityJoinRequests")
            .where(
              "communityId",
              isEqualTo:
                  community.id,
            )
            .where(
              "userId",
              isEqualTo: uid,
            )
            .get();

    if (existing.docs.isNotEmpty) {

      throw Exception(
        "Already Applied",
      );
    }

    final doc =

        _firestore
            .collection(
                "communityJoinRequests")
            .doc();

    final request =
        CommunityJoinRequestModel(

      id: doc.id,

      communityId:
          community.id,

      communityName:
          community.name,

      userId: uid,

      userName: userName,

      userEmail:
          userEmail,

      reason: reason,

      status: "pending",

      createdAt:
          DateTime.now(),
    );

    await doc.set(
      request.toMap(),
    );
  }

  // =========================
  // GET PENDING REQUESTS
  // =========================

  Stream<
      List<
          CommunityJoinRequestModel>>
      getPendingRequests(

    String communityId,
  ) {

    return _firestore
        .collection(
            "communityJoinRequests")
        .where(
          "communityId",
          isEqualTo:
              communityId,
        )
        .where(
          "status",
          isEqualTo:
              "pending",
        )
        .snapshots()
        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return CommunityJoinRequestModel
            .fromMap(
          doc.data(),
        );

      }).toList();
    });
  }

  // =========================
  // APPROVE REQUEST
  // =========================

  Future<void> approveRequest({

    required String requestId,

    required String communityId,

    required String userId,
  }) async {

    try {

      // UPDATE REQUEST STATUS

      await _firestore
          .collection(
              "communityJoinRequests")
          .doc(requestId)
          .update({

        "status":
            "approved",
      });

      // ADD USER TO COMMUNITY

      await _firestore
          .collection(
              "communities")
          .doc(communityId)
          .update({

        "members":
            FieldValue.arrayUnion(
          [userId],
        ),

        "membersCount":
            FieldValue.increment(
          1,
        ),
      });

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // REJECT REQUEST
  // =========================

  Future<void> rejectRequest({

    required String requestId,
  }) async {

    try {

      await _firestore
          .collection(
              "communityJoinRequests")
          .doc(requestId)
          .update({

        "status":
            "rejected",
      });

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // CHECK REQUEST STATUS
  // =========================

  Future<String?> getRequestStatus({

    required String communityId,
  }) async {

    final uid =
        FirebaseAuth
            .instance
            .currentUser
            ?.uid;

    if (uid == null) {

      return null;
    }

    final snapshot =

        await _firestore
            .collection(
                "communityJoinRequests")
            .where(
              "communityId",
              isEqualTo:
                  communityId,
            )
            .where(
              "userId",
              isEqualTo: uid,
            )
            .limit(1)
            .get();

    if (snapshot.docs.isEmpty) {

      return null;
    }

    return snapshot
        .docs
        .first["status"];
  }
}