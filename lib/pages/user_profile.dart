import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rnd_flutter_app/widgets/custom_appbar.dart';
import 'package:rnd_flutter_app/widgets/custom_button.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final picker = ImagePicker();
  XFile? image;

  Future getImage() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (img == null) return;
      // final imageTemporary = File(img.path);
      setState(() {
        image = img;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          content: Text('User Profile'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => getImage(),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        image != null ? FileImage(File(image!.path)) : null,
                    backgroundColor: Colors.white,
                    child: image == null
                        ? Image.asset(
                            'assets/images/avatar.png',
                            width: 80,
                            height: 80,
                          )
                        : null,
                    // child: image == null
                    //     ? Image.asset(
                    //         'assets/images/avatar.png',
                    //         width: 80,
                    //         height: 80,
                    //       )
                    //     : Image.file(image!,
                    //         height: 80, width: 80, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'Update',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
