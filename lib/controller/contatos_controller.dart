import 'package:bootcamp_2023_dio_lista_contatos/enums/enums.dart';
import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/repositories/contatos_back4app_repository.dart';
import 'package:flutter/material.dart';

class ContatosController extends ChangeNotifier {
  final ContatosBack4appRepository _contatosRepository =
      ContatosBack4appRepository();

  final ValueNotifier<Status> status = ValueNotifier<Status>(Status.start);

  ValueNotifier<List<Contato>> listContatos = ValueNotifier(<Contato>[]);

 

  void updateListContato() async {
       status.value = Status.loading;
    try {
      listContatos.value = await _contatosRepository.getContatos();
      debugPrint(listContatos.value.toString());
         status.value = Status.success;
    } catch (e) {
         status.value = Status.error;
      debugPrint(e.toString());
    }
  }

  void deleteContato(Contato contato)
  async {
   await _contatosRepository.deleteContato(contato);

  }




}
