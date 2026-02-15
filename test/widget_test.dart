import 'package:flutter_test/flutter_test.dart';
import 'package:learnflow_ai/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LearnFlowApp());
    expect(find.text('LearnFlow AI'), findsOneWidget);
  });
}
