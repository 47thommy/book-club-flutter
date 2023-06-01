import 'package:equatable/equatable.dart';

class Permission extends Equatable {
  final int id;
  final String name;

  const Permission({required this.id, required this.name});

  static const createPoll = Permission(id: 1, name: 'Create poll');
  static const deletePoll = Permission(id: 2, name: 'Delete poll');
  static const createMeeting = Permission(id: 3, name: 'Create meeting');
  static const modifyMeeting = Permission(id: 4, name: 'Modify meeting');
  static const createReadingList =
      Permission(id: 5, name: 'Create reading list');
  static const modifyReadingList =
      Permission(id: 6, name: 'Modify reading list');
  static const addMember = Permission(id: 7, name: 'Add member');
  static const removeMember = Permission(id: 8, name: 'Remove member');
  static const modifyGroup = Permission(id: 9, name: 'Modify group');
  static const deleteGroup = Permission(id: 10, name: 'Delete group');

  // for convenience
  static const all = [
    createPoll,
    deletePoll,
    createMeeting,
    modifyMeeting,
    createReadingList,
    modifyReadingList,
    addMember,
    removeMember,
    modifyGroup,
    deleteGroup
  ];

  @override
  List<Object?> get props => [id, name];
}
