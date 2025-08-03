import 'package:gharko_doctor/features/chat/domain/entity/chat_entity.dart';
import 'package:gharko_doctor/features/chat/domain/repository/chat_IRepository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<ChatMessageEntity> call({
    required String receiverId,
    required String text,
    String? image,
    required String token,
  }) async {
    return await repository.sendMessage(
      receiverId: receiverId,
      text: text,
      image: image,
      token: token,
    );
  }
}