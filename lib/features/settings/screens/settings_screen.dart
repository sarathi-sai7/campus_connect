import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/theme_provider.dart';

class SettingsScreen
    extends ConsumerWidget {

  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(

    BuildContext context,

    WidgetRef ref,
  ) {

    final isDark =
        ref.watch(themeProvider);

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Settings",
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            // THEME CARD

            Container(

              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color:
                    Theme.of(context)
                        .cardColor,

                borderRadius:
                    BorderRadius.circular(
                        25),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black
                        .withOpacity(0.05),

                    blurRadius: 20,

                    offset:
                        const Offset(0, 10),
                  ),
                ],
              ),

              child: Row(

                children: [

                  Container(

                    padding:
                        const EdgeInsets.all(
                            14),

                    decoration: BoxDecoration(

                      color:
                          const Color(
                        0xFF6C63FF,
                      ).withOpacity(0.1),

                      borderRadius:
                          BorderRadius.circular(
                              16),
                    ),

                    child: Icon(

                      isDark

                          ? Icons.dark_mode

                          : Icons.light_mode,

                      color:
                          const Color(
                        0xFF6C63FF,
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  const Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(

                          "Dark Mode",

                          style: TextStyle(

                            fontSize: 18,

                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(

                          "Switch app appearance",

                          style: TextStyle(

                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Switch(

                    value: isDark,

                    activeThumbColor:
                        const Color(
                      0xFF6C63FF,
                    ),

                    onChanged: (_) {

                      ref
                          .read(
                            themeProvider
                                .notifier,
                          )
                          .toggleTheme();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}