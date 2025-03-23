import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/message.dart';
import '../services/websocket_service.dart';

class ChatProvider with ChangeNotifier {
  final Box<Message> _messageBox = Hive.box<Message>('messages');
  late WebSocketService _webSocketService;
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  ChatProvider() {
    _loadMessages();
  }

  void _loadMessages() {
    _messages = _messageBox.values.toList();
    notifyListeners();
  }

  void connectWebSocket(String url) {
    _webSocketService = WebSocketService(url);
    _webSocketService.stream.listen((message) {
      final newMessage = Message(
        sender: 'Other',
        message: message,
        timestamp: DateTime.now(),
      );
      _messageBox.add(newMessage);
      _messages.add(newMessage);
      notifyListeners();
    });
  }

  void sendMessage(String sender, String message) {
    final newMessage = Message(
      sender: sender,
      message: message,
      timestamp: DateTime.now(),
    );
    _messageBox.add(newMessage);
    _messages.add(newMessage);
    notifyListeners();
    _webSocketService.sendMessage(message);
  }

  @override
  void dispose() {
    _webSocketService.dispose();
    super.dispose();
  }
}