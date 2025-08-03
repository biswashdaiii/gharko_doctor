import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/authentication/domain/entities/user_entity.dart';
import 'package:gharko_doctor/features/authentication/domain/repository/user_repository.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/register_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late UserRegisterUseCase usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UserRegisterUseCase(userRepository: mockUserRepository);

    // Needed because UserEntity has non-primitive equality
    registerFallbackValue(
      const UserEntity(
        userId: 'dummy',
        email: 'dummy@example.com',
        fullName: 'Dummy User',
        password: '123456',
      ),
    );
  });

  test('✅ should register user and return void on success', () async {
    // Arrange
    const params = RegisterUserParams(
      email: 'test@example.com',
      fullName: 'Test User',
      password: 'password123',
    );

    // Use any to match generated UUID
    when(() => mockUserRepository.registerUser(any()))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right(null));
    verify(() => mockUserRepository.registerUser(any())).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });

  test('❌ should return Failure when registration fails', () async {
    // Arrange
    const params = RegisterUserParams(
      email: 'test@example.com',
      fullName: 'Test User',
      password: 'password123',
    );
    final failure = RemoteDatabaseFailure(message: 'Email already exists');

    when(() => mockUserRepository.registerUser(any()))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Left(failure));
    verify(() => mockUserRepository.registerUser(any())).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}
