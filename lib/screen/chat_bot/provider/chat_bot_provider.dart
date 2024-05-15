import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:news_info/constant/asset_constant.dart';

class ChatbotProvider with ChangeNotifier {
  final ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "User",
  );

  final ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini AI",
    profileImage: AssetConstant.categoryProfile
  );

  final List<ChatMessage> _messages = [];
  final Gemini _gemini = Gemini.instance;

  List<ChatMessage> get messages => _messages;

  void sendMessage(ChatMessage chatMessage) async {
    _messages.insert(0, chatMessage);
  notifyListeners();

    try {
      String question = chatMessage.text;
      _gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = _messages.firstOrNull;

        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = _messages.removeAt(0);
          String response = event.content?.parts?.fold(
                "",
                (previousValue, element) => "$previousValue${element.text}",
              ) ??
              "";

          lastMessage.text += response;

          _messages.insert(0, lastMessage);
          notifyListeners();
        } else {
          String response = event.content?.parts?.fold(
                "",
                (previousValue, element) => "$previousValue${element.text}",
              ) ??
              "";

          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );

          _messages.insert(0, message);
        }
        notifyListeners();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
