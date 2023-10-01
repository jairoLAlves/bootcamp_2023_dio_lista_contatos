import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageBase64Repository {
  String imageEncode({required Uint8List bytes}) {
    String b64 = base64.encode(bytes);

    return b64;
  }

  Uint8List imageDecode({required String encoded}) {
    var b64 = base64.decode(encoded);

    return b64;
  }

  Image bytesToImage(Uint8List bytes) {
    return Image.memory(bytes);
  }

  Image getImage({required String pathImage}) {
    var bytes = imageDecode(encoded: pathImage);
    return bytesToImage(bytes);
  }
}
