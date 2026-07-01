import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
final userProvider =

    StreamProvider.family<

        UserModel?,

        String>(

  (ref, uid) {

    if (uid.isEmpty) {

      return Stream.value(null);
    }

    return FirebaseFirestore
        .instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((doc) {

      if (!doc.exists) {

        return null;
      }

      return UserModel.fromMap(
        doc.data()!,
      );
    });
  },
);