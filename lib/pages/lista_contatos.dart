import 'package:bootcamp_2023_dio_lista_contatos/controller/contatos_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/pages/contato_edit_page.dart';
import 'package:bootcamp_2023_dio_lista_contatos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({super.key});

  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  late final ContatosController contatosController;

  @override
  void initState() {
    super.initState();

    contatosController = context.read<ContatosController>();
    contatosController.updateListContato();
  }

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<ContatosController>();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: ()async {
          bool? result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContatoEditPage(contato: null),
                ));
           if(result ?? false){
             contatosController.updateListContato();
           }     
                
          },
          child: const FaIcon(FontAwesomeIcons.userPlus),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Lista De Contatos'),
        ),
        body: Column(
          children: [
            const Row(
              children: [
                //  Text('Campo de pesquisa'),
              ],
            ),
            Expanded(
                child: ValueListenableBuilder(
              valueListenable: controller.listContatos,
              builder: (context, contatos, _) {
                return (contatos.isEmpty)
                    ? const Center(
                        child: Text('Adicione novos contatos!'),
                      )
                    : ListView.builder(
                        itemCount: contatos.length,
                        itemBuilder: (context, index) {
                          Contato contato = contatos[index];

                          return contatoCard(contato, context);
                        },
                      );
              },
            )),
          ],
        ),
      ),
    );
  }
}
