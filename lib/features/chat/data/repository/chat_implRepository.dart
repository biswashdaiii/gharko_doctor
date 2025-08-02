import 'package:gharko_doctor/features/chat/data/datasource/chat_remotedata_source.dart';
import 'package:gharko_doctor/features/chat/domain/entity/chat_entity.dart';
import 'package:gharko_doctor/features/chat/domain/repository/chat_IRepository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ChatMessageEntity>> getMessages(String userId, String token) {
    return remoteDataSource.getMessages(userId: userId, token: token);
  }

  @override
  Future<ChatMessageEntity> sendMessage({
    required String receiverId,
    required String text,
    String? image,
    required String token,
  }) {
    return remoteDataSource.sendMessage(
      receiverId: receiverId,
      text: text,
      image: image,
      token: token,
    );
  }
}
