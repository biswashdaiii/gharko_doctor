import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:gharko_doctor/app/sharedPref/token_helper.dart';
import 'package:gharko_doctor/features/chat/domain/usecase/get_message_usecase.dart';
import 'package:gharko_doctor/features/chat/domain/usecase/send_message_usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final TokenHelper tokenHelper;

  ChatBloc({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.tokenHelper,
  }) : super(ChatInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
  }

  // Load messages for a conversation
  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    try {
      final token = await tokenHelper.readToken();  // Get token here
      final messages = await getMessagesUseCase.call(
        userId: event.userId,
        token: token,
      );

      emit(ChatLoaded(messages));
    } on DioException catch (dioError) {
      print("Dio error on loading messages: ${dioError.message}");
      emit(ChatError(dioError.message ?? 'Failed to load messages'));
    } catch (e) {
      print("General error on loading messages: $e");
      emit(ChatError('Failed to load messages'));
    }
  }

  // Send a new message
  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    emit(MessageSending());

    try {
      final token = await tokenHelper.readToken(); // Get token here

      // Validation: at least one of text or image must be present
      if ((event.text == null || event.text!.isEmpty) &&
          (event.image == null || event.image!.isEmpty)) {
        emit(const MessageSendError('Message must contain text or image.'));
        return;
      }

      final sentMessage = await sendMessageUseCase.call(
        receiverId: event.receiverId,
        text: event.text ?? '',
        image: event.image,
        token: token,
      );

      emit(MessageSent(sentMessage));

      // Optionally reload the chat after sending a message
      final messages = await getMessagesUseCase.call(
        userId: event.receiverId,
        token: token,
      );

      emit(ChatLoaded(messages));
    } on DioException catch (dioError) {
      print("Dio error on sending message: ${dioError.message}");
      emit(MessageSendError(dioError.message ?? 'Failed to send message'));
    } catch (e) {
      print("General error on sending message: $e");
      emit(const MessageSendError('Failed to send message'));
    }
  }
}
