import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/services/contatos_back4app_service.dart';

class ContatosBack4appRepository {
  ContatosBack4appService contatosBack4appService = ContatosBack4appService();

  Future<List<Contato>> getContatos() async {
    List<Contato> listaResult = [];
    await contatosBack4appService.getContatos().then((listMap) {
      listaResult =
          listMap.map((contato) => Contato.fromJson(contato)).toList();
    });
    return listaResult;
  }

  Future<void> deleteContato(Contato contato) async {
    await contatosBack4appService.deleteContato(contato);
  }

  Future<void> updateContato(Contato contato) async {
    await contatosBack4appService.updateContato(contato);
  }

  Future<String?> saveContato(Contato contato) async {
    String? objectId;
    objectId = await contatosBack4appService.saveContato(contato);
    return objectId;
  }
}
