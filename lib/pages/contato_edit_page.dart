import 'dart:io';

import 'package:bootcamp_2023_dio_lista_contatos/controller/contato_edit_controller.dart';
import 'package:bootcamp_2023_dio_lista_contatos/enums/enums.dart';
import 'package:bootcamp_2023_dio_lista_contatos/model/contato.dart';
import 'package:bootcamp_2023_dio_lista_contatos/widgets/widgets.dart';
import 'package:custom_image_crop/custom_image_crop.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class ContatoEditPage extends StatefulWidget {
  final Contato? contato;
  const ContatoEditPage({super.key, this.contato});

  @override
  State<ContatoEditPage> createState() => _ContatoEditPageState();
}

class _ContatoEditPageState extends State<ContatoEditPage> {
  late ContatoEditController contatoEditController;

  @override
  void initState() {
    contatoEditController = ContatoEditController(contato: widget.contato);
    contatoEditController.init();

    contatoEditController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    contatoEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: contatoEditController.status,
      builder: (context, status, _) {
        return SafeArea(
          child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.green,
                  actions: [
                    if (status == Status.start)
                      ValueListenableBuilder<bool>(
                        valueListenable: contatoEditController.onFocusChangeBtn,
                        builder: (context, isFocus, child) => ElevatedButton(
                          onFocusChange: (isFocus) {
                            contatoEditController.onFocusChangeBtn.value =
                                isFocus;
                          },
                          focusNode: contatoEditController.focusNodeBtn,
                          onPressed: () {
                            contatoEditController.onSave(context);
                          },
                          child: const Text(
                            'Salvar',
                          ),
                        ),
                      )
                  ],
                  leading: InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FaIcon(
                          FontAwesomeIcons.x,
                          size: 15,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pop((status == Status.success) ? true : false);
                      }),
                ),
                body: Center(
                  child: switch (status) {
                    Status.loading => const SpinKitCubeGrid(
                        color: Colors.greenAccent,
                        size: 50.0,
                      ),
                    Status.success => successSave(context),
                    Status.error => const Center(),
                    Status.start => Padding(
                        padding: const EdgeInsets.all(8),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ValueListenableBuilder(
                                          valueListenable:
                                              contatoEditController.photo,
                                          builder: (_, image, __) =>
                                              largeAvatar(image: image)),
                                      TextButton(
                                        onPressed: () async {
                                          PhotoIn? photoIn =
                                              await showMenu<PhotoIn>(
                                                  context: context,
                                                  position:
                                                      RelativeRect.fromLTRB(
                                                    0,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.3,
                                                    0,
                                                    0,
                                                  ),
                                                  items: [
                                                const CheckedPopupMenuItem(
                                                  value: PhotoIn.camera,
                                                  child: Row(
                                                    children: [
                                                      FaIcon(FontAwesomeIcons
                                                          .camera),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text('Camera')
                                                    ],
                                                  ),
                                                ),
                                                const CheckedPopupMenuItem(
                                                  value: PhotoIn.gallery,
                                                  child: Row(
                                                    children: [
                                                      FaIcon(FontAwesomeIcons
                                                          .images),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text('Galeria')
                                                    ],
                                                  ),
                                                ),
                                              ]);
                                          contatoEditController
                                              .capturaImage(photoIn)
                                              .then((file) async {
                                            if (file != null) {
                                              await showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  MemoryImage? image;

                                                  return SafeArea(
                                                      child: Scaffold(
                                                    body: Column(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              CustomImageCrop(
                                                            pathPaint: Paint()
                                                              ..color =
                                                                  Colors.black
                                                              ..strokeWidth =
                                                                  4.0
                                                              ..style =
                                                                  PaintingStyle
                                                                      .stroke
                                                              ..strokeJoin =
                                                                  StrokeJoin
                                                                      .round,
                                                            customProgressIndicator:
                                                                const CircularProgressIndicator(),
                                                            cropController:
                                                                contatoEditController
                                                                    .controllerCrop,
                                                            image: Image.file(
                                                              File(file.path),
                                                            ).image,
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .refresh),
                                                                onPressed:
                                                                    contatoEditController
                                                                        .controllerCrop
                                                                        .reset),
                                                            IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .zoom_in),
                                                                onPressed: () => contatoEditController
                                                                    .controllerCrop
                                                                    .addTransition(
                                                                        CropImageData(
                                                                            scale:
                                                                                1.33))),
                                                            IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .zoom_out),
                                                                onPressed: () => contatoEditController
                                                                    .controllerCrop
                                                                    .addTransition(
                                                                        CropImageData(
                                                                            scale:
                                                                                0.75))),
                                                            IconButton(
                                                                icon: const Icon(Icons
                                                                    .rotate_left),
                                                                onPressed: () => contatoEditController
                                                                    .controllerCrop
                                                                    .addTransition(CropImageData(
                                                                        angle: -math.pi /
                                                                            4))),
                                                            IconButton(
                                                                icon: const Icon(Icons
                                                                    .rotate_right),
                                                                onPressed: () => contatoEditController
                                                                    .controllerCrop
                                                                    .addTransition(CropImageData(
                                                                        angle: math.pi /
                                                                            4))),
                                                            IconButton(
                                                              icon: const Icon(
                                                                Icons.crop,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                image = await contatoEditController
                                                                    .controllerCrop
                                                                    .onCropImage();

                                                                if (image !=
                                                                    null) {
                                                                  contatoEditController
                                                                      .cropImage(
                                                                          image!);
                                                                  Navigator.of(
                                                                          ctx)
                                                                      .pop();
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .padding
                                                                    .bottom),
                                                      ],
                                                    ),
                                                  ));
                                                },
                                              );
                                            }
                                          });
                                        },
                                        child: const Text('Adicionar imagem'),
                                      )
                                    ],
                                  ),
                                ),
                                Form(
                                  key: contatoEditController.formKey,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        textField(
                                          context,
                                          validator: contatoEditController
                                              .validatorName,
                                          controller: contatoEditController
                                              .nomeController,
                                          label: const Text('Nome'),
                                          keyboardType: TextInputType.name,
                                          icon: const FaIcon(
                                              FontAwesomeIcons.user),
                                          focusNode: contatoEditController
                                              .focusNodeNome,
                                          focusNodeNext: contatoEditController
                                              .focusNodeSobreNome,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        textField(
                                          context,
                                          controller: contatoEditController
                                              .sobreNomeController,
                                          label: const Text('Sobre nome'),
                                          icon: const FaIcon(null),
                                          focusNode: contatoEditController
                                              .focusNodeSobreNome,
                                          focusNodeNext: contatoEditController
                                              .focusNodeTel,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InternationalPhoneNumberInput(
                                          onFieldSubmitted: (_) {
                                            contatoEditController.focusNodeTel
                                                ?.unfocus();
                                            FocusScope.of(context).requestFocus(
                                                contatoEditController
                                                    .focusNodeBtn);
                                          },
                                          focusNode: contatoEditController
                                              .focusNodeTel,

                                          onInputChanged: (PhoneNumber number) {
                                            // print(number.phoneNumber);
                                          },
                                          // onInputValidated: (bool value) {
                                          //   print(value);
                                          // },
                                          selectorConfig: const SelectorConfig(
                                            selectorType: PhoneInputSelectorType
                                                .BOTTOM_SHEET,
                                          ),
                                          ignoreBlank: false,
                                          autoValidateMode:
                                              AutovalidateMode.always,
                                          selectorTextStyle: const TextStyle(
                                              color: Colors.black),
                                          initialValue:
                                              contatoEditController.number,
                                          textFieldController:
                                              contatoEditController
                                                  .telController,
                                          formatInput: true,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                              signed: true, decimal: true),
                                          inputBorder:
                                              const OutlineInputBorder(),
                                          onSaved: (PhoneNumber number) {
                                            contatoEditController.number =
                                                number;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  },
                )),
          ),
        );
      },
    );
  }
}
