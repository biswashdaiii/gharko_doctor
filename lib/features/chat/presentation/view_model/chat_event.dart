// features/chat/presentation/view_model/chat_event.dart

import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadMessages extends ChatEvent {
  final String userId;

  const LoadMessages(this.userId);

  @override
  List<Object?> get props => [userId];
}

class SendMessage extends ChatEvent {
  final String receiverId;
  final String? text;
  final String? image;

  const SendMessage({
    required this.receiverId,
    this.text,
    this.image,
  });

  @override
  List<Object?> get props => [receiverId, text, image];
}
