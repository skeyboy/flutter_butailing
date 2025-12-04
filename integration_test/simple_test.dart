import 'package:flutter_test/flutter_test.dart';
// ignore: unused_import
import 'package:flutter_butailing/main.dart';
import 'package:flutter_butailing/src/rust/frb_generated.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async => await RustLib.init());
  testWidgets('Can call rust function', (WidgetTester tester) async {
    // await tester.pumpWidget(const MyApp());
    // expect(find.textContaining('Result: `Hello, Tom!`'), findsOneWidget);
  });
}
