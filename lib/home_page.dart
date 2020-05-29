import 'package:cryptocurrencyapp/data/crypto_data.dart';
import 'package:cryptocurrencyapp/modules/crypto_presenter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements CryptoListViewContract {
  bool isLoading;
  CryptoListPresenter _presenter;
  List<Crypto> currencies;

  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  _HomePageState() {
    _presenter = new CryptoListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadCurriences();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Crypto App"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: isLoading
          ? new Center(
              child: CircularProgressIndicator(),
            )
          : _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Container(
        child: new Column(
      children: <Widget>[
        new Flexible(
          child: ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final Crypto currency = currencies[index];
                final MaterialColor color = _colors[index % _colors.length];
                return _getListItemUI(currency, color);
              }),
        ),
      ],
    ));
  }

  ListTile _getListItemUI(Crypto currency, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency.name[0]),
      ),
      title: new Text(
        currency.name,
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle:
          _getSubtitleText(currency.price_usd, currency.precent_change_1h),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceUSD\n", style: new TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentagechangetextwidget;

    if (double.parse(percentageChange) > 0) {
      percentagechangetextwidget = new TextSpan(
          text: percentageChangeText,
          style: new TextStyle(color: Colors.green));
    } else {
      percentagechangetextwidget = new TextSpan(
          text: percentageChangeText, style: new TextStyle(color: Colors.red));
    }
    return RichText(
      text: new TextSpan(
        children: [priceTextWidget, percentagechangetextwidget],
      ),
    );
  }

  @override
  void onLoadCryptoComplete(List<Crypto> items) {
    setState(() {
      currencies = items;
      isLoading = false;
    });
  }

  @override
  void onLoadCryptoError() {}
}
