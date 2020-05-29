class Crypto {
  String name;
  String price_usd;
  String precent_change_1h;

  Crypto({this.name, this.price_usd, this.precent_change_1h});
  Crypto.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        price_usd = map['price_usd'],
        precent_change_1h = map['precent_change_1h'];
}

abstract class CryptoRepo {
  //fetches data
  Future<List<Crypto>> fetchCurriences();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
