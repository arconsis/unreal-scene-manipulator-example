import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'data/rest_list.dart';

class HomeRepository {
  final _websocketChannel = WebSocketChannel.connect(
    Uri.parse('wss://YOURLINK'),
  );

  HomeRepository();

  void putOnStream(RestList data) => _websocketChannel.sink.add(jsonEncode(data.toJson()));

}
