import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/login_usecase.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_event.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_state.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_view_model.dart';
import 'package:mocktail/mocktail.dart';

// Mock UserLoginUsecase
class MockUserLoginUsecase extends Mock implements UserLoginUsecase {}

// Fake for SigninEvent (needed for mocktail)
class FakeSigninEvent extends Fake {}

// *** ADD THIS: Fake for LoginUsecaseParams ***
class FakeLoginUsecaseParams extends Fake implements LoginUsecaseParams {}

void main() {
  late MockUserLoginUsecase mockUserLoginUsecase;
  late LoginViewModel loginViewModel;
  late BuildContext dummyContext;

  Future<void> setupDummyContext(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            dummyContext = context;
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(FakeSigninEvent());
    registerFallbackValue(FakeLoginUsecaseParams());  // Register fake LoginUsecaseParams
  });

  setUp(() {
    mockUserLoginUsecase = MockUserLoginUsecase();
    loginViewModel = LoginViewModel(mockUserLoginUsecase);
  });

  tearDown(() {
    loginViewModel.close();
  });

  group('LoginViewModel', () {
    testWidgets('dummy context setup', (tester) async {
      await setupDummyContext(tester);
      expect(dummyContext, isNotNull);
    });

    blocTest<LoginViewModel, SigninState>(
      'emits [loading, success] and adds NavigateToHomeViewEvent when login succeeds',
      build: () => loginViewModel,
      setUp: () {
        when(() => mockUserLoginUsecase.call(any())).thenAnswer(
          (_) async => const Right('dummy_token'),
        );
      },
      act: (bloc) async {
        await Future.delayed(Duration.zero);
        bloc.add(LoginWithEmailAndPasswordEvent(
          context: dummyContext,
          email: 'test@example.com',
          password: 'password123',
        ));
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const SigninState(isLoading: true, isSuccess: false),
        const SigninState(isLoading: false, isSuccess: true),
      ],
      verify: (bloc) {
        verify(() => mockUserLoginUsecase.call(any())).called(1);
      },
    );

    // blocTest<LoginViewModel, SigninState>(
    //   'emits [loading, failure] when login fails',
    //   build: () => loginViewModel,
    //   setUp: () {
    //     when(() => mockUserLoginUsecase.call(any())).thenAnswer(
    //       (_) async => Left(RemoteDatabaseFailure(message: 'Invalid credentials')),
    //     );
    //   },
    //   act: (bloc) async {
    //     await Future.delayed(Duration.zero);
    //     bloc.add(LoginWithEmailAndPasswordEvent(
    //       context: dummyContext,
    //       email: 'test@example.com',
    //       password: 'wrongpassword',
    //     ));
    //   },
    //   wait: const Duration(milliseconds: 100),
    //   expect: () => [
    //     const SigninState(isLoading: true, isSuccess: false),
    //     const SigninState(isLoading: false, isSuccess: false),
    //   ],
    //   verify: (bloc) {
    //     verify(() => mockUserLoginUsecase.call(any())).called(1);
    //   },
    // );
  });
}
