import 'package:client/presentation/pages/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('showFailure displays SnackBar with error message',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  showFailure(context, 'An error occurred');
                },
                child: const Text('Show Failure'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Failure'));
    await tester.pumpAndSettle();

    expect(find.text('An error occurred'), findsOneWidget);
  });
}
