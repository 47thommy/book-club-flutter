import 'package:client/presentation/pages/group/group.dart';
import 'package:client/presentation/pages/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:client/presentation/pages/group/groups_screen.dart' as groups;
import 'package:client/main.dart' as app;

void main() {
  group('end to end test ', () {
    testWidgets('sign up', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1, milliseconds: 500));
      final signUpButton = find.byKey(Key("sign_up_button"));
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key("first_name")), 'john');
      await tester.enterText(find.byKey(Key("last_name")), 'doe');
      await tester.enterText(find.byKey(Key("user_name")), 'johndoe');
      await tester.enterText(find.byKey(Key("email_signup")), 'john@gmail.com');
      await tester.enterText(find.byKey(Key("password_signup")), 'John@2000');

      await tester.tap(find.byKey(Key('signup_signup')));
      await tester.pump();

      await tester.pumpAndSettle();
      expect(find.text('Creating your account...'), findsOneWidget);
    });

    testWidgets('login', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1, milliseconds: 500));

      await tester.enterText(find.byKey(Key("login_email")), 'john@gmail.com');
      await tester.enterText(find.byKey(Key("login_password")), 'John@2000');

      await tester.tap(find.byKey(Key('login_login')));
      await tester.pump();

      await tester.pumpAndSettle();
      expect(find.text('Logging in...'), findsOneWidget);

      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();
    });
    testWidgets('group create', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final floatingActionButtonFinder = find.byType(FloatingActionButton);

      await tester.tap(floatingActionButtonFinder);
      await tester.pumpAndSettle();

      final createGroupPageFinder = find.byType(GroupCreatePage);
      expect(createGroupPageFinder, findsOneWidget);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key("group_name")), 'group name');
      await tester.enterText(
          find.byKey(Key("group_description")), 'group description');

      await tester.tap(find.byKey(Key('group_create')));
      await tester.pump();
      await Future.delayed(const Duration(seconds: 2));
    });
  });
}
