import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/services/contatos_back4app_service.dart';
import 'package:flutter/foundation.dart';

class ContatosBack4appRepository {
  ContatosBack4appService contatosBack4appService = ContatosBack4appService();

  Future<List<Contato>> getContatos() async {
    List<Contato> listaResult = [];
    List<Map<String, dynamic>> listMap =
        await contatosBack4appService.getContatos();

    listaResult = listMap.map((contato) => Contato.fromJson(contato)).toList();

    return listaResult;
  }

  Future<void> deleteContato(Contato contato) async {
    try {
      await contatosBack4appService.deleteContato(contato);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateContato(Contato contato) async {
    try {
      await contatosBack4appService.updateContato(contato);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String?> saveContato(Contato contato) async {
    String? objectId;
    try {
      objectId = await contatosBack4appService.saveContato(contato);
    } catch (e) {
      debugPrint(e.toString());
    }
    return objectId;
  }
}
