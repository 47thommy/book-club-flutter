import 'package:client/group/blocs/blocs.dart';
import 'package:client/group/screens/group_details.dart';
import 'package:client/user/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12, 16, 12),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                ),
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
              SizedBox(
                height: 150,
                child: BlocBuilder<GroupBloc, GroupState>(
                    builder: ((context, state) {
                  if (state is GroupsLoaded) {
                    return ListView(
                        scrollDirection: Axis.horizontal,
                        children: state.groups.map((club) {
                          return TrendingClubCard(
                            title: club.name!,
                            picture: club.creator!.firstName!,
                            description: club.description!,
                          );
                        }).toList());
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Joined Clubs',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: BlocBuilder<GroupBloc, GroupState>(
                    builder: ((context, state) {
                  if (state is GroupsLoaded) {
                    final joinedGroups = state.joinedGroups
                        .map((group) => JoinedClubCard(
                            title: group.name!,
                            picture: group.creator!.firstName!,
                            description: group.description!))
                        .toList();
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.groups.length,
                      itemBuilder: (context, index) {
                        return joinedGroups[index];
                      },
                    );
                  }
                  return const Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                })),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.group_add),
          onPressed: () {
            context.push("/${GroupDetailPage.routeName}");
          }),
    );
  }
}

class TrendingClubCard extends StatelessWidget {
  final String title;
  final String picture;
  final String description;

  const TrendingClubCard({
    Key? key,
    required this.title,
    required this.picture,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              picture,
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JoinedClubCard extends StatelessWidget {
  final String title;
  final String picture;
  final String description;

  const JoinedClubCard({
    Key? key,
    required this.title,
    required this.picture,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              picture,
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
