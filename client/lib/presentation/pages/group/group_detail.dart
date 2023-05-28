import 'package:client/application/group/group.dart';
import 'package:client/domain/auth/user_role.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/groups/group_dto.dart';

class GroupDetailScreen extends StatefulWidget {
  static const routeName = 'group-detail';

  final int gid;
  // final title = 'title';
  // final String picture = 'assets/group_default.png';
  // final int numberOfMembers = 10;
  // final List<RoleDto> memberRoles = ['a', 'b'];
  final bool isJoined = true;

  const GroupDetailScreen({super.key, required this.gid});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreen();
}

class _GroupDetailScreen extends State<GroupDetailScreen>
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              // TODO: PollForm();
              return Text('Poll form');
            },
          ),
        );
        break;

      case 'create_reading_list':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            // TODO: ReadingListForm()
            return Text('reading form');
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupBloc>(create: (context) {
      return GroupBloc(
          // repos
          userRepository: context.read<UserRepository>(),
          groupRepository: context.read<GroupRepository>())
        ..add(LoadGroupDetail(widget.gid));
    }, child: BlocBuilder<GroupBloc, GroupState>(
        // builder
        builder: (context, state) {
      if (state is GroupDetailLoaded) {
        return buildBody(state.group);
      }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }));
  }

  Widget buildBody(GroupDto group) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        actions: widget.isJoined
            ? [
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'leave_group',
                        child: Text('Leave Group'),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 'leave_group') {
                      // // TODO:  leave group
                    }
                  },
                ),
              ]
            : null,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      group.imageUrl,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    group.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Number of Members: ${group.members.length}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.isJoined) {
                        // // TODO:  join
                      } else {
                        // // TODO:  invite
                      }
                    },
                    child: Text(
                      widget.isJoined ? 'Invite Members' : 'Join Club',
                    ),
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
                            // Handle button click
                            // // TODO:  polls
                          },
                          child: const Text('Polls'),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: group.members.length,
                    itemBuilder: (context, index) {
                      final String memberRole =
                          index == 0 ? "creator" : "member";
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Member ${index + 1}'),
                            Text(
                              memberRole,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        subtitle: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("531"),
                            SizedBox(width: 4.0),
                            Icon(
                              Icons.menu_book_outlined,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          if (isClicked)
            Positioned(
              bottom: 110.0,
              right: 16.0,
              child: Wrap(
                direction: Axis.vertical,
                spacing: 8.0,
                runSpacing: 8.0,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  buildOptions(
                    icon: Icons.poll,
                    label: 'Create Poll',
                    value: 'create_poll',
                  ),
                  buildOptions(
                    icon: Icons.menu_book_outlined,
                    label: 'Create a Reading List',
                    value: 'create_reading_list',
                  ),
                  buildOptions(
                    icon: Icons.calendar_today,
                    label: 'Schedule a Meeting',
                    value: 'schedule_meeting',
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
