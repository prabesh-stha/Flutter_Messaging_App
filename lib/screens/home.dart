import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/providers/message_provider.dart';
import 'package:messaging_app/providers/user_provider.dart';
import 'package:messaging_app/screens/chat_screen.dart';
import 'package:messaging_app/services/auth_services.dart';
import 'package:messaging_app/services/chat_service.dart';
import 'package:messaging_app/shared/capitalize_word.dart';
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
    final chatAsyncValue = ref.watch(chatsProvider);
    return Scaffold(
      appBar: AppBar(
        title: user.when(
          data: (userData) {
            if(userData!= null){
              // return Text('${userData.name[0].toUpperCase()}${userData.name.substring(1)}' );
              return CapitalizeWord(text: userData.name, styleOfText: StyleOfText.title,);
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
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Consumer(
          builder: (context, ref, child) {
            return chatAsyncValue.when(
              data: (chatsList) {
                return ListView.builder(
                  itemCount: chatsList.length,
                  itemBuilder: (context, index) {
                    final chat = chatsList[index];
                    return Dismissible(key: ValueKey(chat.chat.chatId),
                     background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  ChatService.deleteChat(chat.chat.chatId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${chat.receiverUser.name} deleted')),
                  );
                },
                     child: ListTile(
                      leading: CircleAvatar(
                                radius: 50,
                                backgroundImage: chat.receiverUser.photoUrl != null ? NetworkImage(chat.receiverUser.photoUrl!) : null,
                                child: chat.receiverUser.photoUrl == null ? const Icon(Icons.person, size: 50) : null,
                              ),
                      title: CapitalizeWord(text: chat.receiverUser.name, styleOfText: StyleOfText.body),
                      subtitle: StyledText(text: chat.receiverUser.email),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(senderId: chat.senderUser.uid, participants: [chat.senderUser.uid, chat.receiverUser.uid], receiverUser: chat.receiverUser))),
                    )
                    );
                  },
                );
              },
              error: (error, _) => const Text("Error loading users"),
              loading: () => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      )
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
                      leading: CircleAvatar(
                                radius: 50,
                                backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                                child: user.photoUrl == null ? const Icon(Icons.person, size: 50) : null,
                              ),
                      title: CapitalizeWord(text: user.name, styleOfText: StyleOfText.body),
                      subtitle: StyledText(text: user.email),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(senderId: currentUser.uid, participants: [currentUser.uid, user.uid], receiverUser: user)));
                      } 
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

