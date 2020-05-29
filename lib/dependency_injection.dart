import 'package:cryptocurrencyapp/data/crypto_data_mock.dart';
import 'package:cryptocurrencyapp/data/crypto_data_prod.dart';

import './data/crypto_data.dart';

enum Flavor { MOCK, PROD }

//Dependecy Injection

class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  CryptoRepo get cryptoRepo {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockCryptoRepo();
      default:
        return new ProdCryptoRepo();
    }
  }
}
