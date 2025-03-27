import 'package:message_box/services/websocket_service.dart';
import 'package:test/test.dart';

void main() {
  group('WebSocketService', () {
    late WebSocketService webSocketService;
    const testUrl = 'ws://echo.websocket.org';

    setUp(() async {
      webSocketService = WebSocketService(testUrl);
      await Future.delayed(Duration(seconds: 1)); // Ensure connection stabilizes
    });

    tearDown(() {
      webSocketService.dispose();
    });

    test('Connects to WebSocket', () async {
      expect(webSocketService.channel, isTrue);
    });

    test('Sends and receives a message', () async {
      final testMessage = 'Hello, WebSocket!';
      webSocketService.sendMessage(testMessage);

      final receivedMessage = await webSocketService.stream.first;
      print('Received: $receivedMessage'); // Debugging

      expect(receivedMessage, contains(testMessage)); // Looser match
    });
  });
}
