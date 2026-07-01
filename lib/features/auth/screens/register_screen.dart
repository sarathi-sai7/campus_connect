import 'dart:ui';

import 'package:flutter/material.dart';

import '../services/auth_service.dart';

import 'verify_email_screen.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  final TextEditingController
      confirmPasswordController =
      TextEditingController();

  final AuthService authService =
      AuthService();

  bool isLoading = false;

  bool obscurePassword = true;

  bool obscureConfirmPassword =
      true;

  @override
  void dispose() {

    nameController.dispose();

    emailController.dispose();

    passwordController.dispose();

    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size =
        MediaQuery.of(context).size;

    final isDark =

        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(

      resizeToAvoidBottomInset: true,

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

            height: size.height * 0.40,

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
          // GLOW EFFECTS
          // =========================

          Positioned(

            top: -50,
            right: -30,

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

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: Column(

                children: [

                  const SizedBox(height: 30),

                  // =========================
                  // LOGO
                  // =========================

                  Container(

                    height: 90,
                    width: 90,

                    decoration:
                        BoxDecoration(

                      color:

                          isDark

                              ? const Color(
                                  0xFF1E1E1E)

                              : Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                              28),

                      boxShadow: [

                        BoxShadow(

                          color: Colors.black
                              .withOpacity(0.08),

                          blurRadius: 25,

                          offset:
                              const Offset(
                                  0, 10),
                        ),
                      ],
                    ),

                    child: const Icon(

                      Icons.school_rounded,

                      color:
                          Color(0xFF6C63FF),

                      size: 42,
                    ),
                  ),

                  const SizedBox(height: 28),

                  const Text(

                    "Create Account",

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

                    "Join your smart campus ecosystem",

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(

                      fontSize: 15,

                      color: Colors.white
                          .withOpacity(0.92),

                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // =========================
                  // GLASS CARD
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
                                          0.88),

                          borderRadius:
                              BorderRadius
                                  .circular(35),

                          border: Border.all(

                            color:

                                isDark

                                    ? Colors.white
                                        .withOpacity(
                                            0.05)

                                    : Colors.white
                                        .withOpacity(
                                            0.4),
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

                            Text(

                              "Get Started 🚀",

                              style: TextStyle(

                                fontSize: 26,

                                fontWeight:
                                    FontWeight
                                        .bold,

                                color:

                                    isDark

                                        ? Colors
                                            .white

                                        : const Color(
                                            0xFF1A1A1A),
                              ),
                            ),

                            const SizedBox(
                                height: 8),

                            Text(

                              "Official college emails unlock ERP, attendance, marks and student communities.",

                              style: TextStyle(

                                fontSize: 15,

                                color:

                                    isDark

                                        ? Colors
                                            .grey
                                            .shade400

                                        : Colors
                                            .grey
                                            .shade700,

                                height: 1.5,
                              ),
                            ),

                            const SizedBox(
                                height: 30),

                            // =========================
                            // NAME FIELD
                            // =========================

                            buildInputField(

                              controller:
                                  nameController,

                              hint:
                                  "Full Name",

                              icon:
                                  Icons.person_outline_rounded,

                              isDark:
                                  isDark,
                            ),

                            const SizedBox(
                                height: 20),

                            // =========================
                            // EMAIL FIELD
                            // =========================

                            buildInputField(

                              controller:
                                  emailController,

                              hint:
                                  "College / Personal Email",

                              icon:
                                  Icons.mail_outline_rounded,

                              keyboardType:
                                  TextInputType
                                      .emailAddress,

                              isDark:
                                  isDark,
                            ),

                            const SizedBox(
                                height: 20),

                            // =========================
                            // PASSWORD FIELD
                            // =========================

                            buildInputField(

                              controller:
                                  passwordController,

                              hint:
                                  "Password",

                              icon:
                                  Icons.lock_outline_rounded,

                              obscureText:
                                  obscurePassword,

                              isDark:
                                  isDark,

                              suffixIcon:
                                  IconButton(

                                onPressed: () {

                                  setState(() {

                                    obscurePassword =
                                        !obscurePassword;
                                  });
                                },

                                icon: Icon(

                                  obscurePassword

                                      ? Icons
                                          .visibility_off_rounded

                                      : Icons
                                          .visibility_rounded,

                                  color: Colors
                                      .grey,
                                ),
                              ),
                            ),

                            const SizedBox(
                                height: 20),

                            // =========================
                            // CONFIRM PASSWORD
                            // =========================

                            buildInputField(

                              controller:
                                  confirmPasswordController,

                              hint:
                                  "Confirm Password",

                              icon:
                                  Icons
                                      .verified_user_outlined,

                              obscureText:
                                  obscureConfirmPassword,

                              isDark:
                                  isDark,

                              suffixIcon:
                                  IconButton(

                                onPressed: () {

                                  setState(() {

                                    obscureConfirmPassword =
                                        !obscureConfirmPassword;
                                  });
                                },

                                icon: Icon(

                                  obscureConfirmPassword

                                      ? Icons
                                          .visibility_off_rounded

                                      : Icons
                                          .visibility_rounded,

                                  color: Colors
                                      .grey,
                                ),
                              ),
                            ),

                            const SizedBox(
                                height: 24),

                            // =========================
                            // INFO CARD
                            // =========================

                            Container(

                              padding:
                                  const EdgeInsets.all(
                                      16),

                              decoration:
                                  BoxDecoration(

                                color:
                                    const Color(
                                  0xFF6C63FF,
                                ).withOpacity(0.08),

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

                                      "Students using official college emails get access to ERP, attendance, marks, clubs and private communities.",

                                      style:
                                          TextStyle(

                                        height:
                                            1.5,

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
                            // REGISTER BUTTON
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

                                onPressed:
                                    isLoading

                                        ? null

                                        : () async {

                                            String name =
                                                nameController
                                                    .text
                                                    .trim();

                                            String email =
                                                emailController
                                                    .text
                                                    .trim();

                                            String password =
                                                passwordController
                                                    .text
                                                    .trim();

                                            String confirmPassword =
                                                confirmPasswordController
                                                    .text
                                                    .trim();

                                            // =========================
                                            // VALIDATION
                                            // =========================

                                            if (name
                                                .isEmpty) {

                                              showMessage(

                                                "Enter Full Name",

                                                Colors.red,
                                              );

                                              return;
                                            }

                                            if (email
                                                .isEmpty) {

                                              showMessage(

                                                "Enter Email",

                                                Colors.red,
                                              );

                                              return;
                                            }

                                            if (!email
                                                .contains("@")) {

                                              showMessage(

                                                "Enter valid email",

                                                Colors.red,
                                              );

                                              return;
                                            }

                                            if (password
                                                .isEmpty) {

                                              showMessage(

                                                "Enter Password",

                                                Colors.red,
                                              );

                                              return;
                                            }

                                            if (password
                                                    .length <
                                                6) {

                                              showMessage(

                                                "Password must be at least 6 characters",

                                                Colors.red,
                                              );

                                              return;
                                            }

                                            if (password !=
                                                confirmPassword) {

                                              showMessage(

                                                "Passwords do not match",

                                                Colors.red,
                                              );

                                              return;
                                            }

                                            setState(() {

                                              isLoading =
                                                  true;
                                            });

                                            String result =

                                                await authService
                                                    .registerUser(

                                              name:
                                                  name,

                                              email:
                                                  email,

                                              password:
                                                  password,
                                            );

                                            if (!mounted) {
                                              return;
                                            }

                                            setState(() {

                                              isLoading =
                                                  false;
                                            });

                                            // =========================
                                            // SUCCESS
                                            // =========================

                                            if (result ==
                                                "success") {

                                              showMessage(

                                                "Verification email sent successfully",

                                                const Color(
                                                  0xFF00B894,
                                                ),
                                              );

                                              Navigator.pushReplacement(

                                                context,

                                                MaterialPageRoute(

                                                  builder: (_) =>
                                                      VerifyEmailScreen(
                                                    email:
                                                        email,
                                                  ),
                                                ),
                                              );
                                            }

                                            // =========================
                                            // ERROR
                                            // =========================

                                            else {

                                              showMessage(

                                                result,

                                                Colors.red,
                                              );
                                            }
                                          },

                                child:

                                    isLoading

                                        ? const SizedBox(

                                            height: 24,
                                            width: 24,

                                            child:
                                                CircularProgressIndicator(

                                              strokeWidth:
                                                  2.5,

                                              color:
                                                  Colors.white,
                                            ),
                                          )

                                        : const Text(

                                            "Create Account",

                                            style:
                                                TextStyle(

                                              fontSize:
                                                  17,

                                              fontWeight:
                                                  FontWeight.bold,

                                              color:
                                                  Colors.white,
                                            ),
                                          ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // =========================
                  // LOGIN SECTION
                  // =========================

                  Row(

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Text(

                        "Already have an account?",

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

                      TextButton(

                        onPressed: () {

                          Navigator.pushReplacement(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>
                                  const LoginScreen(),
                            ),
                          );
                        },

                        child: const Text(

                          "Login",

                          style: TextStyle(

                            color:
                                Color(0xFF6C63FF),

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // INPUT FIELD
  // =========================

  Widget buildInputField({

    required TextEditingController
        controller,

    required String hint,

    required IconData icon,

    required bool isDark,

    bool obscureText = false,

    Widget? suffixIcon,

    TextInputType keyboardType =
        TextInputType.text,
  }) {

    return Container(

      decoration: BoxDecoration(

        color:

            isDark

                ? const Color(0xFF2A2A2A)

                : Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        border: Border.all(

          color:

              isDark

                  ? Colors.white
                      .withOpacity(0.05)

                  : const Color(
                      0xFFE5E7EB,
                    ),
        ),
      ),

      child: TextField(

        controller: controller,

        obscureText: obscureText,

        keyboardType: keyboardType,

        style: TextStyle(

          color:

              isDark

                  ? Colors.white

                  : Colors.black,
        ),

        decoration: InputDecoration(

          hintText: hint,

          hintStyle: TextStyle(

            color:

                isDark

                    ? Colors.grey
                        .shade500

                    : Colors.grey
                        .shade600,
          ),

          prefixIcon: Icon(

            icon,

            color:
                const Color(
              0xFF6C63FF,
            ),
          ),

          suffixIcon: suffixIcon,

          border: InputBorder.none,

          contentPadding:
              const EdgeInsets.symmetric(

            vertical: 20,
          ),
        ),
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

        shape:
            RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(
                  16),
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