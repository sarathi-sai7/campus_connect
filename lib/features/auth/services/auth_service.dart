import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';

import '../../../services/user_service.dart';

final authServiceProvider =

    Provider<AuthService>((ref) {

  return AuthService();
});
class AuthService {

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final UserService _userService =
      UserService();

  // =========================
  // SUPER ADMIN EMAILS
  // =========================

  static const List<String>
      adminEmails = [

    "principal@college.edu",

    "admin@college.edu",

    "dean@college.edu",

    // =========================
    // ADD YOUR REAL EMAIL HERE
    // =========================

    "sarathisai301@gmail.com",
  ];

  // =========================
  // REGISTER USER
  // =========================

  Future<String> registerUser({

    required String name,

    required String email,

    required String password,

  }) async {

    try {

      UserCredential userCredential =

          await _auth
              .createUserWithEmailAndPassword(

        email: email.trim(),

        password: password,
      );

      User? user =
          userCredential.user;

      if (user == null) {

        return "Registration failed";
      }

      // =========================
      // SEND EMAIL VERIFICATION
      // =========================

      await user.sendEmailVerification();

      // =========================
      // EMAIL NORMALIZATION
      // =========================

      final normalizedEmail =

          email
              .toLowerCase()
              .trim();

      // =========================
      // OFFICIAL STUDENT CHECK
      // =========================

      bool isOfficialStudent =

          normalizedEmail
              .endsWith(
            "@sece.ac.in",
          );

      // =========================
      // ROLE SYSTEM
      // =========================

      String role = "guest";

      // SUPER ADMIN
      // Highest Priority

      if (adminEmails.contains(
        normalizedEmail,
      )) {

        role = "super_admin";
      }

      // OFFICIAL STUDENT

      else if (isOfficialStudent) {

        role = "student";
      }

      // =========================
      // CREATE USER MODEL
      // =========================

      UserModel newUser = UserModel(

        uid: user.uid,

        name: name.trim(),

        email: normalizedEmail,

        department: "",

        semester: "",

        role: role,

        registerNo: "",

        isOfficialStudent:
            isOfficialStudent,

        profileImage: "",

        joinedClubs: [],

        joinedCommunities: [],

        activities: [],

        // =========================
        // REALTIME FIELDS
        // =========================

        isOnline: false,

        isTyping: false,

        currentCommunity: "",

        lastSeen:
            DateTime.now(),
      );

      // =========================
      // SAVE USER
      // =========================

      await _userService
          .saveUser(newUser);

      // =========================
      // SIGN OUT AFTER REGISTER
      // =========================

      await _auth.signOut();

      return "success";

    } on FirebaseAuthException catch (e) {

      if (e.code ==
          "email-already-in-use") {

        return
            "Email already exists";
      }

      if (e.code ==
          "invalid-email") {

        return
            "Invalid email";
      }

      if (e.code ==
          "weak-password") {

        return
            "Weak password";
      }

      if (e.code ==
          "network-request-failed") {

        return
            "Check internet connection";
      }

      return e.message.toString();

    } catch (e) {

      return
          "Something went wrong";
    }
  }

  // =========================
  // LOGIN USER
  // =========================

  Future<String> loginUser({

    required String email,

    required String password,

  }) async {

    try {

      UserCredential userCredential =

          await _auth
              .signInWithEmailAndPassword(

        email: email.trim(),

        password: password,
      );

      User? user =
          userCredential.user;

      if (user == null) {

        return "Login failed";
      }

      // =========================
      // REFRESH USER
      // =========================

      await user.reload();

      user = _auth.currentUser;

      // =========================
      // VERIFY EMAIL
      // =========================

      if (!user!.emailVerified) {

        await _auth.signOut();

        return
            "Please verify your email first";
      }

      // =========================
      // EMAIL NORMALIZATION
      // =========================

      final normalizedEmail =

          email
              .toLowerCase()
              .trim();

      // =========================
      // OFFICIAL STUDENT CHECK
      // =========================

      bool isOfficialStudent =

          normalizedEmail
              .endsWith(
            "@sece.ac.in",
          );

      // =========================
      // ROLE SYSTEM
      // =========================

      String role = "guest";

      // SUPER ADMIN
      // Highest Priority

      if (adminEmails.contains(
        normalizedEmail,
      )) {

        role = "super_admin";
      }

      // OFFICIAL STUDENT

      else if (isOfficialStudent) {

        role = "student";
      }

      // =========================
      // UPDATE FIRESTORE USER
      // =========================

      await _userService
          .updateUser(

        uid: user.uid,

        data: {

          "isOfficialStudent":
              isOfficialStudent,

          "role": role,

          "isOnline": true,

          "lastSeen":
              DateTime.now(),
        },
      );

      return "Login Success";

    } on FirebaseAuthException catch (e) {

      if (e.code ==
              "user-not-found" ||
          e.code ==
              "invalid-credential") {

        return
            "No account found";
      }

      if (e.code ==
          "wrong-password") {

        return
            "Incorrect password";
      }

      if (e.code ==
          "invalid-email") {

        return
            "Invalid email";
      }

      if (e.code ==
          "network-request-failed") {

        return
            "Check internet connection";
      }

      return e.message.toString();

    } catch (e) {

      return
          "Something went wrong";
    }
  }

  // =========================
  // FORGOT PASSWORD
  // =========================

  Future<String> forgotPassword(
      String email) async {

    try {

      await _auth
          .sendPasswordResetEmail(

        email: email.trim(),
      );

      return
          "Reset Email Sent";

    } on FirebaseAuthException catch (e) {

      return e.message.toString();

    } catch (e) {

      return
          "Something went wrong";
    }
  }

  // =========================
  // RESEND EMAIL
  // =========================

  Future<String>
      resendVerificationEmail()
  async {

    try {

      User? user =
          _auth.currentUser;

      if (user == null) {

        return
            "No logged in user";
      }

      await user
          .sendEmailVerification();

      return
          "Verification email sent";

    } catch (e) {

      return
          "Something went wrong";
    }
  }

  // =========================
  // EMAIL VERIFIED
  // =========================

  Future<bool>
      isEmailVerified()
  async {

    User? user =
        _auth.currentUser;

    await user?.reload();

    user = _auth.currentUser;

    return user?.emailVerified ??
        false;
  }

  // =========================
  // GET CURRENT USER
  // =========================

  User? getCurrentUser() {

    return _auth.currentUser;
  }

  // =========================
  // LOGOUT
  // =========================

  Future<void> logoutUser()
  async {

    User? user =
        _auth.currentUser;

    if (user != null) {

      await _userService
          .updateUser(

        uid: user.uid,

        data: {

          "isOnline": false,

          "lastSeen":
              DateTime.now(),
        },
      );
    }

    await _auth.signOut();
  }
}