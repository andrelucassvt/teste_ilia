import 'package:flutter/material.dart';
import 'package:teste_ilia/app/modules/home/controller/home_controller.dart';
import 'package:teste_ilia/app/modules/home/models/filmes.dart';
import 'package:teste_ilia/app/modules/home/service/home_service.dart';
import 'package:teste_ilia/app/modules/home/widgets/card_filmes_widget.dart';
import 'package:teste_ilia/app/shared/exception/public_message.dart';
import 'package:teste_ilia/app/shared/widgets/shader_widget.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeController _controller = HomeController(service: HomeService());

  @override
  void initState() {
    super.initState();
    getFilmes();
  }

  getFilmes() async {
    try {
      await _controller.getFilmes();
    } on PublicMessageException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.red,
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShaderWidget(
                    child: const Text('Ília filmes',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    )
                  ),
                  ShaderWidget(
                    child: IconButton(
                      onPressed: (){},
                      iconSize: 30,
                      color: Colors.white, 
                      icon: Icon(Icons.person)
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 20,
              ),

              Expanded(
                child: StreamBuilder<List<Filmes>>(
                  stream: _controller.filmesOut,
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<Filmes> dados = snapshot.data;

                    return ListView.builder(
                      itemCount: dados.length,
                      itemBuilder: (contex,index){
                        return CardFilmesWidget(dados[index]);
                      },
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}