import 'package:flutter/material.dart';
import 'package:messaging_app/screens/Authentication/sign_in.dart';
import 'package:messaging_app/screens/Authentication/sign_up.dart';
import 'package:messaging_app/shared/styled_text.dart';


class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isnew = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MESSAGING APP", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: StyledHeading(text: isnew ? "Register to get started!" : "Welcome back!"),
            ),
            const SizedBox(height: 16,),
            if(isnew)
              const SignUp(),

            if(!isnew)
             const SignIn(),
          Center(child: TextButton(onPressed: (){
            setState(() {
              isnew = !isnew;
            });
          }, child: StyledText(text: isnew ? "Already have an account?" : "Didn't have an account?" )),)
            
          ],
        ),
      ),
    );
  }
}