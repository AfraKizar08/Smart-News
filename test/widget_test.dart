import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/main.dart'; // Ensure this path points to your main.dart file

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget( MyApp()); // Ensure `MyApp` matches your app's main widget.

    // Verify that the app starts with expected content.
    expect(find.text('News App'), findsOneWidget);
  });
}
