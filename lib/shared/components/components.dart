import 'package:socialite/shared/components/navigator.dart';
import 'package:flutter/material.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/color_manager.dart';

Widget baseAlertDialog({
  required context,
  String? title,
  String? content,
  String? outlinedButtonText,
  String? elevatedButtonText,
  IconData? elevatedButtonIcon,
}) {
  return AlertDialog(
    backgroundColor: SocialCubit.get(context).isDark
        ? ColorManager.titanWithColor
        : ColorManager.greyDarkColor,
    content: Padding(
      padding: const EdgeInsetsDirectional.only(start: 15, top: 15),
      child: Text(
        'Delete Message',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ),
    elevation: 8,
    contentPadding: const EdgeInsets.all(15),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.of(context).pop('DELETE FOR EVERYONE');
          },
          child: const Text('DELETE FOR EVERYONE')),
      TextButton(
          onPressed: () {
            Navigator.of(context).pop('DELETE FOR ME');
          },
          child: const Text('DELETE FOR ME')),
      TextButton(
          onPressed: () {
            pop(context);
          },
          child: const Text('CANCEL')),
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
