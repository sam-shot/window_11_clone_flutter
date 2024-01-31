import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:window_11/core/model/taskbar_model.dart';
import 'package:window_11/core/model/window_manager.dart';
import 'package:window_11/core/utils/responsive.dart';
import 'package:window_11/ui/views/home/home_view.dart';
import 'package:window_11/ui/views/not_supported/not_supported_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskbarModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => WindowManager(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Window 11',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.manropeTextTheme(),
      ),
      home: const AppWrapper(),
    );
  }
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      desktop: HomeView(),
      tablet: HomeView(),
      mobile: NotSupported(),
    );
  }
}
