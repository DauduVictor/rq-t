class CandleStickResponseModel {
  DateTime? dateTime;
  String? open;
  String? high;
  String? low;
  String? close;
  String? volume;
  String? amount;
  String? interval;
  int? tradeCount;
  String? takerVolume;
  String? takerAmount;
  int? openTime;
  int? closeTime;

  CandleStickResponseModel({
    this.dateTime,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.amount,
    this.interval,
    this.tradeCount,
    this.takerVolume,
    this.takerAmount,
    this.openTime,
    this.closeTime,
  });

  factory CandleStickResponseModel.fromJson(Map<String, dynamic> json) =>
      CandleStickResponseModel(
        dateTime: DateTime.fromMillisecondsSinceEpoch(json["openTime"]),
        open: json["open"],
        high: json["high"],
        low: json["low"],
        close: json["close"],
        volume: json["volume"],
        amount: json["amount"],
        interval: json["interval"],
        tradeCount: json["tradeCount"],
        takerVolume: json["takerVolume"],
        takerAmount: json["takerAmount"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
      );

  Map<String, dynamic> toJson() => {
        "open": open,
        "high": high,
        "low": low,
        "close": close,
        "volume": volume,
        "amount": amount,
        "interval": interval,
        "tradeCount": tradeCount,
        "takerVolume": takerVolume,
        "takerAmount": takerAmount,
        "openTime": openTime,
        "closeTime": closeTime,
      };
}
