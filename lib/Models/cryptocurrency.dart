class Crypto {
  final String id;
  final String coinName;
  final String price;
  final String coinTicker;

  Crypto._(this.id, this.coinName, this.coinTicker, this.price);

  factory Crypto.fromJson(Map json) {
    final id = json[''].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final coinName = json['coinName'];
    final price = json['price'];
    final coinTicker = json['coinTicker'];

    return Crypto._(id, coinName, coinTicker, price);
  }
}
