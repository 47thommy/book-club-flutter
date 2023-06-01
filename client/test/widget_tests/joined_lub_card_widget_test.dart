// Generate the mocks
import 'package:client/application/group/group.dart';
import 'package:client/infrastructure/file/file_repository.dart';
import 'package:client/infrastructure/group/dto/group_dto.dart';
import 'package:client/infrastructure/user/dto/dto.dart';
import 'package:client/presentation/pages/group/widgets/joined_groups_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'joined_lub_card_widget_test.mocks.dart';

@GenerateMocks([GroupBloc, FileRepository])
void main() {
  late MockGroupBloc mockGroupBloc;
  late MockFileRepository mockFileRepository;

  setUp(() {
    // Initialize the mock dependencies
    mockGroupBloc = MockGroupBloc();
    mockFileRepository = MockFileRepository();
  });

  testWidgets('JoinedClubCard widget displays correctly',
      (WidgetTester tester) async {
    // Create a mock GroupDto
    final mockGroup = GroupDto(
      id: 1,
      name: 'Mock Group',
      description: 'Mock description',
      imageUrl: 'mock_image_url',
      books: [],
      creator: UserDto(
          id: 1,
          email: "email",
          username: "username",
          bio: "bio",
          imageUrl: "imageUrl",
          firstName: "firstName",
          lastName: "lastName"),
      members: [],
      polls: [],
      roles: [],
    );

    // Provide the mock dependencies to the widget
    when(mockFileRepository.getFullUrl('mock_image_url'))
        .thenReturn('mock_full_url');

    // Wrap the JoinedClubCard widget with a MultiBlocProvider
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<GroupBloc>.value(value: mockGroupBloc),
              ],
              child: JoinedClubCard(
                group: mockGroup,
              ),
            ),
          ),
        ),
      ),
    );

    // Verify that the widget displays the correct data
    expect(find.text('Mock Group'), findsOneWidget);
    expect(find.text('Mock description'), findsOneWidget);

    // Verify that the CachedNetworkImage is called with the correct imageUrl
    verify(mockFileRepository.getFullUrl('mock_image_url')).called(1);
  });
}
