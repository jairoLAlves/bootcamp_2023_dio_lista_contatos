import 'package:bootcamp_2023_dio_lista_contatos/controller/contato_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/controller/contatos_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/enums/enums.dart';
import 'package:bootcamp_2023_dio_lista_contatos/pages/contato_edit_page.dart';
import 'package:bootcamp_2023_dio_lista_contatos/pages/contato_page.dart';
import 'package:bootcamp_2023_dio_lista_contatos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ListaContatosPage extends StatefulWidget {
  const ListaContatosPage({super.key});

  @override
  State<ListaContatosPage> createState() => _ListaContatosPageState();
}

class _ListaContatosPageState extends State<ListaContatosPage> {
  late final ContatosController contatosController;

  @override
  void initState() {
    super.initState();
    contatosController = context.read<ContatosController>();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('ContatoPage build');

    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              bool? result = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContatoEditPage(contato: null),
                  ));
              if (result ?? false) {
                contatosController.updateListContato();
              }
            },
            child: const FaIcon(FontAwesomeIcons.userPlus),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Contatos'),
          ),
          body: ValueListenableBuilder(
            valueListenable: contatosController.status,
            builder: (context, status, child) => Container(
              child: switch (status) {
                Status.loading => const Center(
                    child: CircularProgressIndicator(),
                  ),
                Status.success => Column(
                    children: [
                      const Row(
                        children: [
                          //  Text('Campo de pesquisa'),
                        ],
                      ),
                      Expanded(
                          child: (contatosController.listaContatos.isEmpty)
                              ? const Center(
                                  child: Text('Adicione novos contatos!'),
                                )
                              : ListView(
                                  children: [
                                    ...contatosController.listaContatos
                                        .map((contato) {
                                      ContatoController contatoController =
                                          ContatoController(contato: contato);

                                      return InkWell(
                                        onTap: () async {
                                          await Navigator.push<bool?>(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ContatoPage(
                                                  contatoController:
                                                      contatoController,
                                                ),
                                              ));

                                          setState(() {
                                            print('setState');
                                          });
                                        },
                                        child: Card(
                                          child: ListTile(
                                            leading: smallAvatar(
                                                image: contatoController.image),
                                            title: Text(
                                              contatoController.contato.nome ??
                                                  '',
                                            ),
                                            trailing: Text(
                                                contatoController.contato.tel ??
                                                    '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                )),
                    ],
                  ),
                // TODO: Handle this case.
                Status.start => const Center(),
                Status.error => Center(
                      child: Card(
                    elevation: 5,
                    child: Container(
                      color: Colors.greenAccent,
                      height: 100,
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Error ao Carregar'),
                          ElevatedButton(
                              onPressed: () =>
                                  contatosController.updateListContato(),
                              child: const Text('Tente Novamente')),
                        ],
                      ),
                    ),
                  ))
              },
            ),
          )),
    );
  }
}
