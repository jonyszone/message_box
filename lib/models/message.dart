import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 0)
class Message {
  @HiveField(0)
  final String sender;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.message,
    required this.timestamp,
  });
}