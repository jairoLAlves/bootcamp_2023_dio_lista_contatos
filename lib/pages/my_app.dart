import 'package:bootcamp_2023_dio_lista_contatos/controller/contato_edit_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/controller/contatos_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/pages/lista_contatos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ContatosController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContatoEditController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista De Contatos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ListaContatos(),
      ),
    );
  }
}
