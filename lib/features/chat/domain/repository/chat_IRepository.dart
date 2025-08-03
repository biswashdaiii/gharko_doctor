import 'package:gharko_doctor/features/chat/domain/entity/chat_entity.dart';

abstract class ChatRepository {
  Future<List<ChatMessageEntity>> getMessages(String userId, String token);
  Future<ChatMessageEntity> sendMessage({
    required String receiverId,
    required String text,
    String? image,
    required String token,
  });
}
