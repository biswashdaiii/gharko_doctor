class ChatMessageEntity {
  final String id;
  final String senderId;
  final String receiverId;
  final String? text;
  final String? image; // Optional image URL or base64
  final DateTime createdAt;

  const ChatMessageEntity({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.text,
    this.image,
    required this.createdAt,
  });
}
