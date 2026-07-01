import 'dart:ui';

import 'package:flutter/material.dart';

import 'forgot_password_screen.dart';
import 'register_screen.dart';
import '../../home/screens/home_screen.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  final AuthService authService =
      AuthService();

  bool isLoading = false;
@override
void dispose() {

  emailController.dispose();

  passwordController.dispose();

  super.dispose();
}
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

            height: size.height * 0.45,

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

          // GLOW CIRCLES

          Positioned(

            top: -40,
            right: -20,

            child: Container(

              height: 180,
              width: 180,

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                color: Colors.white
                    .withOpacity(0.08),
              ),
            ),
          ),

          Positioned(

            top: 120,
            left: -50,

            child: Container(

              height: 140,
              width: 140,

              decoration: BoxDecoration(

                shape: BoxShape.circle,

                color: Colors.white
                    .withOpacity(0.06),
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

                    // HERO SECTION

                    Column(

                      children: [

                        // LOGO

                        Container(

                          height: 95,
                          width: 95,

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.white,

                            borderRadius:
                                BorderRadius
                                    .circular(
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

                            Icons.school_rounded,

                            size: 45,

                            color:
                                Color(0xFF6C63FF),
                          ),
                        ),

                        const SizedBox(height: 28),

                        const Text(

                          "CampusConnect",

                          style: TextStyle(

                            fontSize: 34,

                            fontWeight:
                                FontWeight.bold,

                            color: Colors.white,

                            letterSpacing: -1,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(

                          "Smart Student Community Platform",

                          textAlign:
                              TextAlign.center,

                          style: TextStyle(

                            fontSize: 16,

                            color: Colors.white
                                .withOpacity(0.9),

                            height: 1.5,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 55),

                    // FLOATING GLASS CARD

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

                                "Welcome Back 👋",

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

                                "Login to continue your campus journey.",

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
                                  height: 22),

                              // PASSWORD FIELD

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
                                      passwordController,

                                  obscureText: true,

                                  decoration:
                                      const InputDecoration(

                                    hintText:
                                        "Password",

                                    prefixIcon:
                                        Icon(

                                      Icons
                                          .lock_outline_rounded,

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
                                  height: 14),

                              // FORGOT PASSWORD

                              Align(

                                alignment:
                                    Alignment
                                        .centerRight,

                                child: TextButton(

                                  onPressed: () {

                                    Navigator.push(

                                      context,

                                      MaterialPageRoute(

                                        builder: (_) =>
                                            const ForgotPasswordScreen(),
                                      ),
                                    );
                                  },

                                  child: const Text(

                                    "Forgot Password?",

                                    style: TextStyle(

                                      color:
                                          Color(
                                              0xFF6C63FF),

                                      fontWeight:
                                          FontWeight
                                              .w600,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                  height: 25),

                              // LOGIN BUTTON

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

                                      width: double.infinity,

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

                                          String password =
                                              passwordController
                                                  .text
                                                  .trim();

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

                                          if (password
                                              .isEmpty) {

                                            ScaffoldMessenger.of(
                                                    context)
                                                .showSnackBar(

                                              const SnackBar(

                                                content:
                                                    Text(
                                                  "Enter Password",
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
        .loginUser(

  email: email,

  password: password,
);

if (!mounted) {
  return;
}

setState(() {

  isLoading = false;
});

                                          if (!mounted) {
                                            return;
                                          }

                                          ScaffoldMessenger.of(
                                                  context)
                                              .showSnackBar(

                                            SnackBar(

                                              behavior:
                                                  SnackBarBehavior
                                                      .floating,

                                              content:
                                                  Text(
                                                      result),
                                            ),
                                          );

                                         if (result
    .toLowerCase()
    .contains("success")) {

                                           Navigator.pushReplacement(

  context,

  MaterialPageRoute(

    builder: (_) =>
        const HomeScreen(),
  ),
);
                                          }
                                        },

                                        child: const Text(

                                          "Login",

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

                    const SizedBox(height: 35),

                    // REGISTER SECTION

                    Row(

                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        Text(

                          "Don't have an account?",

                          style: TextStyle(

                            color: Colors
                                .grey.shade700,
                          ),
                        ),

                        TextButton(

                          onPressed: () {

                            Navigator.push(

                              context,

                              MaterialPageRoute(

                                builder: (_) =>
                                    const RegisterScreen(),
                              ),
                            );
                          },

                          child: const Text(

                            "Register",

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
          ),
        ],
      ),
    );
  }
}