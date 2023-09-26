import 'dart:typed_data';

import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

extension ContatoUtil on Contato {
  Image bytesToImage(Uint8List bytes)  {
    return  Image.memory(bytes);
  }

  Future<({XFile? file, Image? image, Uint8List? bytes})> initImage() async {
    XFile? file;
    Uint8List? bytes;
    Image? image;

    if (objectId != null) {
      try {
        var pathLocal =
            (await path_provider.getApplicationDocumentsDirectory()).path;

        file =   XFile('$pathLocal/$objectId.jpg');
        bytes = await file.readAsBytes();
        image =  bytesToImage(bytes);
        
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return (file: file, image: image, bytes: bytes);
  }
}
