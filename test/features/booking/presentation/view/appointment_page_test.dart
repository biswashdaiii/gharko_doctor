import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gharko_doctor/features/booking/presentation/view/appointment_page.dart';
import 'package:gharko_doctor/features/booking/presentation/view_model/appointment_bloc.dart';
import 'package:gharko_doctor/features/booking/presentation/view_model/appointment_event.dart';
import 'package:gharko_doctor/features/booking/presentation/view_model/appointment_state.dart';
import 'package:mocktail/mocktail.dart';

class MockAppointmentBloc extends Mock implements AppointmentBloc {}

void main() {
  late MockAppointmentBloc mockBloc;

  setUp(() {
    mockBloc = MockAppointmentBloc();
  });

  Widget createTestWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<AppointmentBloc>.value(
        value: mockBloc,
        child: child,
      ),
    );
  }

  testWidgets('renders AppointmentPage with doctor info and book button',
      (WidgetTester tester) async {
    // Arrange
    final selectedDate = DateTime.now().add(Duration(days: 1));
    final selectedTime = '10:00 AM';

    when(() => mockBloc.state).thenReturn(
      AppointmentState(
        selectedDate: selectedDate,
        selectedTimeSlot: selectedTime,
      ),
    );

    // Act
    await tester.pumpWidget(
      createTestWidget(AppointmentPage(
        doctorId: 'doc1',
        doctorName: 'Dr. Test',
        specialty: 'Cardiology',
        experienceYears: 5,
        about: 'Test doctor bio',
        fee: 50.0,
        doctorImageUrl: 'https://example.com/image.jpg',
      )),
    );

    await tester.pumpAndSettle();

    // Assert UI renders
    expect(find.text('Dr. Test'), findsOneWidget);
    expect(find.text('Book Now'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Tap Book Now button
    await tester.tap(find.text('Book Now'));
    await tester.pump();

    // You can also verify the bloc was called using mocktail:
    verify(() => mockBloc.add(any(that: isA<BookAppointment>()))).called(1);
  });
}
