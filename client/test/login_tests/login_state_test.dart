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

  group('LoginLoading', () {
    test('props is empty', () {
      final state = LoginLoading();

      expect(state.props, isEmpty);
    });
  });

  group('LoginFailure', () {
    test('props contains error', () {
      const error = Failure('Something went wrong');
      const state = LoginFailure(error);

      expect(state.props, [error]);
    });
  });
}
