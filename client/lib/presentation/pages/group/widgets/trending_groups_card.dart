import 'package:client/application/group/group.dart';
import 'package:client/infrastructure/file/file_repository.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/presentation/pages/group/group_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TrendingClubCard extends StatelessWidget {
  final GroupDto group;

  const TrendingClubCard({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fileRepository = context.read<FileRepository>();

    return GestureDetector(
      //
      // Navigate to details page
      onTap: () {
        context.pushNamed(GroupDetailPage.routeName, pathParameters: {
          'gid': group.id.toString()
        }).then((value) => context.read<GroupBloc>().add(LoadGroups()));
      },

      // Card
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(top: 8.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    fileRepository.getFullUrl(group.imageUrl),
                    fit: BoxFit.fill,
                    errorBuilder: (context, exception, stackTrace) {
                      return Image.asset('assets/group_default.png');
                    },
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                )),
            const SizedBox(height: 14.0),
            Text(
              group.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6.0),
            SizedBox(
              height: 32,
              child: Text(
                group.description,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                    overflow: TextOverflow.fade),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
