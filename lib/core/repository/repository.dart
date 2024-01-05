import 'package:web_socket_channel/web_socket_channel.dart';

class Repository {
  final baseUrl = 'wss://nbstream.binance.com/eoptions/ws/btcusdt@kline_1h';

  WebSocketChannel fetchCandleStickData({String? symbol, String? interval}) {
    final channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl/eapi/v1/klines'),
    );
    return channel;
  }

  WebSocketChannel fetchOrderBookData({String? symbol, String? limit}) {
    final channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl'),
    );
    // channel.sink.add({
    //   "method": "SUBSCRIBE",
    //   "params": {
    //     "symbol": "BTCUSDT",
    //     "interval": "12h",
    //     "startTime": 1655969280000,
    //     "limit": 40,
    //     "id": 1
    //   }
    // });
    channel.sink.add({
      "method": "SUBSCRIBE",
      "params": ["BTC-210630-9000-P@ticker", "BTC-210630-9000-P@depth"],
      "id": 1
    });
    return channel;
  }
}
