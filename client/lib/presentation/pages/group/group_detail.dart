import 'dart:developer';
import 'package:client/application/group/group.dart';
import 'package:client/domain/group/group.dart';
import 'package:client/domain/user/user.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/file/file_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:client/presentation/pages/group/group_settings.dart';
import 'package:client/presentation/pages/group/groups_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/presentation/pages/poll/poll_form.dart';
import 'package:client/presentation/pages/poll/polls_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/infrastructure/group/dto/group_mapper.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:client/domain/role/user_permission_validator.dart';
import 'package:go_router/go_router.dart';

class GroupDetailPage extends StatefulWidget {
  static const routeName = 'group-detail';

  final int gid;
  // final title = 'title';
  // final String picture = 'assets/group_default.png';
  // final int numberOfMembers = 10;
  // final List<RoleDto> memberRoles = ['a', 'b'];
  final bool isJoined = true;

  const GroupDetailPage({super.key, required this.gid});

  @override
  State<GroupDetailPage> createState() => _GroupDetailScreen();
}

class _GroupDetailScreen extends State<GroupDetailPage>
    with TickerProviderStateMixin {
  bool isClicked = false;
  late AnimationController buttonController;
  late Animation<double> buttonAnimation;

  @override
  void initState() {
    super.initState();
    buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    buttonAnimation = CurvedAnimation(
      parent: buttonController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }

  void toggleMenus() {
    setState(() {
      isClicked = !isClicked;
      if (isClicked) {
        buttonController.forward();
      } else {
        buttonController.reverse();
      }
    });
  }

  void handleOptionSelected(String option) {
    switch (option) {
      case 'create_poll':
        context.pushNamed(PollCreateScreen.routeName, pathParameters: {
          'gid': widget.gid.toString(),
        }).then((value) =>
            context.read<GroupBloc>().add(LoadGroupDetail(widget.gid)));
        break;

      case 'create_reading_list':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            // TODO: ReadingListForm()
            return const Text('reading form');
          }),
        );
        break;
      case 'schedule_meeting':
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => CreateScheduleForm()),
        // );
        break;
    }
    toggleMenus();
  }

  Widget inviteOrJoinButton(BuildContext context, User user, Group group) {
    final groupBloc = context.read<GroupBloc>();

    if (!user.isMember(group)) {
      return ElevatedButton(
        onPressed: () {
          groupBloc.add(GroupJoin(group.toGroupDto()));
        },
        child: const Text('Join'),
      );
    }

    if (user.hasInvitePermission(group)) {
      return ElevatedButton(
        onPressed: () {
          // groupBloc.add(GroupJoin(group.toGroupDto()));
        },
        child: const Text('Invite Members'),
      );
    }

    return const Text('');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GroupBloc(
            groupRepository: RepositoryProvider.of<GroupRepository>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context))
          ..add(LoadGroupDetail(widget.gid)),
        child: BlocConsumer<GroupBloc, GroupState>(
            //
            // Listner
            listener: (context, state) {
          // on group join or leave failure
          if (state is GroupOperationFailure) {
            showFailure(context, state.error.toString());
          }

          // on group join
          else if (state is GroupJoined) {
            showSuccess(context, 'Welcome to ${state.group.name}');
          }

          // on group leave
          else if (state is GroupLeaved) {
            showSuccess(context, 'You have left ${state.group.name}');
          }

          // on group edit
          else if (state is GroupUpdated) {
            showSuccess(context, 'Group updated.');
          }
        },
            //
            // builder
            builder: (context, state) {
          if (state is GroupDetailLoaded) {
            return buildBody(context, state.group);
          }

          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }));
  }

  Widget buildBody(BuildContext context, GroupDto group) {
    final fileRepository = context.read<FileRepository>();
    final user = context.read<UserRepository>().getLoggedInUserSync();

    final groupBloc = context.read<GroupBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        actions: user.isMember(group.toGroup())
            ? [
                //
                // Edit button
                if (user.hasGroupEditPermission(group.toGroup()))
                  GestureDetector(
                      onTap: () {
                        context.pushNamed(GroupEditPage.routeName,
                            pathParameters: {
                              'gid': widget.gid.toString()
                            }).then((value) => context
                            .read<GroupBloc>()
                            .add(LoadGroupDetail(widget.gid)));
                      },
                      child: const Padding(
                          padding: EdgeInsets.all(10),
                          //
                          child: Icon(Icons.edit))),

                //
                // for non creators show leave button
                if (group.creator.id != user.id)
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(
                          value: 'leave_group',
                          child: Row(children: [
                            Icon(Icons.heart_broken),
                            Text('Leave Group')
                          ]),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 'leave_group') {
                        groupBloc.add(GroupLeave(group));
                      }
                    },
                  ),
              ]
            : null,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: fileRepository.getFullUrl(group.imageUrl),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                    errorWidget: (contmainext, exception, stackTrace) {
                      return Image.asset(
                        'assets/group_default.png',
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      );
                    },
                    placeholder: (context, url) {
                      return Image.asset(
                        'assets/group_default.png',
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Group name / member count
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                group.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                group.members.length > 1
                                    ? '${group.members.length} Members'
                                    : '${group.members.length} Member',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          inviteOrJoinButton(context, user, group.toGroup()),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Members',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          if (widget.isJoined)
                            TextButton(
                              onPressed: () {
                                context.pushNamed(PollsList.routeName,
                                    pathParameters: {
                                      'gid': group.id.toString()
                                    });
                              },
                              child: const Text('Polls'),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: group.members.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${group.members[index].firstName} ${group.members[index].lastName}'),
                                Text(
                                  group.members[index].role.name,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                const SizedBox(width: 7.0),
                                Text(group.members[index].username),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isClicked)
            Positioned(
              bottom: 80.0,
              right: 16.0,
              child: Wrap(
                direction: Axis.vertical,
                spacing: 8.0,
                runSpacing: 8.0,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  if (user.hasPollCreatePermission(group.toGroup()))
                    buildOptions(
                      icon: Icons.poll,
                      label: 'Create Poll',
                      value: 'create_poll',
                    ),
                  buildOptions(
                    icon: Icons.calendar_today,
                    label: 'Schedule a Meeting',
                    value: 'schedule_meeting',
                  ),
                  buildOptions(
                    icon: Icons.menu_book_outlined,
                    label: 'Create a Reading List',
                    value: 'create_reading_list',
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: widget.isJoined
          ? FloatingActionButton(
              onPressed: toggleMenus,
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: buttonAnimation,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildOptions({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return GestureDetector(
      onTap: () => handleOptionSelected(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
