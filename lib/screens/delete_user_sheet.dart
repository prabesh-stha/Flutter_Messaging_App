import 'package:flutter/material.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/services/user_services.dart';
import 'package:messaging_app/shared/styled_text.dart';

class DeleteUserSheet extends StatefulWidget {
  final User user;
  const DeleteUserSheet({super.key, required this.user});

  @override
  State<DeleteUserSheet> createState() => _DeleteUserSheetState();
}

class _DeleteUserSheetState extends State<DeleteUserSheet> {
  final passwordController = TextEditingController();
  bool showPassword = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: passwordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: showPassword
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading ? const CircularProgressIndicator() :
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                final password = passwordController.text.trim();
                final bool result = await UserServices.deleteUser(widget.user.uid, password);
                setState(() {
                  _isLoading = false;
                });
                if(context.mounted){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: result ? const StyledText(text: "Success") : const StyledText(text: "Failed"), backgroundColor: result ? Colors.green : Colors.red, duration: const Duration(seconds: 2), showCloseIcon: true,));
                  Navigator.pop(context);
                }
              },
              child: const Text("Delete"),
            ),
          ],
        ),
      );
  }
}