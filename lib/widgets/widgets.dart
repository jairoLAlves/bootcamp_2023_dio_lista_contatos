import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/pages/contato_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget contatoCard(Contato contato, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContatoPage(contato: contato),
          ));
    },
    child: Card(
      child: ListTile(
        leading: emptyAvatar(),
        title: Text(contato.nome ?? ''),
      ),
    ),
  );
}

Widget emptyAvatar() => const CircleAvatar(
      child: FaIcon(FontAwesomeIcons.user),
    );
Widget emptyImage() => const CircleAvatar(
      maxRadius: 60,
      child: FaIcon(
        FontAwesomeIcons.user,
        size: 60,
      ),
    );
