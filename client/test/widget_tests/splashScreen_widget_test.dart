import 'package:client/presentation/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SplashScreen should display logo', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );

    expect(find.byWidgetPredicate((widget) {
      if (widget is Image && widget.image is AssetImage) {
        final assetImage = widget.image as AssetImage;
        return assetImage.assetName == "assets/logo/logo.png";
      }
      return false;
    }), findsOneWidget);
  });

  testWidgets('SplashScreen should display title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );

    expect(find.text("Book club"), findsOneWidget);
    expect(find.text("Book club"), findsNWidgets(1));
  });
}
