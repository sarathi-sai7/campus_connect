import 'dart:ui';

import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class ForgotPasswordScreen
    extends StatefulWidget {

  const ForgotPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordScreen>
      createState() =>
          _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {

  final TextEditingController
      emailController =
      TextEditingController();

  final AuthService authService =
      AuthService();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    final size =
        MediaQuery.of(context).size;

    return Scaffold(

      backgroundColor:
          const Color(0xFFF4F6FF),

      body: Stack(

        children: [

          // TOP GRADIENT

          Container(

            height: size.height * 0.40,

            decoration: const BoxDecoration(

              gradient: LinearGradient(

                begin: Alignment.topLeft,
                end: Alignment.bottomRight,

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

          // BACKGROUND CIRCLES

          Positioned(

            top: -40,
            right: -20,

            child: Container(

              height: 200,
              width: 200,

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                color: Colors.white
                    .withOpacity(0.08),
              ),
            ),
          ),

          Positioned(

            top: 130,
            left: -50,

            child: Container(

              height: 140,
              width: 140,

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                color: Colors.white
                    .withOpacity(0.05),
              ),
            ),
          ),

          SafeArea(

            child: SingleChildScrollView(

              child: Padding(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 24,
                ),

                child: Column(

                  children: [

                    const SizedBox(height: 40),

                    // ICON

                    Container(

                      height: 90,
                      width: 90,

                      decoration:
                          BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                                28),

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

                        Icons.lock_reset_rounded,

                        color:
                            Color(0xFF6C63FF),

                        size: 42,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // TITLE

                    const Text(

                      "Forgot Password",

                      style: TextStyle(

                        fontSize: 34,

                        fontWeight:
                            FontWeight.bold,

                        color: Colors.white,

                        letterSpacing: -1,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(

                      "Reset your account password securely",

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(

                        fontSize: 15,

                        color: Colors.white
                            .withOpacity(0.9),

                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 55),

                    // GLASS CARD

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

                            color: Colors.white
                                .withOpacity(0.82),

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        35),

                            border: Border.all(

                              color: Colors.white
                                  .withOpacity(0.4),
                            ),

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

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              const Text(

                                "Reset Link 📩",

                                style: TextStyle(

                                  fontSize: 26,

                                  fontWeight:
                                      FontWeight
                                          .bold,

                                  color:
                                      Color(
                                          0xFF1A1A1A),
                                ),
                              ),

                              const SizedBox(
                                  height: 8),

                              Text(

                                "Enter your registered email address to receive a secure password reset link.",

                                style: TextStyle(

                                  fontSize: 15,

                                  color: Colors
                                      .grey
                                      .shade700,

                                  height: 1.5,
                                ),
                              ),

                              const SizedBox(
                                  height: 35),

                              // EMAIL FIELD

                              Container(

                                decoration:
                                    BoxDecoration(

                                  color:
                                      Colors.white,

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              20),

                                  border: Border.all(

                                    color:
                                        const Color(
                                      0xFFE5E7EB,
                                    ),
                                  ),
                                ),

                                child: TextField(

                                  controller:
                                      emailController,

                                  keyboardType:
                                      TextInputType
                                          .emailAddress,

                                  decoration:
                                      const InputDecoration(

                                    hintText:
                                        "Email Address",

                                    prefixIcon:
                                        Icon(

                                      Icons
                                          .mail_outline_rounded,

                                      color:
                                          Color(
                                        0xFF6C63FF,
                                      ),
                                    ),

                                    border:
                                        InputBorder
                                            .none,

                                    contentPadding:
                                        EdgeInsets.symmetric(

                                      vertical:
                                          20,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                  height: 35),

                              // BUTTON

                              isLoading

                                  ? const Center(
                                      child:
                                          CircularProgressIndicator(
                                        color:
                                            Color(
                                          0xFF6C63FF,
                                        ),
                                      ),
                                    )

                                  : SizedBox(

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

                                          elevation:
                                              0,

                                          shape:
                                              RoundedRectangleBorder(

                                            borderRadius:
                                                BorderRadius.circular(
                                                    22),
                                          ),
                                        ),

                                        onPressed:
                                            () async {

                                          String email =
                                              emailController
                                                  .text
                                                  .trim();

                                          // EMPTY VALIDATION

                                          if (email
                                              .isEmpty) {

                                            ScaffoldMessenger.of(
                                                    context)
                                                .showSnackBar(

                                              const SnackBar(

                                                content:
                                                    Text(
                                                  "Enter Email",
                                                ),
                                              ),
                                            );

                                            return;
                                          }

                                          // EMAIL VALIDATION

                                          bool isValidEmail =

                                              RegExp(

                                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',

                                              ).hasMatch(
                                                  email);

                                          if (!isValidEmail) {

                                            ScaffoldMessenger.of(
                                                    context)
                                                .showSnackBar(

                                              const SnackBar(

                                                content:
                                                    Text(
                                                  "Enter Valid Email",
                                                ),
                                              ),
                                            );

                                            return;
                                          }

                                          setState(() {

                                            isLoading =
                                                true;
                                          });

                                          String result =
                                              await authService
                                                  .forgotPassword(
                                                      email);

                                          setState(() {

                                            isLoading =
                                                false;
                                          });

                                          if (!mounted) {
                                            return;
                                          }

                                          // SUCCESS

                                          if (result ==
                                              "Reset Email Sent") {

                                            showDialog(

                                              context:
                                                  context,

                                              builder:
                                                  (_) {

                                                return AlertDialog(

                                                  shape:
                                                      RoundedRectangleBorder(

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),

                                                  title:
                                                      const Text(
                                                    "Reset Email Sent 📩",
                                                  ),

                                                  content:
                                                      Text(

                                                    "A password reset link has been sent to:\n\n$email\n\nCheck your Inbox or Spam folder.",
                                                  ),

                                                  actions: [

                                                    TextButton(

                                                      onPressed:
                                                          () {

                                                        Navigator.pop(
                                                            context);

                                                        Navigator.pop(
                                                            context);
                                                      },

                                                      child:
                                                          const Text(
                                                        "OK",
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                          } else {

                                            // ERROR

                                            ScaffoldMessenger.of(
                                                    context)
                                                .showSnackBar(

                                              SnackBar(

                                                behavior:
                                                    SnackBarBehavior.floating,

                                                content:
                                                    Text(
                                                  result,
                                                ),
                                              ),
                                            );
                                          }
                                        },

                                        child: const Text(

                                          "Send Reset Link",

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
}