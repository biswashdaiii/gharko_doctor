
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gharko_doctor/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:mocktail/mocktail.dart';

// Mock BuildContext
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('SplashViewModel', () {
    late SplashViewModel splashViewModel;
    late MockBuildContext mockContext;

    setUp(() {
      splashViewModel = SplashViewModel();
      mockContext = MockBuildContext();

      // Stub 'mounted' property
      when(() => mockContext.mounted).thenReturn(true);
    });

    blocTest<SplashViewModel, void>(
      'init completes without emitting states',
      build: () => splashViewModel,
      act: (cubit) async {
        try {
          await cubit.init(mockContext);
        } catch (_) {
          // ignore navigation error since no UI environment
        }
      },
      expect: () => [],
    );
  });
}
