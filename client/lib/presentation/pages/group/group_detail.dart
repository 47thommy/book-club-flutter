import 'dart:developer';
import 'package:client/application/group/group.dart';
import 'package:client/application/role/role_bloc.dart';
import 'package:client/application/role/role_event.dart';
import 'package:client/application/role/role_state.dart';
import 'package:client/domain/group/group.dart';
import 'package:client/domain/role/role.dart';
import 'package:client/domain/user/user.dart';
import 'package:client/infrastructure/book/dto/book_dto.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/file/file_repository.dart';
import 'package:client/infrastructure/role/dto/role_dto.dart';
import 'package:client/infrastructure/role/dto/role_mapper.dart';
import 'package:client/infrastructure/role/role_repository.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/presentation/pages/books/book_detail.dart';
import 'package:client/presentation/pages/books/book_list.dart';
import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:client/presentation/pages/group/group_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/presentation/pages/meeting/create_meeting.dart';
import 'package:client/presentation/pages/meeting/meeting_list.dart';
import 'package:client/presentation/pages/poll/poll_form.dart';
import 'package:client/presentation/pages/poll/polls_list.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/infrastructure/group/dto/group_mapper.dart';
import 'package:client/domain/role/user_permission_validator.dart';
import 'package:client/presentation/pages/roles_permissions/role_assign.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GroupDetailPage extends StatefulWidget {
  static const routeName = 'group-detail';

  final int gid;

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
  Offset _tapPosition = Offset.zero;
  bool _managePermission = false;

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
        context
            .pushNamed(BookDescription.routeName,
                pathParameters: {
                  'gid': widget.gid.toString(),
                },
                extra: const BookDto(
                    id: 1,
                    title: 'title',
                    author: 'author',
                    description: 'description',
                    pageCount: 123,
                    genre: 'genre'))
            .then((value) =>
                context.read<GroupBloc>().add(LoadGroupDetail(widget.gid)));
        break;

      case 'schedule_meeting':
        context.pushNamed(CreateScheduleForm.routeName, pathParameters: {
          'gid': widget.gid.toString(),
        }).then((value) =>
            context.read<GroupBloc>().add(LoadGroupDetail(widget.gid)));
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

          // on group member removed
          else if (state is GroupMemberRemoved) {
            showSuccess(context, 'Member removed.');
          }

          // on group member added
          else if (state is GroupMemeberAdded) {
            showSuccess(context, 'New member added.');
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
            return BlocProvider(
                create: (context) => RoleBloc(
                    roleRepository: context.read<RoleRepository>(),
                    userRepository: context.read<UserRepository>()),

                //
                child: BlocListener<RoleBloc, RoleState>(
                    listener: (context, roleState) {
                      // on role assign success
                      if (roleState is RoleOperationFailure) {
                        showFailure(context, roleState.error.toString());
                        setState(() {
                          _managePermission = false;
                        });
                      }

                      // on group join
                      else if (roleState is RoleAssigned) {
                        showSuccess(context, 'Role changed');
                        setState(() {
                          _managePermission = false;
                        });
                        context
                            .read<GroupBloc>()
                            .add(LoadGroupDetail(state.group.id));
                      }
                    },
                    child: buildBody(context, state.group)));
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
                // show options if user has joined the group
                if (widget.isJoined)
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuItem>[
                        //
                        // books button
                        const PopupMenuItem(
                          value: 'books',
                          child: Row(children: [
                            Icon(
                              Icons.book,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 10),
                            Text('Books'),
                          ]),
                        ),

                        //
                        // polls button
                        const PopupMenuItem(
                          value: 'polls',
                          child: Row(children: [
                            Icon(
                              Icons.poll,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 10),
                            Text('Polls'),
                          ]),
                        ),

                        //
                        // polls button
                        const PopupMenuItem(
                          value: 'meetings',
                          child: Row(children: [
                            Icon(
                              Icons.schedule,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 10),
                            Text('Meetings'),
                          ]),
                        ),

                        // leave button
                        // for non creators show leave button
                        if (group.creator.id != user.id)
                          const PopupMenuItem(
                            value: 'leave_group',
                            child: Row(children: [
                              Icon(Icons.logout, color: Colors.red),
                              SizedBox(width: 10),
                              Text('Leave Group',
                                  style: TextStyle(color: Colors.red)),
                            ]),
                          ),
                      ];
                    },

                    // actions
                    onSelected: (value) {
                      switch (value) {
                        case 'leave_group':
                          groupBloc.add(GroupLeave(group));
                          break;

                        case 'polls':
                          context.pushNamed(PollsList.routeName,
                              pathParameters: {'gid': group.id.toString()});
                          break;

                        case 'books':
                          context.pushNamed(ReadingListScreen.routeName,
                              pathParameters: {'gid': group.id.toString()});
                          break;

                        case 'meetings':
                          context.pushNamed(ScheduleListPage.routeName,
                              pathParameters: {'gid': group.id.toString()});
                          break;
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

                      // members title
                      const SizedBox(height: 16.0),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //
                                const Text(
                                  'Members',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),

                                // Edit permission
                                if (user.id == group.creator.id)
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _managePermission =
                                              !_managePermission;
                                        });
                                      },
                                      child: _managePermission
                                          ? const Icon(Icons.save)
                                          : const Icon(Icons.edit)),
                              ])),

                      // members list
                      const SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: group.members.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTapDown: (details) => _storePosition(details),
                              onLongPress: () {
                                if (group.members[index].id !=
                                    group.creator.id) {
                                  _showPopupMenu(
                                      context,
                                      group.members[index].toUser(),
                                      group.toGroup());
                                }
                              },

                              //
                              // Member
                              child: ListTile(
                                // avatar
                                leading: CircleAvatar(
                                    child: CachedNetworkImage(
                                  imageUrl: fileRepository.getFullUrl(
                                      group.members[index].imageUrl),
                                  fit: BoxFit.fill,
                                  errorWidget:
                                      (context, exception, stackTrace) {
                                    return const Icon(Icons.person);
                                  },
                                  placeholder: (context, url) {
                                    return const Icon(Icons.person);
                                  },
                                )),

                                // name
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${group.members[index].firstName} ${group.members[index].lastName}'),

                                    //
                                    if (!_managePermission)
                                      Text(
                                        group.members[index].role.name,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    if (_managePermission &&
                                        group.members[index].id !=
                                            group.creator.id &&
                                        group.roles.length >= 3)
                                      DropdownManagePermission(
                                          group.roles,
                                          group.members[index].toUser(),
                                          group.toGroup())
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
                              ));
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
                  if (user.hasScheduleCreatePermission(group.toGroup()))
                    buildOptions(
                      icon: Icons.calendar_today,
                      label: 'Schedule a Meeting',
                      value: 'schedule_meeting',
                    ),
                  if (user.hasReadingListCreatePermission(group.toGroup()))
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
      floatingActionButton: user.hasPollCreatePermission(group.toGroup()) ||
              (user.hasScheduleCreatePermission(group.toGroup())) ||
              (user.hasReadingListCreatePermission(group.toGroup()))
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

  Future<void> _showPopupMenu(
      BuildContext context, User member, Group group) async {
    final user = context.read<UserRepository>().getLoggedInUserSync();

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
          _tapPosition & const Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size // Bigger rect, the entire screen
          ),
      items: [
        //

        //
        if (user.hasMemberRemovePermission(group) && user.id != member.id)
          PopupMenuItem(
            onTap: () {
              context
                  .read<GroupBloc>()
                  .add(GroupRemoveMember(member.id, group.toGroupDto()));
            },
            child: const Text("Remove from group"),
          ),
        //
        if (user.id == member.id)
          PopupMenuItem(
            onTap: () {
              context.read<GroupBloc>().add(GroupLeave(group.toGroupDto()));
            },
            child: const Text("Leave"),
          ),
      ],
      elevation: 8.0,
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
}

class DropdownManagePermission extends StatefulWidget {
  final List<RoleDto> list;
  final User user;
  final Group group;

  const DropdownManagePermission(this.list, this.user, this.group, {super.key});

  @override
  State<DropdownManagePermission> createState() =>
      _DropdownManagePermissionState();
}

class _DropdownManagePermissionState extends State<DropdownManagePermission> {
  late RoleDto role;
  bool _loading = false;

  @override
  void initState() {
    role = widget.list[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var items = <DropdownMenuItem<RoleDto>>[];

    for (var role in widget.list) {
      if (role.name != Role.owner) {
        items.add(DropdownMenuItem<RoleDto>(
          value: role,
          child: Text(role.name),
        ));
      }
    }

    if (_loading) return const Center(child: CircularProgressIndicator());

    return DropdownButton<RoleDto>(
      value: role,
      elevation: 16,
      onChanged: (RoleDto? value) {
        // This is called when the user selects an item.
        setState(() {
          role = value!;
          _loading = true;
        });

        context
            .read<RoleBloc>()
            .add(RoleAssign(value!.toRole(), widget.user, widget.group.id));
      },
      items: items,
    );
  }
}
