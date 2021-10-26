import 'dart:async';
import 'package:teste_ilia/app/modules/home/models/filmes.dart';
import 'package:teste_ilia/app/modules/home/service/home_service.dart';

class HomeController {

  final HomeService service;

  HomeController({
    this.service
  });
  
  final _filmesController = StreamController<List<Filmes>>();
  Sink<List<Filmes>> get filmesIn => _filmesController.sink;
  Stream<List<Filmes>> get filmesOut => _filmesController.stream;

  getFilmes() async {
    List<Filmes> dados = await service.getFilmes();
    filmesIn.add(dados);
  }


  dispose(){
    _filmesController.close();
  }
}