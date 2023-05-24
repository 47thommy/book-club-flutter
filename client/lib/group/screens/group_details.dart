import 'package:client/group/blocs/blocs.dart';
import 'package:client/group/models/group.dart';
import 'package:client/group/screens/groups_screen.dart';
import 'package:client/user/blocs/blocs.dart';
import 'package:client/user/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GroupDetailPage extends StatefulWidget {
  static const routeName = 'group-detail';

  const GroupDetailPage({super.key});

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  XFile? pickedImage;

  final groupNameController = TextEditingController();
  final groupDescriptionController = TextEditingController();

  @override
  void dispose() {
    groupNameController.dispose();
    groupDescriptionController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New club'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildProfileImage(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: groupNameController,
                          decoration: const InputDecoration(
                            labelText: "Enter group name",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                const Text(
                  'About group',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 400,
                  controller: groupDescriptionController,
                )
              ],
            );
          },
        ),
        floatingActionButton: BlocConsumer<GroupBloc, GroupState>(
            listener: (context, state) async {
          if (state is GroupCreated) {
            final groupBloc = BlocProvider.of<GroupBloc>(context);
            final repository =
                BlocProvider.of<UserBloc>(context).userRepository;

            final token = (await repository.getCurrentUser()).token!;

            groupBloc.add(GroupLoad(token));

            if (mounted) {
              context.goNamed(HomePage.routeName);
            }
          }
        }, builder: (context, state) {
          if (state is GroupCreateInitiated) {
            return FloatingActionButton(
                child: const CircularProgressIndicator(), onPressed: () {});
          } else {
            return FloatingActionButton(
                child: const Icon(Icons.chevron_right),
                onPressed: () async {
                  final groupBLoc = BlocProvider.of<GroupBloc>(context);
                  final userBloc =
                      BlocProvider.of<UserBloc>(context).userRepository;

                  final group = Group(
                    name: groupNameController.text,
                    description: groupDescriptionController.text,
                  );

                  groupBLoc.add(GroupCreate(
                      group, (await userBloc.getCurrentUser()).token!));
                });
          }
        }));
  }

  Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: pickedImage != null
              ? FileImage(File(pickedImage!.path)) as ImageProvider<Object>?
              : const AssetImage('assets/profile.png'),
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
