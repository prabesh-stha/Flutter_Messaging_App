import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/providers/user_provider.dart';
import 'package:messaging_app/services/auth_services.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: user.when(
          data: (userData) {
            if(userData!= null){
              return Text('${userData.name[0].toUpperCase()}${userData.name.substring(1)}' );
            }else{
              return const Text("User");
            }
          },
          loading: () => const Text('Loading...'),
          error: (error, _) => const Text('Error'),
        ),
        leading:
          IconButton(onPressed: (){
            AuthServices.signOut();
          }, color: const Color.fromARGB(255, 182, 17, 5),icon: const Icon(Icons.logout_outlined))
      ),
      body: Column(
      children: [
        
      ],
    ),
    );
  }
}