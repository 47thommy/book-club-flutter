import 'package:flutter_test/flutter_test.dart';
import 'package:client/utils/failure.dart';
import 'package:client/application/signup/signup_state.dart';

void main() {
  group('SignupState', () {
    test('props of SignupInitial should be empty', () {
      final state = SignupInitial();
      expect(state.props, []);
    });

    test('props of SignupLoading should be empty', () {
      final state = SignupLoading();
      expect(state.props, []);
    });

    test('props of SignupFailure should contain error', () {
      const failure = Failure('Something went wrong');
      const state = SignupFailure(failure);
      expect(state.props, [failure]);
    });

    test('SignupFailure toString() should contain error message', () {
      const failure = Failure('Something went wrong');
      const state = SignupFailure(failure);
      expect(state.toString(), 'SignupFailure { error: $failure }');
    });
  });
}
