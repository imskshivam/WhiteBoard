import 'package:flutter/cupertino.dart';

import '../../modules/chat_page.dart';

class ChatMessage {
  String message;
  MessageType type;
  ChatMessage({required this.message, required this.type});
}
