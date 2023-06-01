import 'dart:developer';

import 'package:client/domain/role/permission.dart';
import 'package:client/domain/role/role.dart';
import 'package:client/domain/group/group.dart';
import 'package:client/domain/user/user.dart';

extension UserPermission on User {
  bool isMember(Group group) {
    for (var member in group.members) {
      if (member.id == id) return true;
    }
    return false;
  }

  Role getUserRole(Group group) {
    return group.members
        .firstWhere((member) => member.id == id, orElse: () => User.empty)
        .role;
  }

  bool hasPermission(Group group, Permission permission) {
    final userRole = getUserRole(group);

    for (var userPermission in userRole.permissions) {
      if (userPermission == permission) {
        return true;
      }
    }

    return false;
  }

  bool hasInvitePermission(Group group) =>
      hasPermission(group, Permission.addMember);

  bool hasMemberRemovePermission(Group group) =>
      hasPermission(group, Permission.removeMember);

  bool hasGroupDeletePermission(Group group) =>
      hasPermission(group, Permission.deleteGroup);

  bool hasGroupEditPermission(Group group) =>
      hasPermission(group, Permission.modifyGroup);

  bool hasScheduleCreatePermission(Group group) =>
      hasPermission(group, Permission.createMeeting);

  bool hasPollCreatePermission(Group group) =>
      hasPermission(group, Permission.createPoll);

  bool hasPollDeletePermission(Group group) =>
      hasPermission(group, Permission.deletePoll);
}
