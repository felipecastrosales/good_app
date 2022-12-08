import 'package:flutter_test/flutter_test.dart';

import 'package:good_app/app.dart';

void main() {
  testWidgets('Should Renders App', (WidgetTester tester) async {
    await tester.pumpWidget(
      const App(),
    );
  });
}
