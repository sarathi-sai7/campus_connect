import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/event_model.dart';

import '../../notifications/services/notification_service.dart';

class EventService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final NotificationService
      notificationService =
      NotificationService();

  // =========================
  // CREATE EVENT
  // =========================

  Future<void> createEvent({

    required String title,

    required String description,

    required String category,

    required String location,

    required DateTime eventDate,

    required bool isOfficial,
  }) async {

    try {

      String eventId =

          _firestore
              .collection("events")
              .doc()
              .id;

      String uid =
          _auth.currentUser!.uid;

      EventModel event = EventModel(

        id: eventId,

        title: title,

        description:
            description,

        category: category,

        location: location,

        image: "",

        createdBy: uid,

        eventDate: eventDate,

        createdAt:
            DateTime.now(),

        registeredStudents: [],

        participantsCount: 0,

        isOfficial:
            isOfficial,
      );

      await _firestore

          .collection("events")

          .doc(eventId)

          .set(event.toMap());

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // REALTIME EVENTS
  // =========================

  Stream<List<EventModel>>
      getEvents() {

    return _firestore

        .collection("events")

        .orderBy(
          "eventDate",
          descending: false,
        )

        .snapshots()

        .map((snapshot) {

      return snapshot.docs.map((doc) {

        return EventModel.fromMap(
          doc.data(),
        );

      }).toList();
    });
  }

  // =========================
  // REGISTER EVENT
  // =========================

  Future<void> registerEvent(

    EventModel event,
  ) async {

    try {

      String uid =
          _auth.currentUser!.uid;

      if (event.registeredStudents
          .contains(uid)) {

        return;
      }

      await _firestore

          .collection("events")

          .doc(event.id)

          .update({

        "registeredStudents":

            FieldValue.arrayUnion(
          [uid],
        ),

        "participantsCount":

            FieldValue.increment(1),
      });

      await _firestore

          .collection("users")

          .doc(uid)

          .update({

        "activities":

            FieldValue.arrayUnion([

          "Registered for ${event.title}"
        ]),
      });

      // NOTIFICATION

      await notificationService
          .createNotification(

        userId: uid,

        title:
            "Event Registration",

        message:
            "Successfully registered for ${event.title}",

        type: "event",

        relatedId: event.id,
      );

    } catch (e) {

      rethrow;
    }
  }

  // =========================
  // LEAVE EVENT
  // =========================

  Future<void> leaveEvent(

    EventModel event,
  ) async {

    try {

      String uid =
          _auth.currentUser!.uid;

      await _firestore

          .collection("events")

          .doc(event.id)

          .update({

        "registeredStudents":

            FieldValue.arrayRemove(
          [uid],
        ),

        "participantsCount":

            FieldValue.increment(-1),
      });

      await notificationService
          .createNotification(

        userId: uid,

        title:
            "Event Cancelled",

        message:
            "You cancelled registration for ${event.title}",

        type: "event",

        relatedId: event.id,
      );

    } catch (e) {

      rethrow;
    }
  }

  bool isRegistered({

    required EventModel event,
  }) {

    String uid =
        _auth.currentUser?.uid ??
            "";

    return event
        .registeredStudents
        .contains(uid);
  }
}