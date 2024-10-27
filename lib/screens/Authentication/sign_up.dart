import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/services/auth_services.dart';
import 'package:messaging_app/services/storage_services.dart';
import 'package:messaging_app/services/user_services.dart';
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
  bool _isLoading = false;
  String? _error;
  final _picker = ImagePicker();
  File? image;

  Future<void> _pickImage() async{
    print("tapped");
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        image = File(pickedFile.path);
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _key,
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: image != null ? FileImage(image!) : null,
                child: image == null ? const Icon(Icons.add_a_photo_outlined, size: 50,) : null,
              ),
            ),
            const SizedBox(height: 16,),
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

            if(_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red),),

            _isLoading ? const CircularProgressIndicator() :
            ElevatedButton(onPressed: ()async{
              setState(() {
                _isLoading = true;
              });
              final name = _nameController.text.toLowerCase().trim();
              final email = _emailController.text.toLowerCase().trim();
              final password = _passwordController.text.trim();

              final user = await AuthServices.signUp(email, password);

              if(user == null){
                setState(() {
                  _error = "Email already existed";
                });
              }else{
                if(image != null){
                final photoUrl = await StorageServices.uploadAndDownloadUrl(image!, user.uid);
                await UserServices.createUser(User(uid: user.uid, name: name, email: user.email, photoUrl: photoUrl));
                }
                
              }
              setState(() {
                _isLoading = false;
              });
            }, child: const Text("Sign up"))
          ],
        )),
    );
  }
}