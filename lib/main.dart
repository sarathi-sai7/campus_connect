import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';

import 'core/theme/app_theme.dart';

import 'providers/theme_provider.dart';

import 'features/auth/screens/auth_gate.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(

    const ProviderScope(

      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  @override
  Widget build(

    BuildContext context,

    WidgetRef ref,
  ) {

    final isDark =
        ref.watch(themeProvider);

    return MaterialApp(

      debugShowCheckedModeBanner:
          false,

      title: "CampusConnect",

      theme: AppTheme.lightTheme,

      darkTheme:
          AppTheme.darkTheme,

      themeMode:

          isDark

              ? ThemeMode.dark

              : ThemeMode.light,

      home: const AuthGate(),
    );
  }
}