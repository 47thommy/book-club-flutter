import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/application/auth/auth.dart';
import 'package:client/application/file/file.dart';
import 'package:client/application/user/user.dart';
import 'package:client/domain/core/validator.dart';
import 'package:client/domain/user/profile_form.dart';
import 'package:client/infrastructure/file/file_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  final confirmPasswordController = TextEditingController();
  final bioController = TextEditingController();
  final usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final user = context.read<UserRepository>().getLoggedInUserSync();
    emailController.text = user.email;
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
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

  void uploadImage() {
    final fileBloc = context.read<FileBloc>();
    fileBloc.add(
        UploadFile(file: File(pickedImage!.path), reason: 'Profile Update'));
  }

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void updateProfile(String? imageUrl) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isEditing = !isEditing;
      });
      _formKey.currentState!.save();

      final user = context.read<UserRepository>().getLoggedInUserSync();

      final form = ProfileForm(
        email: emailController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        username: usernameController.text,
        bio: bioController.text,
        imageUrl: imageUrl ?? user.imageUrl,
      );

      context.read<UserBloc>().add(ProfileUpdate(form));

      pickedImage = null;
    }
  }

  void onChange() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserRepository>().getLoggedInUserSync();

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            setState(() {});
            showSuccess(context, 'User profile updated!');
          }
        },

        // body
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              //
              // Edit button
              BlocConsumer<FileBloc, FileState>(
                // listener
                listener: (context, fileState) {
                  // group image upload successfull, now update the group
                  if (fileState is FileUploaded &&
                      fileState.reason == 'Profile Update') {
                    updateProfile(fileState.url);
                  }

                  // upload failure
                  else if (fileState is FileOperationFailure) {
                    showFailure(context, fileState.error.toString());
                  }
                },

                builder: (context, fileState) {
                  return IconButton(
                    icon: isEditing
                        ? const Icon(Icons.save)
                        : const Icon(Icons.edit),
                    onPressed: isEditing
                        ? () {
                            if (pickedImage != null) {
                              uploadImage();
                            } else {
                              updateProfile(null);
                            }
                          }
                        : toggleEdit,
                  );
                },
              ),

              //
              // Logout button
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 'logout',
                      child: Row(children: [
                        Icon(Icons.logout),
                        SizedBox(width: 10),
                        Text('Log out')
                      ]),
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 'logout') {
                    context.read<AuthenticationBloc>().add(UserLoggedOut());
                    context.go('/');
                  }
                },
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
                      _buildProfileImage(context
                          .read<FileRepository>()
                          .getFullUrl(user.imageUrl)),
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
                              //
                              // Email field [not editable]
                              title: const Text('Email'),
                              subtitle: TextFormField(
                                validator: (value) {
                                  var result = validateEmail(value!);

                                  if (result != null) {
                                    return result.failure!.toString();
                                  }
                                  return null;
                                },
                                enabled: false,
                                controller: emailController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) => onChange(),
                              )),
                        )),

                        //
                        // Username field
                        const SizedBox(height: 8),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ListTile(
                                title: const Text('Username'),
                                subtitle: TextFormField(
                                  validator: (value) {
                                    var result = validateUsername(value!);

                                    if (result != null) {
                                      return result.failure!.toString();
                                    }
                                    return null;
                                  },
                                  enabled: isEditing,
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) => onChange(),
                                )),
                          ),
                        ),

                        //
                        // Name fields
                        if (isEditing) ...[
                          // firstname field
                          const SizedBox(height: 8),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListTile(
                                  title: const Text('First name'),
                                  subtitle: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your first name';
                                      }
                                      return null;
                                    },
                                    enabled: isEditing,
                                    controller: firstNameController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) => onChange(),
                                  )),
                            ),
                          ),

                          // lastname field
                          const SizedBox(height: 8),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListTile(
                                  title: const Text('Last name'),
                                  subtitle: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your last name';
                                      }
                                      return null;
                                    },
                                    enabled: isEditing,
                                    controller: lastNameController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) => onChange(),
                                  )),
                            ),
                          ),
                        ],

                        if (isEditing) ...[
                          // Password field
                          const SizedBox(height: 8),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListTile(
                                  title: const Text('Password'),
                                  subtitle: TextFormField(
                                    obscureText: true,
                                    validator: (value) {
                                      var result = validatePassword(value!);

                                      if (result != null) {
                                        return result.failure!.toString();
                                      }
                                      return null;
                                    },
                                    controller: passwordController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) => onChange(),
                                  )),
                            ),
                          ),

                          //
                          // Confirm password field
                          const SizedBox(height: 8),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListTile(
                                  title: const Text('Confirm password'),
                                  subtitle: TextFormField(
                                    obscureText: true,
                                    validator: (value) {
                                      var result = validateConfirmPassword(
                                          value!, passwordController.text);

                                      if (result != null) {
                                        return result.failure!.toString();
                                      }
                                      return null;
                                    },
                                    controller: confirmPasswordController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                    onChanged: (value) => onChange(),
                                  )),
                            ),
                          ),
                        ],

                        //
                        // Bio controller
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
                                onChanged: (value) => onChange(),
                              )),
                        )),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }

  Widget _buildProfileImage(String imageUrl) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: imageUrl,
          errorWidget: (context, url, error) => CircleAvatar(
            radius: 40,
            backgroundImage: pickedImage != null
                ? FileImage(File(pickedImage!.path)) as ImageProvider<Object>?
                : null,
          ),
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(
              radius: 40,
              backgroundImage: pickedImage != null
                  ? FileImage(File(pickedImage!.path)) as ImageProvider<Object>?
                  : imageProvider,
            );
          },
        ),
        Positioned(
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
