import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/forum_post_model.dart';

import '../../notifications/services/notification_service.dart';

class ForumService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final NotificationService
      notificationService =
      NotificationService();

  // =========================
  // CREATE POST
  // =========================

  Future<void> createPost({

    required String title,

    required String content,

    required String category,

    required String authorName,
  }) async {

    try {

      String postId =

          _firestore

              .collection(
                  "forumPosts")

              .doc()

              .id;

      String uid =
          _auth.currentUser!.uid;

      ForumPostModel post =
          ForumPostModel(

        id: postId,

        title: title,

        content: content,

        createdBy: uid,

        authorName:
            authorName,

        category: category,

        createdAt:
            DateTime.now(),

        likes: [],

        commentsCount: 0,
      );

      await _firestore

          .collection(
              "forumPosts")

          .doc(postId)

          .set(
            post.toMap(),
          );

      // NOTIFICATION

      await notificationService
          .createNotification(

        userId: uid,

        title:
            "Discussion Posted",

        message:
            "Your discussion has been posted successfully",

        type: "forum",

        relatedId: postId,
      );

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // REALTIME POSTS
  // =========================

  Stream<List<ForumPostModel>>
      getPosts() {

    return _firestore

        .collection(
            "forumPosts")

        .orderBy(
          "createdAt",
          descending: true,
        )

        .snapshots()

        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return ForumPostModel
            .fromMap(
          doc.data(),
        );

      }).toList();
    });
  }

  // =========================
  // LIKE POST
  // =========================

  Future<void> likePost(

    ForumPostModel post,
  ) async {

    try {

      String uid =
          _auth.currentUser!.uid;

      if (post.likes
          .contains(uid)) {

        return;
      }

      await _firestore

          .collection(
              "forumPosts")

          .doc(post.id)

          .update({

        "likes":

            FieldValue.arrayUnion(
          [uid],
        ),
      });

      // NOTIFICATION

      await notificationService
          .createNotification(

        userId:
            post.createdBy,

        title: "New Like",

        message:
            "Someone liked your discussion",

        type: "like",

        relatedId: post.id,
      );

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // UNLIKE POST
  // =========================

  Future<void> unlikePost(

    ForumPostModel post,
  ) async {

    try {

      String uid =
          _auth.currentUser!.uid;

      await _firestore

          .collection(
              "forumPosts")

          .doc(post.id)

          .update({

        "likes":

            FieldValue.arrayRemove(
          [uid],
        ),
      });

    } catch (e) {

      rethrow;
    }
  }

  bool isLiked({

    required ForumPostModel
        post,
  }) {

    String uid =
        _auth.currentUser?.uid ??
            "";

    return post.likes
        .contains(uid);
  }
}