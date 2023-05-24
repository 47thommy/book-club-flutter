import 'package:client/group/data_providers/local_group_provider.dart';
import 'package:client/group/data_providers/remote_group_provider.dart';
import 'package:client/group/models/group.dart';

class GroupRepository {
  final remoteProvider = RemoteGroupProvider();
  final localProvider = LocalGroupProvider();

  Future<List<Group>> fetchAll(String authToken) async {
    return remoteProvider.fetchAll(authToken);
  }

  Future<List<Group>> fetchJoinedGroups(String authToken) async {
    return remoteProvider.fetchJoinedGroups(authToken);
  }

  Future<Group> create(Group group, String authToken) async {
    return remoteProvider.create(group, authToken);
  }
}
