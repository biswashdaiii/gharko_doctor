import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gharko_doctor/features/authentication/presentation/view/signin_screen.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_event.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_state.dart';
import 'package:gharko_doctor/features/authentication/presentation/view_model/sigin_view_model/login_view_model.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginViewModel extends MockBloc<SigninEvent, SigninState>
    implements LoginViewModel {}

void main() {
  late MockLoginViewModel mockLoginViewModel;
  late BuildContext dummyContext;

  Future<void> _registerFallbackWithContext(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            dummyContext = context; // capture BuildContext here
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    registerFallbackValue(
      LoginWithEmailAndPasswordEvent(
        context: dummyContext,
        email: '',
        password: '',
      ),
    );
  }

  setUp(() {
    mockLoginViewModel = MockLoginViewModel();

    whenListen(
      mockLoginViewModel,
      Stream.fromIterable([
        const SigninState(isLoading: false, isSuccess: false),
      ]),
      initialState: const SigninState(isLoading: false, isSuccess: false),
    );
  });

  group('LoginScreen simple tests', () {
    testWidgets('shows AppBar with title "Login"', (tester) async {
      await _registerFallbackWithContext(tester);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginViewModel>.value(
            value: mockLoginViewModel,
            child: LoginScreen(),
          ),
        ),
      );

      // Find "Login" text inside the AppBar only
      final appBarTitleFinder = find.descendant(
        of: find.byType(AppBar),
        matching: find.text('Login'),
      );

      expect(appBarTitleFinder, findsOneWidget);
    });

    testWidgets(
      'dispatches LoginWithEmailAndPasswordEvent when Login is tapped',
      (tester) async {
        await _registerFallbackWithContext(tester);

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<LoginViewModel>.value(
              value: mockLoginViewModel,
              child: LoginScreen(),
            ),
          ),
        );

        await tester.enterText(
          find.byType(TextFormField).at(0),
          'test@example.com',
        );
        await tester.enterText(find.byType(TextFormField).at(1), 'password123');

        await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
        await tester.pump();

        verify(
          () => mockLoginViewModel.add(
            any(
              that: predicate<LoginWithEmailAndPasswordEvent>(
                (event) =>
                    event.email == 'test@example.com' &&
                    event.password == 'password123',
              ),
            ),
          ),
        ).called(1);
      },
    );
  });
}
