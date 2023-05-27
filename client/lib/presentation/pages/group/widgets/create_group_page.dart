import 'package:client/application/file/file.dart';
import 'package:client/application/group/group.dart';
import 'package:client/domain/groups/group_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void uploadImage() {
    final fileBloc = context.read<FileBloc>();
    fileBloc.add(UploadFile(File(pickedImage!.path)));
  }

  void createGroup(imageUrl) {
    final groupBloc = context.read<GroupBloc>();

    final newGroup = GroupDto(
        id: -1,
        name: groupNameController.text,
        description: groupDescriptionController.text,
        imageUrl: imageUrl);

    groupBloc.add(GroupCreate(newGroup));

    groupNameController.text = '';
    groupDescriptionController.text = '';
    pickedImage = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New club'),
        actions: [
          BlocConsumer<FileBloc, FileState>(
              // listener
              listener: (context, state) {
            // group image upload successfull, now create the group
            if (state is FileUploaded) {
              createGroup(state.url);
            }

            // upload failure
            else if (state is FileOperationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error.message,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error))));
            }
          },

              // builder
              builder: (context, state) {
            // image upload in progress
            if (state is FileUploading) {
              return MaterialButton(
                  onPressed: () {}, child: const CircularProgressIndicator());
            }

            return MaterialButton(
              onPressed: () {
                if (pickedImage != null) {
                  uploadImage();
                } else {
                  createGroup('');
                }
              },
              child: const Text('Create'),
            );
          })
        ],
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
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: pickedImage != null
              ? FileImage(File(pickedImage!.path)) as ImageProvider<Object>?
              : null,
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
