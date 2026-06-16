import 'package:experience_app/core/local_storage.dart';
import 'package:experience_app/core/navigation/router.dart';
import 'package:experience_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await LocalStorage().init();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(primarySwatch: Colors.blue),
      title: 'Experience App',
      debugShowCheckedModeBanner: false,
    );
  }
}
