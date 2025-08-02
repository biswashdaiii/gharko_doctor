import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharko_doctor/app/sharedPref/token_helper.dart';
import 'package:gharko_doctor/app/sharedPref/token_shared_pref.dart';
import 'package:gharko_doctor/features/chat/domain/entity/chat_entity.dart';
import 'package:gharko_doctor/features/chat/presentation/view_model/chat_bloc.dart';
import 'package:gharko_doctor/features/chat/presentation/view_model/chat_event.dart';
import 'package:gharko_doctor/features/chat/presentation/view_model/chat_state.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChatPage extends StatefulWidget {
  final String chatUserId;
  final String chatUserName;

  const ChatPage({
    Key? key,
    required this.chatUserId,
    required this.chatUserName,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  String? _loggedInUserId = '';
  late TokenHelper tokenHelper;

  @override
  void initState() {
    super.initState();
    _loadLoggedInUserId();
  }

  Future<void> _loadLoggedInUserId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final tokenPrefs = TokenSharedPrefs(sharedPreferences: sharedPrefs);
    final helper = TokenHelper(tokenPrefs);

    try {
     final userId = await tokenHelper.getLoggedInUserId();

      setState(() {
        _loggedInUserId = userId;
      });

      // Load messages after userId is loaded
      context.read<ChatBloc>().add(LoadMessages(widget.chatUserId));
    } catch (e) {
      // Handle error - show message or fallback
      debugPrint('Failed to load logged-in user ID: $e');
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    context.read<ChatBloc>().add(
          SendMessage(
            receiverId: widget.chatUserId,
            text: text,
          ),
        );

    _messageController.clear();
  }

  Widget _buildMessageItem(ChatMessageEntity message) {
    final isMe = message.senderId == _loggedInUserId;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMe ? Colors.teal.shade300 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message.text ?? '',
          style: TextStyle(color: isMe ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatUserName),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatError) {
                  return Center(child: Text(state.message));
                } else if (state is ChatLoaded) {
                  if (state.messages.isEmpty) {
                    return const Center(child: Text('No messages yet.'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    reverse: true,
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message =
                          state.messages[state.messages.length - 1 - index];
                      return _buildMessageItem(message);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
