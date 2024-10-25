import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/providers/user_provider.dart';
import 'package:messaging_app/screens/chat_screen.dart';
import 'package:messaging_app/services/auth_services.dart';
import 'package:messaging_app/shared/styled_text.dart';

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
          }, color: const Color.fromARGB(255, 182, 17, 5),icon: const Icon(Icons.logout_outlined)),

        actions: [
          IconButton(onPressed: (){
            user.whenData((currentUser){
              if(currentUser != null){
                showAllUserSheet(context, ref, currentUser);
              }
            });
            
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: const Column(
      children: [
        
      ],
    ),
    );
  }
}


void showAllUserSheet(BuildContext context, WidgetRef ref, User currentUser) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    builder: (BuildContext context) {
      return Container(
        height: 400, // Set a fixed height for the bottom sheet
        padding: const EdgeInsets.all(16),
        child: Consumer(
          builder: (context, ref, child) {
            final usersAsyncValue = ref.watch(usersProvider);
            return usersAsyncValue.when(
              data: (users) {
                final filteredUsers = users.where((user) => user.uid != currentUser.uid).toList();
                return ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    return ListTile(
                      leading: const Icon(Icons.person_2_outlined),
                      title: StyledText(text: user.name),
                      subtitle: StyledText(text: user.email),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(senderId: currentUser.uid, participants: [currentUser.uid, user.uid], receiverUser: user))),
                    );
                  },
                );
              },
              error: (error, _) => const Text("Error loading users"),
              loading: () => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      );
    },
  );
}


class Example extends StatelessWidget {
  final User user;
  const Example({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            // Add more user details as needed
          ],
        ),
      ),
    );
  }
}