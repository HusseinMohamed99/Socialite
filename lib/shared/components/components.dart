import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:flutter/material.dart';

Widget baseAlertDialog({
  required context,
  String? title,
  String? content,
  String? outlinedButtonText,
  String? elevatedButtonText,
  IconData? elevatedButtonIcon,
}) {
  return AlertDialog(
    backgroundColor: SocialCubit.get(context).backgroundColor.withOpacity(1),
    title: Text(
      '$title',
      style: const TextStyle(color: Colors.red),
    ),
    titlePadding: const EdgeInsetsDirectional.only(start: 13, top: 15),
    content: Text(
      '$content',
      style: const TextStyle(
        color: Colors.grey,
      ),
    ),
    elevation: 8,
    contentPadding: const EdgeInsets.all(15),
    actions: [
      OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('$outlinedButtonText')),
      SizedBox(
        width: 115,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueAccent)),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(elevatedButtonIcon),
              const SizedBox(
                width: 5,
              ),
              Text('$elevatedButtonText',
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget searchBar({
  required context,
  bool readOnly = true,
  double height = 40,
  double width = double.infinity,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    height: height,
    width: width,
    child: TextFormField(
      readOnly: readOnly,
      style: const TextStyle(color: Colors.grey),
      // onTap: () => navigateTo(context, SearchScreen()),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        // fillColor: SocialCubit.get(context).unreadMessage,
        disabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        hintText: 'LocaleKeys.search.tr()',
        hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
      ),
    ),
  );
}
