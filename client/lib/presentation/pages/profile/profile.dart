import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  static const String routeName = 'profile';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? pickedImage;
  bool isEditing = false;

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final user = context.read<UserRepository>().getLoggedInUserSync();
    emailController.text = user.email;
    firstNameController.text = user.firstName;
    lastNameController.text = user.firstName;
    bioController.text = user.bio;
    usernameController.text = user.username;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        pickedImage = pickedFile;
      });
    }
  }

  void toggleEdit() {
    final user = context.read<UserRepository>().getLoggedInUserSync();

    setState(() {
      isEditing = !isEditing;
    });
  }

  void saveFormChanges() {
    setState(() {
      isEditing = !isEditing;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserRepository>().getLoggedInUserSync();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: isEditing ? const Icon(Icons.save) : const Icon(Icons.edit),
            onPressed: isEditing ? saveFormChanges : toggleEdit,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildProfileImage(),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          Text(usernameController.text)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              //
              //  Account form
              //
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListTile(
                          title: const Text('Email'),
                          subtitle: TextFormField(
                            enabled: false,
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          )),
                    )),
                    const SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                            title: const Text('Username'),
                            subtitle: TextFormField(
                              enabled: isEditing,
                              controller: usernameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListTile(
                          title: const Text('Bio'),
                          subtitle: TextFormField(
                            controller: bioController,
                            enabled: isEditing,
                            maxLines: 2,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          )),
                    )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: pickedImage != null
              ? FileImage(File(pickedImage!.path)) as ImageProvider<Object>?
              : const AssetImage('assets/profile.png'),
        ),
        Positioned(
          bottom: 25,
          right: 25,
          child: IconButton(
            icon: const Icon(
              Icons.add_a_photo_outlined,
              color: Colors.white,
            ),
            onPressed: pickImage,
          ),
        ),
      ],
    );
  }
}
