import 'package:flutter_test/flutter_test.dart';
import 'package:client/application/login/login_state.dart';
import 'package:client/utils/failure.dart';

void main() {
  group('LoginInitial', () {
    test('props is empty', () {
      final state = LoginInitial();

      expect(state.props, isEmpty);
    });
  });
}
