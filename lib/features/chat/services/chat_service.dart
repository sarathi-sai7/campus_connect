import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/chat_message_model.dart';

import '../../notifications/services/notification_service.dart';

class ChatService {

  final FirebaseFirestore _firestore =

      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final NotificationService
      notificationService =
      NotificationService();

  // =========================
  // SEND MESSAGE
  // =========================

  Future<void> sendMessage({

    required String communityId,

    required String senderName,

    required String message,
  }) async {

    try {

      String messageId =

          _firestore

              .collection(
                  "communityChats")

              .doc()

              .id;

      String uid =
          _auth.currentUser!.uid;

      ChatMessageModel chatMessage =

          ChatMessageModel(

        id: messageId,

        senderId: uid,

        senderName:
            senderName,

        message: message,

        createdAt:
            DateTime.now(),
      );

      await _firestore

          .collection(
              "communityChats")

          .doc(communityId)

          .collection("messages")

          .doc(messageId)

          .set(
            chatMessage.toMap(),
          );

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // REALTIME MESSAGES
  // =========================

  Stream<List<ChatMessageModel>>
      getMessages(

    String communityId,
  ) {

    return _firestore

        .collection(
            "communityChats")

        .doc(communityId)

        .collection("messages")

        .orderBy(
          "createdAt",
          descending: false,
        )

        .snapshots()

        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return ChatMessageModel
            .fromMap(
          doc.data(),
        );

      }).toList();
    });
  }

  // =========================
  // DELETE MESSAGE
  // =========================

  Future<void> deleteMessage({

    required String communityId,

    required String messageId,
  }) async {

    try {

      await _firestore

          .collection(
              "communityChats")

          .doc(communityId)

          .collection("messages")

          .doc(messageId)

          .delete();

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // SEND COMMUNITY NOTIFICATION
  // =========================

  Future<void>
      sendChatNotification({

    required String userId,

    required String communityName,

    required String senderName,
  }) async {

    try {

      await notificationService
          .createNotification(

        userId: userId,

        title:
            "New Community Message",

        message:
            "$senderName sent a message in $communityName",

        type: "community",

        relatedId:
            communityName,
      );

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // CLEAR CHAT
  // =========================

  Future<void> clearChat(

    String communityId,
  ) async {

    try {

      final snapshot =

          await _firestore

              .collection(
                  "communityChats")

              .doc(communityId)

              .collection(
                  "messages")

              .get();

      for (var doc
          in snapshot.docs) {

        await doc.reference
            .delete();
      }

    } catch (e) {

      rethrow;
    }
  }
}