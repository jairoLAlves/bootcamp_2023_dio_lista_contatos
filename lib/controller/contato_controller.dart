import 'package:bootcamp_2023_dio_lista_contatos/extensions/extensions.dart';
import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:flutter/material.dart';

class ContatoController extends ChangeNotifier {
  final Contato contato;
  ContatoController({required this.contato}) {
    _getImage();
  }

  ValueNotifier<Image?> image = ValueNotifier(null);

  _getImage() async {
    image.value = (await contato.initImage()).image;
    notifyListeners();
  }
}
