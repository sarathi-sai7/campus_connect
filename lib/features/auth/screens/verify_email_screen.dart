import 'dart:ui';

import 'package:flutter/material.dart';

import 'login_screen.dart';

class VerifyEmailScreen
    extends StatefulWidget {

  final String email;

  const VerifyEmailScreen({

    super.key,

    required this.email,
  });

  @override
  State<VerifyEmailScreen>
      createState() =>
          _VerifyEmailScreenState();
}

class _VerifyEmailScreenState
    extends State<VerifyEmailScreen> {

  bool canResendEmail = true;

  @override
  Widget build(BuildContext context) {

    final size =
        MediaQuery.of(context).size;

    final isDark =

        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(

      backgroundColor:

          isDark

              ? const Color(0xFF121212)

              : const Color(0xFFF4F6FF),

      body: Stack(

        children: [

          // =========================
          // TOP GRADIENT
          // =========================

          Container(

            height: size.height * 0.42,

            decoration: const BoxDecoration(

              gradient: LinearGradient(

                begin: Alignment.topLeft,

                end:
                    Alignment.bottomRight,

                colors: [

                  Color(0xFF6C63FF),

                  Color(0xFF8B80FF),
                ],
              ),

              borderRadius:
                  BorderRadius.only(

                bottomLeft:
                    Radius.circular(50),

                bottomRight:
                    Radius.circular(50),
              ),
            ),
          ),

          // =========================
          // DECORATION CIRCLES
          // =========================

          Positioned(

            top: -40,
            right: -20,

            child: Container(

              height: 220,
              width: 220,

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                color: Colors.white
                    .withOpacity(0.08),
              ),
            ),
          ),

          Positioned(

            top: 140,
            left: -60,

            child: Container(

              height: 150,
              width: 150,

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                color: Colors.white
                    .withOpacity(0.05),
              ),
            ),
          ),

          SafeArea(

            child: SingleChildScrollView(

              physics:
                  const BouncingScrollPhysics(),

              child: Padding(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 24,
                ),

                child: Column(

                  children: [

                    const SizedBox(height: 45),

                    // =========================
                    // EMAIL ICON
                    // =========================

                    Container(

                      height: 95,
                      width: 95,

                      decoration:
                          BoxDecoration(

                        color:

                            isDark

                                ? const Color(
                                    0xFF1E1E1E)

                                : Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                                30),

                        boxShadow: [

                          BoxShadow(

                            color: Colors
                                .black
                                .withOpacity(
                                    0.08),

                            blurRadius: 25,

                            offset:
                                const Offset(
                                    0, 10),
                          ),
                        ],
                      ),

                      child: const Icon(

                        Icons.mark_email_read_rounded,

                        color:
                            Color(0xFF6C63FF),

                        size: 45,
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(

                      "Verify Email",

                      style: TextStyle(

                        fontSize: 34,

                        fontWeight:
                            FontWeight.bold,

                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(

                      "Secure your CampusConnect account",

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(

                        fontSize: 15,

                        color: Colors.white
                            .withOpacity(0.9),
                      ),
                    ),

                    const SizedBox(height: 55),

                    // =========================
                    // MAIN CARD
                    // =========================

                    ClipRRect(

                      borderRadius:
                          BorderRadius.circular(
                              35),

                      child: BackdropFilter(

                        filter: ImageFilter.blur(

                          sigmaX: 15,
                          sigmaY: 15,
                        ),

                        child: Container(

                          padding:
                              const EdgeInsets.all(
                                  26),

                          decoration: BoxDecoration(

                            color:

                                isDark

                                    ? const Color(
                                        0xFF1E1E1E)

                                    : Colors.white
                                        .withOpacity(
                                            0.9),

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        35),

                            boxShadow: [

                              BoxShadow(

                                color: Colors
                                    .black
                                    .withOpacity(
                                        0.06),

                                blurRadius: 30,

                                offset:
                                    const Offset(
                                        0, 15),
                              ),
                            ],
                          ),

                          child: Column(

                            children: [

                              Text(

                                "Verification Link Sent 📩",

                                textAlign:
                                    TextAlign.center,

                                style: TextStyle(

                                  fontSize: 26,

                                  fontWeight:
                                      FontWeight
                                          .bold,

                                  color:

                                      isDark

                                          ? Colors
                                              .white

                                          : Colors
                                              .black,
                                ),
                              ),

                              const SizedBox(
                                  height: 16),

                              Text(

                                "Please check your Gmail inbox and click the verification link to activate your CampusConnect account.",

                                textAlign:
                                    TextAlign.center,

                                style: TextStyle(

                                  fontSize: 15,

                                  height: 1.7,

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

                              const SizedBox(
                                  height: 25),

                              // =========================
                              // EMAIL DISPLAY BOX
                              // =========================

                              Container(

                                padding:
                                    const EdgeInsets.symmetric(

                                  horizontal: 18,
                                  vertical: 16,
                                ),

                                decoration:
                                    BoxDecoration(

                                  color:

                                      isDark

                                          ? const Color(
                                              0xFF2A2A2A)

                                          : const Color(
                                              0xFFF3F4FF),

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              18),
                                ),

                                child: Row(

                                  children: [

                                    const Icon(

                                      Icons.email_rounded,

                                      color:
                                          Color(
                                        0xFF6C63FF,
                                      ),
                                    ),

                                    const SizedBox(
                                        width: 12),

                                    Expanded(

                                      child: Text(

                                        widget.email,

                                        style:
                                            TextStyle(

                                          fontSize:
                                              15,

                                          fontWeight:
                                              FontWeight
                                                  .w600,

                                          color:

                                              isDark

                                                  ? Colors.white

                                                  : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                  height: 30),

                              // =========================
                              // INFO CARD
                              // =========================

                              Container(

                                padding:
                                    const EdgeInsets.all(
                                        18),

                                decoration:
                                    BoxDecoration(

                                  color:
                                      const Color(
                                    0xFF6C63FF,
                                  ).withOpacity(
                                          0.08),

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              18),
                                ),

                                child: Row(

                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    const Icon(

                                      Icons
                                          .info_outline_rounded,

                                      color:
                                          Color(
                                        0xFF6C63FF,
                                      ),
                                    ),

                                    const SizedBox(
                                        width: 12),

                                    Expanded(

                                      child: Text(

                                        "After verifying your email, return to login and sign in again to access CampusConnect.",

                                        style:
                                            TextStyle(

                                          height:
                                              1.6,

                                          color:

                                              isDark

                                                  ? Colors.white70

                                                  : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                  height: 30),

                              // =========================
                              // GO TO LOGIN BUTTON
                              // =========================

                              SizedBox(

                                width:
                                    double.infinity,

                                height: 60,

                                child:
                                    ElevatedButton(

                                  style:
                                      ElevatedButton.styleFrom(

                                    backgroundColor:
                                        const Color(
                                      0xFF6C63FF,
                                    ),

                                    elevation: 0,

                                    shape:
                                        RoundedRectangleBorder(

                                      borderRadius:
                                          BorderRadius.circular(
                                              22),
                                    ),
                                  ),

                                  onPressed: () {

                                    Navigator.pushAndRemoveUntil(

                                      context,

                                      MaterialPageRoute(

                                        builder:
                                            (_) =>
                                                const LoginScreen(),
                                      ),

                                      (route) =>
                                          false,
                                    );
                                  },

                                  child:
                                      const Text(

                                    "Go To Login",

                                    style:
                                        TextStyle(

                                      fontSize:
                                          17,

                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      color:
                                          Colors
                                              .white,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                  height: 18),

                              // =========================
                              // RESEND BUTTON
                              // =========================

                              TextButton(

                                onPressed:

                                    canResendEmail

                                        ? () async {

                                            setState(() {

                                              canResendEmail =
                                                  false;
                                            });

                                            showMessage(

                                              "Please wait before resending email",

                                              const Color(
                                                0xFF6C63FF,
                                              ),
                                            );

                                            await Future.delayed(

                                              const Duration(
                                                  seconds:
                                                      15),
                                            );

                                            if (!mounted) {
                                              return;
                                            }

                                            setState(() {

                                              canResendEmail =
                                                  true;
                                            });
                                          }

                                        : null,

                                child: Text(

                                  canResendEmail

                                      ? "Resend Email"

                                      : "Please wait...",

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
                              ),

                              const SizedBox(
                                  height: 10),

                              // =========================
                              // BACK BUTTON
                              // =========================

                              TextButton(

                                onPressed: () {

                                  Navigator.pop(
                                      context);
                                },

                                child: Text(

                                  "Back",

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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // SNACKBAR
  // =========================

  void showMessage(

    String message,

    Color color,
  ) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        behavior:
            SnackBarBehavior.floating,

        backgroundColor: color,

        shape: RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(16),
        ),

        content: Text(

          message,

          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}