import 'package:flutter/material.dart';
import 'package:messaging_app/shared/styled_button.dart';
import 'package:messaging_app/shared/theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _key,
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(
                color: AppColor.textColor,
              ),
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person_2_outlined)
              ),
            ),

            const SizedBox(height: 16,),

            TextFormField(
              style: TextStyle(
                color: AppColor.textColor
              ),
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email_outlined)
              ),
            ),

            const SizedBox(height: 16,),

            TextFormField(
              controller: _passwordController,
              obscureText: !_showPassword,
              style: TextStyle(
                color: AppColor.textColor
              ),
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                }, icon: _showPassword ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined))
              ),
            ),
            
            const SizedBox(height: 16,),

            StyledButton(onPressed: (){

            }, text: "Sign up")
          ],
        )),
    );
  }
}