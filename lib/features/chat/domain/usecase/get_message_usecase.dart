import 'package:gharko_doctor/features/chat/domain/entity/chat_entity.dart';
import 'package:gharko_doctor/features/chat/domain/repository/chat_IRepository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  Future<List<ChatMessageEntity>> call({
    required String userId,
    required String token,
  }) {
    return repository.getMessages(userId, token);
  }
}