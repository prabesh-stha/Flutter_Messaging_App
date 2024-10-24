import 'package:flutter/material.dart';
import 'package:messaging_app/services/auth_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Username"),
      ),
      body: Column(
      children: [
        ElevatedButton(onPressed: (){
          AuthServices.signOut();
        }, child: const Text("Sign out"))
      ],
    ),
    );
  }
}