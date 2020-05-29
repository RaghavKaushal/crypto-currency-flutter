import 'crypto_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProdCryptoRepo implements CryptoRepo {
  @override
  Future<List<Crypto>> fetchCurriences() async {
    String url =
        "https://api.coinmarketcap.com/v1/ticker/?limit=50"; //depreciated API
    http.Response response = await http.get(url);
    final List responseBody = jsonDecode(response.body);
    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null) {
      throw new FetchDataException(
          "An error Occured : [Status Code: $statusCode]");
    }
    return responseBody.map((c) => new Crypto.fromMap(c)).toList();
  }
}
