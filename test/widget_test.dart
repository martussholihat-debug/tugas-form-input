
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_form_input/main.dart';

void main() {
  testWidgets('Aplikasi SIAKAD dapat dibuka', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(MyApp), findsOneWidget);
  });
}
