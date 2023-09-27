import 'package:bootcamp_2023_dio_lista_contatos/controller/contato_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/controller/contatos_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/extensions/extensions.dart';
import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/pages/contato_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget contatoCard(
    Contato contato, BuildContext context, ContatosController controller) {
  ContatoController contatoController = ContatoController(contato: contato);
  return InkWell(
    key: ObjectKey(contato.objectId),
    onTap: () async {
      var result = await Navigator.push<bool?>(
          context,
          MaterialPageRoute(
            builder: (context) => ContatoPage(
              contato: contato,
              contatoController: contatoController,
            ),
          ));
      if (result ?? false) {
        controller.updateListContato();
      }
    },
    child: ValueListenableBuilder(
      valueListenable: contatoController.image,
      builder: (__, image, _) => Card(
        child: ListTile(
          leading: smallAvatar(image: image),
          title: Text(contato.nome ?? ''),
          trailing: Text(contato.tel ?? ''),
        ),
      ),
    ),
  );
}

Widget smallAvatar({Image? image}) => CircleAvatar(
      child: (image == null)
          ? const FaIcon(FontAwesomeIcons.user)
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  //fit: BoxFit.fill,
                  image: image.image,
                ),
              ),
            ),
    );

Widget largeAvatar({Image? image}) => CircleAvatar(
      radius: 60,
      child: (image == null)
          ? const FaIcon(
              FontAwesomeIcons.user,
              size: 60,
            )
          : Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: image.image,
                ),
              ),
            ),
    );

TextFormField textField({
  TextEditingController? controller,
  Widget? label,
  Widget? icon,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  TextInputType? keyboardType,
}) {
  return TextFormField(
    onChanged: onChanged,
    keyboardType: keyboardType,
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      icon: icon,
      label: label,
      border: const OutlineInputBorder(),
    ),
  );
}
