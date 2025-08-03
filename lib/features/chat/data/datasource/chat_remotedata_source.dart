import 'package:gharko_doctor/core/network/api_service.dart';
import 'package:gharko_doctor/features/chat/data/model/chat_apimodel.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatMessageModel>> getMessages({
    required String userId,
    required String token,  // add token param
  });

  Future<ChatMessageModel> sendMessage({
    required String receiverId,
    required String text,
    String? image,
    required String token,  // add token param
  });
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiService apiService;

  ChatRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<ChatMessageModel>> getMessages({
    required String userId,
    required String token,
  }) async {
    final response = await apiService.get(
      'messages/$userId',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = response.data as List;
    return data.map((json) => ChatMessageModel.fromJson(json)).toList();
  }

  @override
  Future<ChatMessageModel> sendMessage({
    required String receiverId,
    required String text,
    String? image,
    required String token,
  }) async {
    final messageData = {
      'text': text,
      if (image != null) 'image': image,
    };

    final response = await apiService.post(
      'messages/send/$receiverId',
      data: messageData,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return ChatMessageModel.fromJson(response.data);
  }
}
