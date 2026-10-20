import 'package:flutter_test/flutter_test.dart';
import 'package:eduquest/main.dart';

void main() {
  testWidgets('EduQuest menampilkan halaman utama', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const EduQuestApp());

    expect(find.text('EduQuest'), findsOneWidget);
    expect(find.text('Learn, Play, and Grow!'), findsOneWidget);
    expect(find.text('Mulai Belajar'), findsOneWidget);
  });
}
