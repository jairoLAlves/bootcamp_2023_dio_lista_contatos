import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

Widget textField(
  BuildContext context, {
  TextEditingController? controller,
  Widget? label,
  Widget? icon,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  TextInputType? keyboardType,
  FocusNode? focusNode,
  FocusNode? focusNodeNext,
}) {
  return TextFormField(
    onChanged: onChanged,
    keyboardType: keyboardType,
    validator: validator,
    controller: controller,
    focusNode: focusNode,
    onFieldSubmitted: (_) {
      focusNode?.unfocus();

      FocusScope.of(context).requestFocus(focusNodeNext);
    },
    decoration: InputDecoration(
      labelStyle:
          const TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      icon: icon,
      label: label,
      border: const OutlineInputBorder(),
    ),
  );
}

Widget cardActionContato({
  required String text,
  Widget? icon,
}) {
  return InkWell(
    onTap: () {},
    child: Card(
      elevation: 10,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: icon,
            ),
            Text(text),
          ],
        ),
      ),
    ),
  );
}

Widget successSave(BuildContext context) {
  return Container(
    color: Colors.green,
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: const Center(
      child: FaIcon(
        FontAwesomeIcons.check,
        color: Colors.white,
        size: 100,
      ),
    ),
  );
}
