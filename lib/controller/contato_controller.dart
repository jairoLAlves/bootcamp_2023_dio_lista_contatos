import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/repositories/image_base64_repository.dart';
import 'package:flutter/material.dart';

class ContatoController extends ChangeNotifier {
  late Contato _contato;
 Image? _image;
  late final ImageBase64Repository imageRepository;
  ContatoController({required contato}) {
    _contato = contato;
    imageRepository = ImageBase64Repository();
    updateImage();
  }

  Contato get contato => _contato;
  set contato(Contato contato) {
    _contato = contato;
    updateImage();
    notifyListeners();
  }

  Image? get image => _image;

  void updateImage() {
    if (contato.path != null) {
      _image = imageRepository.getImage(pathImage: contato.path!);
      notifyListeners();
    }
  }
}
