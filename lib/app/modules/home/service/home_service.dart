import 'dart:io';

import 'package:dio/dio.dart';
import 'package:teste_ilia/app/modules/home/models/filmes.dart';
import 'package:teste_ilia/app/shared/exception/public_message.dart';
import 'package:teste_ilia/app/shared/util/api_key.dart';

class HomeService {
  
  Future<List<Filmes>> getFilmes() async {
    try {
      Response response = await Dio().get('https://api.themoviedb.org/3/movie/76341?api_key=${chaveApi}');
      print(response.data);
      return Filmes.fromJsonList(response.data);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw PublicMessageException('Verifique sua conexão');
      }
      throw PublicMessageException('Erro ao carregar dados');
    }
  }
}