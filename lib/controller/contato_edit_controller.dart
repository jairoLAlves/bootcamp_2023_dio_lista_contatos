import 'package:bootcamp_2023_dio_lista_contatos/enums/enums.dart';
import 'package:bootcamp_2023_dio_lista_contatos/repositories/contatos_back4app_repository.dart';
import 'package:bootcamp_2023_dio_lista_contatos/repositories/image_base64_repository.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ContatoEditController extends ChangeNotifier {
  late final Contato _contato;
  late final ImageBase64Repository _imageRepository;
  late final ContatosBack4appRepository contatosRepository;
  late final TextEditingController nomeController;
  late final TextEditingController sobreNomeController;
  late final TextEditingController telController;
  late final CustomImageCropController controllerCrop;

  final FocusNode? focusNodeNome = FocusNode();
  final FocusNode? focusNodeSobreNome = FocusNode();
  final FocusNode? focusNodeTel = FocusNode();
  final FocusNode? focusNodeBtn = FocusNode();
  ValueNotifier<Status> status = ValueNotifier(Status.start);

  ValueNotifier<bool> onFocusChangeBtn = ValueNotifier(false);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String initialCountry = 'BR';
  final ImagePicker piker = ImagePicker();

  PhoneNumber? _number;
  Uint8List? _bytes;

  ValueNotifier<Image?> photo = ValueNotifier(null);

  ContatoEditController({Contato? contato}) {
    _imageRepository = ImageBase64Repository();
    contatosRepository = ContatosBack4appRepository();
    controllerCrop = CustomImageCropController();
    _contato = contato ?? Contato();
  }

  String? validatorName(String? valor) {
    if (valor?.isEmpty ?? false) return 'Informe um valor';
    return null;
  }

  void init() async {
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
    if (_contato.path != null) {
      photo.value = _imageRepository.getImage(pathImage: _contato.path!);
      notifyListeners();
    }
  }

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
      _bytes = image.bytes;
      photo.value = _imageRepository.bytesToImage(_bytes!);
    } catch (e) {
      debugPrint(e.toString());
    }

    notifyListeners();
  }

  void _setPath() {
    if (_bytes != null) {
      _contato.path = _imageRepository.imageEncode(bytes: _bytes!);
    }
  }

  void onSave(BuildContext context) async {
    formKey.currentState?.save();
    if (formKey.currentState?.validate() ?? false) {
      status.value = Status.loading;
      setName();
      setSobreNome();
      _setTel();
      _setPath();

      if (_contato.objectId == null) {
        try {
          contatosRepository.saveContato(_contato);
          await Future.delayed(
            const Duration(seconds: 10),
          );
          status.value = Status.success;
        } catch (e) {
          status.value = Status.error;
          debugPrint(e.toString());
        }
      } else {
        try {
          contatosRepository.updateContato(_contato);
          await Future.delayed(
            const Duration(seconds: 10),
          );
          status.value = Status.success;
        } catch (e) {
          status.value = Status.error;
          debugPrint(e.toString());
        }
      }
    }
  }
}
