import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:message_box/providers/chat_provider.dart';
import 'package:message_box/screens/chat_screen.dart';
import 'package:provider/provider.dart';
import 'models/message.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());
  await Hive.openBox<Message>('messages');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: MaterialApp(
        title: 'Chat App',
        home: ChatScreen(),
      ),
    );
  }
}