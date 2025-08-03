import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gharko_doctor/app/service_locator/service_locator.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/login_usecase.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_view_model.dart';
import 'package:gharko_doctor/features/splash/presentation/view/splash_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockUserLoginUsecase extends Mock implements UserLoginUsecase {}

void main() {
  setUpAll(() {
    final mockLoginUsecase = MockUserLoginUsecase();

    if (!serviceLocator.isRegistered<UserLoginUsecase>()) {
      serviceLocator.registerSingleton<UserLoginUsecase>(mockLoginUsecase);
    }

    if (!serviceLocator.isRegistered<LoginViewModel>()) {
      serviceLocator.registerFactory<LoginViewModel>(
        () => LoginViewModel(serviceLocator<UserLoginUsecase>()),
      );
    }
  });

  testWidgets(
    'SplashScreenView displays UI and navigates to LoginScreen after 3 seconds',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<LoginViewModel>(
          create: (_) => serviceLocator<LoginViewModel>(),
          child: const MaterialApp(
            home: SplashScreenView(),
          ),
        ),
      );

      // Verify splash screen
      expect(find.text('Gharko Doctor'), findsOneWidget);

      // Wait 3 seconds + settle frames
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Confirm navigation
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(SplashScreenView), findsNothing);
    },
  );
}
