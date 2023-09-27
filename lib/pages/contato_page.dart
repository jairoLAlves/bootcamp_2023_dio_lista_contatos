import 'dart:math';

import 'package:bootcamp_2023_dio_lista_contatos/controller/contato_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/controller/contatos_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/enums/enums.dart';
import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/pages/contato_edit_page.dart';
import 'package:bootcamp_2023_dio_lista_contatos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ContatoPage extends StatelessWidget {
  final Contato contato;
  final ContatoController contatoController;

  const ContatoPage(
      {super.key, required this.contato, required this.contatoController});

  @override
  Widget build(BuildContext context) {
    var controller = context.read<ContatosController>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  MenuContatoPage? menuContatoPage =
                      await showMenu<MenuContatoPage?>(
                          constraints: const BoxConstraints(
                            minWidth: 200,
                          ),
                          context: context,
                          position: const RelativeRect.fromLTRB(
                            1,
                            0,
                            0,
                            0,
                          ),
                          items: [
                        const CheckedPopupMenuItem(
                            value: MenuContatoPage.edit,
                            padding: EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Edit'),
                                Icon(Icons.edit),
                              ],
                            )),
                        const CheckedPopupMenuItem(
                            value: MenuContatoPage.delete,
                            padding: EdgeInsets.all(0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Delete'),
                                Icon(Icons.delete),
                              ],
                            )),
                      ]);

                  switch (menuContatoPage) {
                    case MenuContatoPage.edit:
                      {
                        bool? result = await Navigator.of(context)
                            .push<bool?>(MaterialPageRoute(
                          builder: (_) => ContatoEditPage(contato: contato),
                        ));

                        if (result ?? false) {
                          controller.updateListContato();
                        }
                      }

                    case MenuContatoPage.delete:
                      {
                        controller.deleteContato(contato);
                        Navigator.of(context).pop(true);
                      }

                    case null:
                      {}
                    // TODO: Handle this case.
                  }
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: controller.listContatos,
          builder: (context, _, __) => Column(
            children: [
              Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: contatoController.image,
                    builder: (__, image, _) => largeAvatar(image: image),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    contato.nome ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: const FaIcon(FontAwesomeIcons.phone),
                      ),
                      const Text('Ligar'),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: const FaIcon(FontAwesomeIcons.solidMessage),
                      ),
                      const Text('Enviar SMS')
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: const FaIcon(FontAwesomeIcons.video),
                      ),
                      const Text('Configurar')
                    ],
                  ),
                ],
              ),
              const Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Color.fromARGB(100, 87, 160, 234),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
