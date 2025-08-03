import 'package:gharko_doctor/features/chat/domain/entity/chat_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  ChatMessageModel({
    required String id,
    required String senderId,
    required String receiverId,
    String? text,
    String? image,
    required DateTime createdAt,
  }) : super(
          id: id,
          senderId: senderId,
          receiverId: receiverId,
          text: text,
          image: image,
          createdAt: createdAt,
        );

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['_id'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      text: json['text'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
