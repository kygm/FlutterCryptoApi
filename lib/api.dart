import 'package:dio/dio.dart';

import './Models/cryptocurrency.dart';

const String localhost = "http://localhost:1250/";

class CryptoApi {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getCoins() async {
    final response = await _dio.get('/getCoins');

    return response.data['coins'];
  }

  Future editCoin(String id, double price) async {
    final response =
        await _dio.post('/editCoin', data: {'id': id, 'price': price});
  }

  Future deleteCoin(String id) async {
    final response = await _dio.post('/deleteCoin', data: {'id': id});
  }
}
