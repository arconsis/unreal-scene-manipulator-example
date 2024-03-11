import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'data/rest_list.dart';

class HomeRepository {
  final _websocketChannel = WebSocketChannel.connect(
    Uri.parse('wss://a444-109-109-204-74.ngrok-free.app/ws'),
  );


  // Selbst einen Stream verwalten.
  // Andere außerhalb wie bspw. ein Bloc können auf diesen hören.
  //final BehaviorSubject<Data> _streamForBloc = BehaviorSubject();

  // Listener auf den Websocket
  //StreamSubscription<RestData> _websocketListener;


  HomeRepository();

  // Die Funktion um etwas über den Websocket an den Server zu senden.
  void putOnStream(RestList data) => _websocketChannel.sink.add(jsonEncode(data.toJson()));

  // Falls bloc oder andere auf Antworten vom Server über den
  // Websocket reagieren sollen. (Wird vom Repo verwaltet.)
  //Stream<Data> get _streamForBloc => _websocketStream.stream;

  // Ein Beispiel, wenn etwas auf den Stream vom Repo explizit warten will.
  //Future<ResponseData> getWebsocketMessage() async => await _websocketStream.stream.first;

}