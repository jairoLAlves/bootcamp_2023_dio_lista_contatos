import 'package:bootcamp_2023_dio_lista_contatos/controller/contato_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/enums/enums.dart';
import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/repositories/contatos_back4app_repository.dart';
import 'package:flutter/material.dart';

class ContatosController extends ChangeNotifier {
  final ContatosBack4appRepository _contatosRepository =
      ContatosBack4appRepository();

  ContatosController() {
    updateListContato();
  }

  ValueNotifier<Status> status = ValueNotifier(Status.start);

  final List<Contato> _listContatos = [];

  Contato getContato(String objectId) {
    Contato contato =
        _listContatos.firstWhere((contato) => contato.objectId == objectId);
    return contato;
  }

  _rebuildList(List<Contato> newList) {
    _listContatos.clear();
    _listContatos.addAll(newList);
    notifyListeners();
    debugPrint(listaContatos.toString());
  }

  List<Contato> get listaContatos => [..._listContatos];

  void updateListContato() async {
    status.value = Status.loading;
    var tempList = <Contato>[];

    try {
      tempList = await _contatosRepository.getContatos();
      _rebuildList(tempList);
      status.value = Status.success;
    } catch (e) {
      status.value = Status.error;
      debugPrint(e.toString());
    }
  }

  void deleteContato(Contato contato) async {
    try {
      await _contatosRepository.deleteContato(contato);
      updateListContato();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
