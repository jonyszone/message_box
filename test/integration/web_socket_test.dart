import 'package:message_box/services/websocket_service.dart';
import 'package:test/test.dart';

void main() {
  group('WebSocketService', () {
    late WebSocketService webSocketService;
    const testUrl = 'ws://echo.websocket.org';

    setUp(() async {
      webSocketService = WebSocketService(testUrl);
      await Future.delayed(Duration(seconds: 1)); // Give time for connection to establish
    });

    tearDown(() {
      webSocketService.dispose();
    });

    test('Receives initial connection message', () async {
      final initialMessage = await webSocketService.stream.first;
      print('Received: $initialMessage'); // Debugging

      expect(initialMessage, contains('Request served by')); // Looser check
    });

    test('Sends and receives a message', () async {
      final testMessage = 'Hello, WebSocket!';
      webSocketService.sendMessage(testMessage);

      // Wait for the echoed message, skipping the initial connection message
      final messages = await webSocketService.stream.take(2).toList();
      print('All received messages: $messages');

      expect(messages.last, equals(testMessage)); // Ensure last message is the echo
    });
  });
}
