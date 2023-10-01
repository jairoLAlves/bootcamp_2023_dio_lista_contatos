import 'package:bootcamp_2023_dio_lista_contatos/controller/contato_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/controller/contatos_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/enums/enums.dart';
import 'package:bootcamp_2023_dio_lista_contatos/pages/contato_edit_page.dart';
import 'package:bootcamp_2023_dio_lista_contatos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ContatoPage extends StatefulWidget {
  final ContatoController contatoController;

  const ContatoPage({super.key, required this.contatoController});

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  late ContatosController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<ContatosController>();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('ContatoPage build');
    var controller = context.watch<ContatosController>();

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
                          builder: (_) => ContatoEditPage(
                              contato: widget.contatoController.contato),
                        ));

                        if (result ?? false) {
                          controller.updateListContato();
                          widget.contatoController.contato =
                              controller.getContato(
                                  widget.contatoController.contato.objectId!);
                        }
                      }

                    case MenuContatoPage.delete:
                      {
                        controller
                            .deleteContato(widget.contatoController.contato);

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
        body: Column(
          children: [
            Column(
              children: [
                largeAvatar(image: widget.contatoController.image),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.contatoController.contato.nome ?? '',
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
                cardActionContato(
                    text: 'Ligar', icon: const FaIcon(FontAwesomeIcons.phone)),
                cardActionContato(
                    text: 'Enviar SMS',
                    icon: const FaIcon(FontAwesomeIcons.solidMessage)),
                cardActionContato(
                    text: 'Configurar',
                    icon: const FaIcon(FontAwesomeIcons.video)),
              ],
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: Colors.greenAccent,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 5,
                            child: Container(
                              child: ListTile(
                                leading: const FaIcon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.green,
                                  size: 40,
                                ),
                                title: Text(
                                    '${widget.contatoController.contato.tel}'),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
