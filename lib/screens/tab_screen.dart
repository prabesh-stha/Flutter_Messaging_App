import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messaging_app/providers/user_provider.dart';
import 'package:messaging_app/screens/home.dart';
import 'package:messaging_app/screens/profile_screen.dart';
import 'package:messaging_app/shared/styled_text.dart';


class TabScreen extends ConsumerWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return DefaultTabController(length: 2, child: Scaffold(
      body: user.when(data: (currentUser){
        if(currentUser == null){
          return const Center(child: CircularProgressIndicator());
        }
        else{
          return  TabBarView(children: [
            Home(user: currentUser,),
            ProfileScreen(user: currentUser)

      ]);
        }
      }, error: (error, _) => Center(child: StyledHeading(text: "Error while loading users: $error"),), loading: () => const CircularProgressIndicator()),

      bottomNavigationBar: const TabBar(tabs: [
         Tab(text: "Home", icon: Icon(Icons.home_outlined),),
          Tab(text: "Profile", icon: Icon(Icons.person_outline),)
         ]),
      
    )
    );
  }
}