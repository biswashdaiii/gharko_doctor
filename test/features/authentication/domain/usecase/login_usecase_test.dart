import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gharko_doctor/core/error/failure.dart';
import 'package:gharko_doctor/features/authentication/domain/repository/user_repository.dart';
import 'package:gharko_doctor/features/authentication/domain/usecase/login_usecase.dart';
// import 'package:gharko_doctor/features/authentication/domain/usecases/user_login_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late UserLoginUsecase usecase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    usecase = UserLoginUsecase(userRepository: mockUserRepository);

    // Fallback value for LoginUsecaseParams
    registerFallbackValue(const LoginUsecaseParams(email: '', password: ''));
  });

  test('✅ should return token when login is successful', () async {
    // Arrange
    const params = LoginUsecaseParams(
      email: 'test@example.com',
      password: 'password123',
    );
    const token = 'test_token_123';

    when(() => mockUserRepository.loginUser(params.email, params.password))
        .thenAnswer((_) async => const Right(token));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right(token));
    verify(() => mockUserRepository.loginUser(params.email, params.password))
        .called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });

  test('❌ should return Failure when login fails', () async {
    // Arrange
    const params = LoginUsecaseParams(
      email: 'wrong@example.com',
      password: 'wrongpassword',
    );
    final failure = RemoteDatabaseFailure(message: 'Invalid credentials');

    when(() => mockUserRepository.loginUser(params.email, params.password))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Left(failure));
    verify(() => mockUserRepository.loginUser(params.email, params.password))
        .called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}
