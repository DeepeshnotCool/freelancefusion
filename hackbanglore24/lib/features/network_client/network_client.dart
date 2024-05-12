
import 'package:dio/dio.dart';

class NetworkClient{
  late final Dio _client;
  NetworkClient(){
    _client = Dio();
  }

  Future postRequest(String path) async{
    await _client.post(path);
  }
}