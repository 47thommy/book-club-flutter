import 'package:client/application/file/file.dart';
import 'package:client/application/group/group.dart';
import 'package:client/presentation/pages/group/widgets/create_group_page.dart';
import 'package:client/presentation/pages/group/widgets/joined_groups_card.dart';
import 'package:client/presentation/pages/group/widgets/trending_groups_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  int _selectedIndex = 0;
  final icons = [const Icon(Icons.add), const Icon(Icons.chevron_left)];

  Widget trendingClubsBuilder(context) {
    return BlocConsumer<GroupBloc, GroupState>(listener: (context, state) {
      if (state is GroupCreated) {
        context.read<GroupBloc>().add(LoadGroups());
      }
    }, builder: (context, state) {
      // Show loading progress while loading groups
      if (state is GroupsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Show trending groups on success
      else if (state is GroupsFetchSuccess) {
        if (state.trendingGroups.isEmpty) {
          return const Center(
            child: Text('No groups'),
          );
        }

        return ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: state.trendingGroups
              .map((group) => TrendingClubCard(
                  title: group.name,
                  imageUrl: group.imageUrl,
                  description: group.description))
              .toList(),
        );
      }

      // Show error incase of failure
      else if (state is GroupOperationFailure) {
        return ErrorWidget(state.error.message);
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget joinedClubsBuilder(context) {
    return BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
      // Show loading progress while loading groups
      if (state is GroupsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      // Show joined groups on success
      else if (state is GroupsFetchSuccess) {
        if (state.joinedGroups.isEmpty) {
          return const Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Center(child: Text('You haven\'t joined any groups yet.')),
          );
        }

        return ListView(
          scrollDirection: Axis.vertical,
          children: state.joinedGroups
              .map((group) => JoinedClubCard(
                  title: group.name,
                  imageUrl: group.imageUrl,
                  description: group.description))
              .toList(),
        );
      }

      // Show error incase of failure
      else if (state is GroupOperationFailure) {
        return ErrorWidget(state.error.message);
      }

      return const LinearProgressIndicator();
    });
  }

  Widget buildBody(context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 12, 0, 12),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    //// TODO:  search
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Trending Clubs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 200, child: trendingClubsBuilder(context)),
            const Padding(
              padding:
                  EdgeInsets.only(top: 16.0, right: 16, left: 16, bottom: 16),
              child: Text(
                'Joined Clubs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * .4,
                child: joinedClubsBuilder(context)),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(">>");
    print(context.read<FileBloc>());
    return BlocListener<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state is GroupCreated) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Group created.",
                    style: TextStyle(color: Colors.green))));
            setState(() {
              _selectedIndex = 0;
            });
          } else if (state is GroupOperationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error.message,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.error))));
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              buildBody(context),
              const GroupDetailPage(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_selectedIndex == 1) {
                // createGroup();
              }
              setState(() {
                _selectedIndex += 1;
                _selectedIndex %= 2;
              });
            },
            child: icons[_selectedIndex],
          ),
        ));
  }
}
