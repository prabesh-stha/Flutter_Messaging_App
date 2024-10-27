import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messaging_app/models/user.dart';
import 'package:messaging_app/screens/delete_user_sheet.dart';
import 'package:messaging_app/services/auth_services.dart';
import 'package:messaging_app/services/storage_services.dart';
import 'package:messaging_app/services/user_services.dart';
import 'package:messaging_app/shared/capitalize_word.dart';
import 'package:messaging_app/shared/styled_text.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker picker = ImagePicker();
  File? _imageFile;
  bool isTapped = false;

  Future<void> selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        isTapped = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle(text: "Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  if (isTapped)
                    Center(
                      child: GestureDetector(
                        onTap: selectImage,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: FileImage(_imageFile!),
                        ),
                      ),
                    ),
                  if (!isTapped)
                    Center(
                      child: GestureDetector(
                        onTap: selectImage,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: widget.user.photoUrl != null
                              ? NetworkImage(widget.user.photoUrl!)
                              : null,
                          child: widget.user.photoUrl == null
                              ? const Icon(Icons.person_outline, size: 100)
                              : null,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: CapitalizeWord(
                          text: widget.user.name,
                          styleOfText: StyleOfText.body,
                        ),
                      ),
                      Positioned(
                        right: 30,
                        child: IconButton(
                          onPressed: () {
                            showNameEditSheet(context, context, widget.user);
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          child: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Delete ${widget.user.name} profile."
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.red, fontSize: 18),
                                        ),
                                        content: const StyledText(
                                            text: "Are you sure?"),
                                        actions: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                foregroundColor: Colors.white,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                showDeleteUser(context, widget.user);
                                              },
                                              child: const Text("Yes")),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                  foregroundColor:
                                                      Colors.white),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("No"))
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              )))
                    ],
                  ),
                  Center(
                    child: StyledText(text: widget.user.email),
                  )
                ],
              ),
            ),
            if (isTapped)
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      try {
                        UserServices.upadateImage(widget.user, _imageFile!);
                        setState(() {
                          isTapped = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: StyledText(
                              text:
                                  '${widget.user.name} profile image changed successfully'),
                          duration: const Duration(seconds: 2),
                          showCloseIcon: true,
                          backgroundColor: Colors.green,
                        ));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: StyledText(
                              text:
                                  '${widget.user.name} profile image failed to changed'),
                          duration: const Duration(seconds: 2),
                          showCloseIcon: true,
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: const StyledHeading(
                      text: "Update profile image",
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                    )),
              )
          ],
        ),
      ),
    );
  }

  
}
void showDeleteUser(BuildContext context, User user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DeleteUserSheet(
            user: user,
            // onDeleteSuccess: (success) {
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: success ? const StyledText(text: "Success") : const StyledText(text: "Failed"), backgroundColor: success ? Colors.green : Colors.red,));
            // }
            );
      },
    );
  }
void showNameEditSheet(
    BuildContext sheetcontext, BuildContext mainContext, User user) {
  final nameController = TextEditingController();
  nameController.text = user.name;
  showModalBottomSheet(
      context: sheetcontext,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
            height: 400,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        final name = nameController.text.trim().toLowerCase();
                        if (name.isNotEmpty) {
                          UserServices.updateName(user, name);
                          Navigator.pop(sheetcontext);

                          ScaffoldMessenger.of(mainContext)
                              .showSnackBar(const SnackBar(
                            content:
                                StyledText(text: "Name changed successfully"),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          Navigator.pop(sheetcontext);
                          ScaffoldMessenger.of(mainContext)
                              .showSnackBar(const SnackBar(
                            content: StyledText(text: "Failed to change name."),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: const StyledHeading(
                        text: "Update name",
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ));
      });
}
