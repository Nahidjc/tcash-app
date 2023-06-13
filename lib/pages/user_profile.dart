import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rnd_flutter_app/model/user_model.dart';
import 'package:rnd_flutter_app/provider/user_provider.dart';
import 'package:rnd_flutter_app/widgets/custom_appbar.dart';
import 'package:rnd_flutter_app/widgets/custom_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;

  const UserProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool isLoading = true;
  UserDetails? userDetails;

  final picker = ImagePicker();
  File? image;

  Future getImage() async {
    try {
      final img = await picker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        setState(() {
          image = File(img.path);
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserDetails();
    });
  }

  Future<void> fetchUserDetails() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    userDetails = await userProvider.fetchUserDetailsById(widget.userId);
    setState(() {
      isLoading = false;
    });
    if (userDetails != null) {
      nameController.text = userDetails!.name ?? '';
      emailController.text = userDetails!.email ?? '';
      usernameController.text = userDetails!.username ?? '';
    }
  }

  void showToastAfterupdateProfile() {
    Fluttertoast.showToast(
      msg: 'Update successful',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(
        content: Text(
          'User Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: isLoading
              ? Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 200,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    GestureDetector(
                      onTap: () => getImage(),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            image != null ? FileImage(image!) : null,
                        backgroundColor: Colors.white,
                        child: image == null
                            ? Image.asset(
                                'assets/images/avatar.png',
                                width: 80,
                                height: 80,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.account_circle),
                      ),
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        content: userProvider.isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Update User',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                        onPressed: () async {
                          final updatedName = nameController.text;
                          final updatedEmail = emailController.text;
                          final updatedUsername = usernameController.text;

                          final isUpdate = await userProvider.updateUserProfile(
                            name: updatedName,
                            email: updatedEmail,
                            username: updatedUsername,
                            profilePicPath: image?.path,
                            userId: widget.userId,
                          );
                          if (isUpdate) {
                            showToastAfterupdateProfile();
                          }
                          
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
