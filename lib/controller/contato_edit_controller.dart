import 'package:bootcamp_2023_dio_lista_contatos/enums/enums.dart';
import 'package:bootcamp_2023_dio_lista_contatos/extensions/extensions.dart';
import 'package:bootcamp_2023_dio_lista_contatos/repositories/contatos_back4app_repository.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

class ContatoEditController extends ChangeNotifier {
  late final Contato _contato;
  PhoneNumber? _number;

  late final ContatosBack4appRepository contatosRepository;

  late final TextEditingController nomeController;
  late final TextEditingController sobreNomeController;
  late final TextEditingController telController;

  late CustomImageCropController controllerCrop;

  ContatoEditController({Contato? contato}) {
    contatosRepository = ContatosBack4appRepository();
    controllerCrop = CustomImageCropController();
    _contato = contato ?? Contato();
  }

  String? validatorName(String? valor) {
    if (valor?.isEmpty ?? false) return 'Informe um valor';
    return null;
  }

  void init() async {
    print(_contato);
    telController = TextEditingController();

    nomeController = (_contato.nome != null)
        ? TextEditingController(text: _contato.nome)
        : TextEditingController();

    sobreNomeController = (_contato.sobreNome != null)
        ? TextEditingController(text: _contato.sobreNome)
        : TextEditingController();

    if ((_contato.tel != null)) {
      number =
          await PhoneNumber.getRegionInfoFromPhoneNumber(_contato.tel!, 'BR');

      telController.text = number?.phoneNumber ?? '';
    } else {
      number = PhoneNumber(isoCode: 'BR');
    }

    _initImage();
  }

  void _initImage() async {
    final result = await _contato.initImage();
    _file = result.file;
    photo.value = result.image;
    notifyListeners();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String initialCountry = 'BR';
  final ImagePicker piker = ImagePicker();

  ValueNotifier<Image?> photo = ValueNotifier(null);

  XFile? _file;

  Future<XFile?> capturaImage(PhotoIn? photoIn) async {
    return switch (photoIn) {
      PhotoIn.camera => await piker.pickImage(source: ImageSource.camera),
      PhotoIn.gallery => await piker.pickImage(source: ImageSource.gallery),
      _ => null
    };
  }

  set number(PhoneNumber? n) {
    _number = n;
  }

  PhoneNumber? get number => _number;

  void setName() {
    if (nomeController.text.trim().isNotEmpty) {
      _contato.nome = nomeController.text.trim();
    }
  }

  void setSobreNome() {
    if (sobreNomeController.text.trim().isNotEmpty) {
      _contato.sobreNome = sobreNomeController.text.trim();
    }
  }

  void _setTel() {
    if (number?.phoneNumber != null) {
      _contato.tel = number?.phoneNumber;
    }
  }

  void cropImage(MemoryImage image) async {
    try {
      final Uint8List bytes = image.bytes;

      _file = XFile.fromData(image.bytes);

      photo.value = _contato.bytesToImage(bytes);
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  void _savePhoto(String? objectId) async {
    if (_file != null && objectId != null) {
      //salvando no diretório da aplicação
      var path = (await path_provider.getApplicationDocumentsDirectory()).path;
      await _file!.saveTo('$path/$objectId.jpg');
      // await GallerySaver.saveImage(photo!.path);
    }
  }

  void onSave(BuildContext context) async {
    String? objectId;

    formKey.currentState?.save();
    if (formKey.currentState?.validate() ?? false) {
      setName();
      setSobreNome();
      _setTel();

      if (_contato.objectId == null) {
        objectId = await contatosRepository.saveContato(_contato);
        _savePhoto(objectId);
      } else {
        contatosRepository.updateContato(_contato);
        _savePhoto(_contato.objectId);
      }
      Navigator.of(context).pop(true);
    }
    print(_contato);
  }
}
