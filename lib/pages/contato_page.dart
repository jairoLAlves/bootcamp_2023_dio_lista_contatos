import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:flutter/material.dart';

class ContatoPage extends StatelessWidget {
  final Contato contato;
  const ContatoPage({super.key, required this.contato});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contato.nome ?? ''),
      ),
    );
  }
}
