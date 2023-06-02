import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/application/file/file.dart';
import 'package:client/application/group/group.dart';
import 'package:client/domain/role/role.dart';
import 'package:client/domain/role/user_permission_validator.dart';
import 'package:client/infrastructure/file/file_repository.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/infrastructure/group/dto/group_mapper.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:client/presentation/pages/group/group_detail.dart';
import 'package:client/presentation/pages/roles_permissions/role_detail.dart';
import 'package:client/presentation/pages/roles_permissions/widgets/role_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GroupEditPage extends StatefulWidget {
  static const routeName = 'group-edit';

  final int gid;

  const GroupEditPage({super.key, required this.gid});

  @override
  State<GroupEditPage> createState() => _GroupEditPageState();
}

class _GroupEditPageState extends State<GroupEditPage> {
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
    fileBloc
        .add(UploadFile(file: File(pickedImage!.path), reason: 'Group Update'));
  }

  void updateGroup(
      BuildContext context, String? imageUrl, GroupDto oldGroup) async {
    final groupBloc = context.read<GroupBloc>();

    final newGroup = GroupDto(
        id: widget.gid,
        name: groupNameController.text,
        description: groupDescriptionController.text,
        imageUrl: imageUrl ?? oldGroup.imageUrl,
        creator: UserDto.empty,
        members: [],
        roles: [],
        polls: [],
        books: [],
        meetings: []);

    groupBloc.add(GroupUpdate(newGroup));

    groupNameController.text = '';
    groupDescriptionController.text = '';
    pickedImage = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GroupBloc(
            groupRepository: RepositoryProvider.of<GroupRepository>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context))
          ..add(LoadGroupDetail(widget.gid)),

        //
        child: BlocConsumer<GroupBloc, GroupState>(
            // listener
            listener: (context, state) {
          if (state is GroupUpdated || state is GroupOperationFailure) {
            context.pop();
          }
        },

            // builder
            builder: (context, state) {
          if (state is GroupDetailLoaded) {
            groupNameController.text = state.group.name;
            groupDescriptionController.text = state.group.description;

            return Scaffold(
                appBar: AppBar(
                  title: Text(state.group.name),
                  actions: [
                    BlocConsumer<FileBloc, FileState>(
                        // listener
                        listener: (context, fileState) {
                      // group image upload successfull, now update the group
                      if (fileState is FileUploaded &&
                          fileState.reason == 'Group Update') {
                        updateGroup(context, fileState.url, state.group);
                      }

                      // upload failure
                      else if (fileState is FileOperationFailure) {
                        showFailure(context, fileState.error.toString());
                      }
                    },

                        // builder
                        builder: (context, fileState) {
                      // image upload in progress
                      if (fileState is FileUploading) {
                        return MaterialButton(
                            onPressed: () {},
                            child: const CircularProgressIndicator());
                      }

                      return MaterialButton(
                        onPressed: () {
                          if (pickedImage != null) {
                            uploadImage();
                          } else {
                            updateGroup(context, null, state.group);
                          }
                        },
                        child: const Text('Save'),
                      );
                    })
                  ],
                ),
                body: ListView(
                  padding: const EdgeInsets.all(20.0),
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        //
                        // Group image picker
                        _buildProfileImage(state.group),
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

                    //
                    // Group description
                    const SizedBox(height: 30),
                    const Text(
                      'About group',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 400,
                      controller: groupDescriptionController,
                    ),

                    //
                    // Group roles [Only visible for group creator]
                    // ----------------------------------------------------------------------------------------
                    // <GroupOwnerOnly> [START]
                    // ----------------------------------------------------------------------------------------
                    if (context
                            .read<UserRepository>()
                            .getLoggedInUserSync()
                            .id ==
                        state.group.creator.id) ...[
                      const SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Roles',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .pushNamed(RoleDetailPage.routeName,
                                        queryParameters: {'create': 'true'},
                                        pathParameters: {
                                          'gid': widget.gid.toString(),
                                        },
                                        extra: RoleDto.empty)
                                    .then((value) => context
                                        .read<GroupBloc>()
                                        .add(LoadGroupDetail(widget.gid)));
                              },
                              icon: const Icon(Icons.add),
                            )
                          ]),

                      // Roles list
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.group.roles.length,
                        itemBuilder: (context, index) {
                          return RoleCard(
                              state.group.roles[index], state.group.id);
                        },
                      ),
                    ],
                    // ----------------------------------------------------------------------------------------
                    // <GroupOwnerOnly> [END]
                    // ----------------------------------------------------------------------------------------

//
                    //
                    // Delete and leave button
                    if (context
                        .read<UserRepository>()
                        .getLoggedInUserSync()
                        .hasGroupDeletePermission(state.group.toGroup()))
                      MaterialButton(
                          onPressed: () {},
                          color: Theme.of(context).colorScheme.error,
                          child: const Text(
                            'Delete and leave group',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                  ],
                ));
          }

          return const Center(child: CircularProgressIndicator());
        }));
  }

  Widget _buildProfileImage(GroupDto group) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: context.read<FileRepository>().getFullUrl(group.imageUrl),
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
