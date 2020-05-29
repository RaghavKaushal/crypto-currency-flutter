// this will run on default data given by us

import 'crypto_data.dart';

class MockCryptoRepo implements CryptoRepo {
  @override
  Future<List<Crypto>> fetchCurriences() {
    return Future.value(curriencies);
  }
}

var curriencies = <Crypto>[
  new Crypto(name: "Bitcoin", price_usd: "800.74", precent_change_1h: "-0.77"),
  new Crypto(
      name: "Bitcoi222n", price_usd: "10000.74", precent_change_1h: "-8.77"),
  new Crypto(
      name: "Bi23333tcoin", price_usd: "103.74", precent_change_1h: "+55.77")
];
