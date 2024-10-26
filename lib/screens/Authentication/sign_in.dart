import 'package:flutter/material.dart';
import 'package:messaging_app/services/auth_services.dart';
import 'package:messaging_app/shared/theme.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _isLoading = false;
  String? _error;
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
              style: TextStyle(
                color: AppColor.textColor
              ),
              controller: _passwordController,
              obscureText: !_showPassword,
              decoration:  InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                }, icon: _showPassword ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined))
              ),
            ),
            if(_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red,)),
            const SizedBox(height: 16,),
            _isLoading ? const CircularProgressIndicator() :
            ElevatedButton(onPressed: ()async{
              setState(() {
                _isLoading = true;
              });
              final email = _emailController.text.trim();
              final password = _passwordController.text.trim();
              final user = await AuthServices.signIn(email, password);
              if(user == null){
                setState(() {
                  _error = "Incorrect user information";
                });
              }
              setState(() {
                _passwordController.text = "";
                _isLoading = false;
              });

            }, child: const Text("Sign in"))
          ],
        ))
    );
  }
}