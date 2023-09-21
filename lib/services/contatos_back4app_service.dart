
import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/util/env.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContatosBack4appService {

   final String _scheme = 'https';
  final String _host = Env.keyParseServerUrl;
  final String _path = '/classes/Contatos';
  final Map<String, String> _headers = {
    'X-Parse-Application-Id': Env.keyApplicationId,
    'X-Parse-REST-API-Key': Env.keyClientKey,
     'Content-Type': 'application/json'
  };


    Future<List<Map<String, dynamic>>> getContatos() async {
    Uri url = Uri(
      scheme: _scheme,
      host: _host,
      path: _path,
    );

    var result = await http.get(url, headers: _headers);

    if (result.statusCode > 200) {
      throw Exception('Error com o a chamada http');
    }

    var listResult = <Map<String, dynamic>>[];

    var responseMap = jsonDecode(result.body)
        as Map<String, dynamic>; // as List<Map<String, dynamic>>;

    if (responseMap.containsKey('error')) {
      throw Exception('Error com o a chamada back4app');
    }

    if (responseMap.containsKey('results')) {
      listResult = (responseMap['results'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList();
    }

    return listResult;
  }

    Future<void> deleteContato(Contato contato) async {
    Uri url = Uri(
      scheme: _scheme,
      host: _host,
      path: '$_path/${contato.objectId}',
    );
    var result = await http.delete(url, headers: _headers);

    debugPrint(result.toString());
  }

  Future<void> saveContato(Contato contato) async {
    Uri url = Uri(
      scheme: _scheme,
      host: _host,
      path: _path,
    );
    var result = await http.post(url, body: jsonEncode( contato.toJson()), headers: _headers);

    debugPrint(result.body.toString());
  }



  
}