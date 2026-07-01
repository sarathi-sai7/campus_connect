import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/notification_model.dart';

class NotificationService {

  final FirebaseFirestore _firestore =

      FirebaseFirestore.instance;

  // =========================
  // CREATE NOTIFICATION
  // =========================

  Future<void> createNotification({

    required String userId,

    required String title,

    required String message,

    required String type,

    required String relatedId,
  }) async {

    try {

      String notificationId =

          _firestore

              .collection(
                  "notifications")

              .doc()

              .id;

      NotificationModel notification =

          NotificationModel(

        id: notificationId,

        userId: userId,

        title: title,

        message: message,

        type: type,

        isRead: false,

        relatedId: relatedId,

        createdAt:
            DateTime.now(),
      );

      await _firestore

          .collection(
              "notifications")

          .doc(notificationId)

          .set(
            notification.toMap(),
          );

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // REALTIME NOTIFICATIONS
  // =========================

  Stream<List<NotificationModel>>
      getNotifications(

    String userId,
  ) {

    return _firestore

        .collection(
            "notifications")

        .where(
          "userId",
          isEqualTo: userId,
        )

        .orderBy(
          "createdAt",
          descending: true,
        )

        .snapshots()

        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return NotificationModel
            .fromMap(
          doc.data(),
        );

      }).toList();
    });
  }

  // =========================
  // MARK AS READ
  // =========================

  Future<void> markAsRead(

    String notificationId,
  ) async {

    try {

      await _firestore

          .collection(
              "notifications")

          .doc(notificationId)

          .update({

        "isRead": true,
      });

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // MARK ALL AS READ
  // =========================

  Future<void> markAllAsRead(

    String userId,
  ) async {

    try {

      final snapshot =

          await _firestore

              .collection(
                  "notifications")

              .where(
                "userId",
                isEqualTo: userId,
              )

              .where(
                "isRead",
                isEqualTo: false,
              )

              .get();

      for (var doc in snapshot.docs) {

        await doc.reference.update({

          "isRead": true,
        });
      }

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // DELETE NOTIFICATION
  // =========================

  Future<void> deleteNotification(

    String notificationId,
  ) async {

    try {

      await _firestore

          .collection(
              "notifications")

          .doc(notificationId)

          .delete();

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // DELETE ALL
  // =========================

  Future<void> deleteAllNotifications(

    String userId,
  ) async {

    try {

      final snapshot =

          await _firestore

              .collection(
                  "notifications")

              .where(
                "userId",
                isEqualTo: userId,
              )

              .get();

      for (var doc in snapshot.docs) {

        await doc.reference.delete();
      }

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // UNREAD COUNT STREAM
  // =========================

  Stream<int> getUnreadCount(

    String userId,
  ) {

    return _firestore

        .collection(
            "notifications")

        .where(
          "userId",
          isEqualTo: userId,
        )

        .where(
          "isRead",
          isEqualTo: false,
        )

        .snapshots()

        .map((snapshot) {

      return snapshot.docs.length;
    });
  }
}