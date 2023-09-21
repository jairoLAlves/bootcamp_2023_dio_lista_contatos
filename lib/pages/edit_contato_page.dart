import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditContatoPage extends StatefulWidget {
  final Contato? contato;
  const EditContatoPage({super.key, this.contato});

  @override
  State<EditContatoPage> createState() => _EditContatoPageState();
}

class _EditContatoPageState extends State<EditContatoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FaIcon(
                  FontAwesomeIcons.x,
                  size: 15,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    emptyImage(),
                    TextButton(
                        onPressed: () {}, child: const Text('Adicionar imagem'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
