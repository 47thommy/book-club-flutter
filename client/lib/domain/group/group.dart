import 'package:client/domain/book/book.dart';
import 'package:client/domain/meeting/meeting.dart';
import 'package:client/domain/poll/poll.dart';
import 'package:client/domain/role/role.dart';
import 'package:client/domain/user/user.dart';
import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final User creator;
  final List<User> members;
  final List<Role> roles;
  final List<Poll> polls;
  final List<Book> books;
  final List<Meeting> meetings;

  static const empty = Group(
      id: -1,
      name: '',
      description: '',
      imageUrl: '',
      books: [],
      creator: User.empty,
      members: [],
      polls: [],
      roles: [],
      meetings: []);

  const Group({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.creator,
    required this.members,
    required this.roles,
    required this.polls,
    required this.books,
    required this.meetings,
  });

  @override
  List<Object?> get props =>
      [id, name, description, imageUrl, creator, members, roles];
}
