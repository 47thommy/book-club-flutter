import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:client/presentation/pages/group/widgets/joined_groups_card.dart';
import 'package:client/presentation/pages/group/widgets/trending_groups_card.dart';
import 'package:client/utils/either.dart';
import 'package:client/application/group/group_bloc.dart';
import 'package:client/application/group/group_event.dart';
import 'package:client/application/group/group_state.dart';
import 'package:client/infrastructure/group/group_repository.dart';
import 'package:client/infrastructure/user/user_repository.dart';
import 'package:client/utils/failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'group_bloc_test.mocks.dart'; // Import the generated mock classes

@GenerateMocks([
  GroupRepository,
  UserRepository,
])
void main() {
  late MockGroupRepository groupRepository;
  late MockUserRepository userRepository;
  late GroupBloc groupBloc;

  setUp(() {
    groupRepository = MockGroupRepository();
    userRepository = MockUserRepository();
    groupBloc = GroupBloc(
      groupRepository: groupRepository,
      userRepository: userRepository,
    );
  });

  group('GroupBloc', () {
    test('initial state is GroupsLoading', () {
      expect(groupBloc.state, isA<GroupsLoading>());
    });

    test('LoadGroups event emits GroupsFetchSuccess on success', () async {
      const trendingGroups = TrendingClubCard(
        group: GroupDto(
          id: 1,
          name: "name",
          description: "description",
          imageUrl: "imageUrl",
          creator: UserDto(
            id: 1,
            email: "email",
            username: "username",
            bio: "bio",
            imageUrl: "imageUrl",
            firstName: "firstName",
            lastName: "lastName",
          ),
          members: [],
          roles: [],
          polls: [],
          books: [],
        ),
      );
      const joinedGroups = JoinedClubCard(
        group: GroupDto(
          id: 1,
          name: "name",
          description: "description",
          imageUrl: "imageUrl",
          creator: UserDto(
            id: 1,
            email: "email",
            username: "username",
            bio: "bio",
            imageUrl: "imageUrl",
            firstName: "firstName",
            lastName: "lastName",
          ),
          members: [],
          roles: [],
          polls: [],
          books: [],
        ),
      );

      when(userRepository.getToken()).thenAnswer((_) async => 'token');
      when(groupRepository.getGroups('token'))
          .thenAnswer((_) async => Either(value: [trendingGroups.group]));
      when(groupRepository.getJoinedGroups('token'))
          .thenAnswer((_) async => Either(value: [joinedGroups.group]));

      final expectedStates = [
        GroupsLoading(),
        GroupsFetchSuccess(
          trendingGroups: [trendingGroups.group],
          joinedGroups: [joinedGroups.group],
        ),
      ];

      expectLater(groupBloc.stream, emitsInOrder(expectedStates));

      groupBloc.add(LoadGroups());
    });

    test('LoadGroups event emits GroupOperationFailure on error', () async {
      const failure = Failure('Failed to load groups');

      when(userRepository.getToken()).thenAnswer((_) async => 'token');
      when(groupRepository.getGroups('token'))
          .thenAnswer((_) async => Either(failure: failure));
      when(groupRepository.getJoinedGroups('token'))
          .thenAnswer((_) async => Either(failure: failure));

      final expectedStates = [
        GroupsLoading(),
        const GroupOperationFailure(failure),
      ];

      expectLater(groupBloc.stream, emitsInOrder(expectedStates));

      groupBloc.add(LoadGroups());
    });

    tearDown(() {
      groupBloc.close();
    });
  });
}
