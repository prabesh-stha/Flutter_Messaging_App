import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messaging_app/models/app_user.dart';
import 'package:messaging_app/providers/auth_provider.dart';
import 'package:messaging_app/screens/home.dart';
import 'package:messaging_app/screens/welcome.dart';
import 'package:messaging_app/shared/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: primaryTheme,
      home: Consumer(builder: (context,ref,child){
        final AsyncValue<AppUser?> user = ref.watch(authProvider);

        return user.when(data: (value){
          if(value == null){
            return const Welcome();
          }
            return const Home();
        }, error: (error, _) => const Text("Error while logging in."), loading: () => const CircularProgressIndicator());
      })
    );
  }
}
