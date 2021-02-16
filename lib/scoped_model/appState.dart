import 'package:flutte_pokedex/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AppState extends ChangeNotifier {
  AppState();

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  void setApiBusy([bool isbusy = false]) {
    _isBusy = isbusy;
  }

  Future<Response> getAsync(String uri) async {
    var url = uri;
    //  var header = { "User-Agent":"BastionDiscordBot (https://bastionbot.org, v6.3)"};
    print('Pegar endereço da API :- ' + url);
    var response = await get(
      url,
    );
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  void apiCall(
      {bool isReady = false,
      bool isException = false,
      bool isnotify = false,
      bool isApiError = false}) {
    _isBusy = isReady;
    if (isnotify) {
      notifyListeners();
      print('Notify Listner');
    }
    print(isReady
        ? 'API foi chamada'
        : isException
            ? 'Exception occured'
            : isApiError
                ? 'Erro na Api'
                : 'Api chamada com sucesso');
  }
}
