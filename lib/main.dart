import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
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
      // home: const Example()
    );
  }
}


class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage() async {
    print('Pick image tapped'); // Debug statement
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        print(_imageFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Example")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                child: _imageFile == null 
                    ? const Icon(Icons.add_a_photo_outlined, size: 50) 
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}