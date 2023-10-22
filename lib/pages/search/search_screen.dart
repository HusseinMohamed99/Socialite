import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';
import 'package:socialite/shared/widget/search_users.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<UserModel> foundUsers = [];

  @override
  initState() {
    // at the beginning, all users are shown
    foundUsers = SocialCubit.get(context).users;
    super.initState();
  }

  void runFilter(String enteredKeyword) {
    List<UserModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = SocialCubit.get(context).users;
    } else {
      results = SocialCubit.get(context)
          .users
          .where((user) =>
              user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              elevation: 2,
              title: TextFormField(
                maxLines: 1,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.titleLarge,
                enableSuggestions: true,
                scrollPhysics: const BouncingScrollPhysics(),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: AppString.search,
                  hintStyle: GoogleFonts.roboto(
                    color: ColorManager.greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                autocorrect: true,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return AppString.emptySearch;
                  }
                  return null;
                },
                onFieldSubmitted: (value) {},
                onChanged: (value) {
                  runFilter(value);
                },
              ),
            ),
            body: foundUsers.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) =>
                        SearchUsersItems(user: foundUsers[index]),
                    separatorBuilder: (context, index) =>
                        const MyDivider(vertical: AppPadding.p8),
                    itemCount: foundUsers.length,
                  )
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        IconlyBroken.search,
                        color: ColorManager.greyColor,
                        size: 60,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        AppString.noResult,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  )),
          ),
        );
      },
    );
  }
}
