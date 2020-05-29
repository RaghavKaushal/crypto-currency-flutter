import 'package:cryptocurrencyapp/data/crypto_data.dart';
import 'package:cryptocurrencyapp/dependency_injection.dart';

abstract class CryptoListViewContract {
  void onLoadCryptoComplete(List<Crypto> items);
  void onLoadCryptoError();
}

class CryptoListPresenter {
  CryptoListViewContract _view;
  CryptoRepo _repo;

  CryptoListPresenter(this._view) {
    _repo = new Injector().cryptoRepo;
  }

  void loadCurriences() {
    _repo
        .fetchCurriences()
        .then((c) => _view.onLoadCryptoComplete(c))
        .catchError((onError) => _view.onLoadCryptoError());
  }
}
