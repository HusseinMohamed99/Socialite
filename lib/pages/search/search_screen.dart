import 'package:sociality/model/user_model.dart';
import 'package:sociality/pages/friend/profile_screen.dart';
import 'package:sociality/pages/profile/my_profile_screen.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/components/components.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              elevation: 2,
              leading: IconButton(
                icon: Icon(
                  IconlyBroken.arrowLeft2,
                  color: cubit.isLight ? const Color(0xff404258) : Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: TextFormField(
                maxLines: 1,
                autofocus: true,
                keyboardType: TextInputType.text,
                enableInteractiveSelection: true,
                style: GoogleFonts.libreBaskerville(
                  color: SocialCubit.get(context).isLight
                      ? Colors.black
                      : Colors.white,
                ),
                enableSuggestions: true,
                scrollPhysics: const BouncingScrollPhysics(),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: GoogleFonts.libreBaskerville(
                    color: SocialCubit.get(context).isLight
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
                autocorrect: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The search can\'t be empty';
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
                        singleUserBuilder(foundUsers[index], context),
                    separatorBuilder: (context, index) => space(0, 0),
                    itemCount: foundUsers.length)
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        IconlyLight.search,
                        color: Colors.grey,
                        size: 60,
                      ),
                      space(0, 15),
                      Text(
                        'No result is found !',
                        style: GoogleFonts.libreBaskerville(
                          color: SocialCubit.get(context).isLight
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ],
                  )),
          );
        },
        listener: (context, state) {});
  }

  Widget singleUserBuilder(UserModel user, BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12).r,
        child: InkWell(
          onTap: () {
            if (user.uId != SocialCubit.get(context).userModel!.uId) {
              navigateTo(
                context,
                FriendsProfileScreen(user.uId),
              );
              SocialCubit.get(context).getFriendsProfile(user.uId);
            } else {
              navigateTo(
                context,
                const MyProfileScreen(),
              );
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  user.image,
                ),
              ),
              space(10, 0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.libreBaskerville(
                        color: SocialCubit.get(context).isLight
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    space(0, 5),
                    Text(
                      '${SocialCubit.get(context).users.length - 1} mutual friends',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 9,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyBroken.user2,
                    color: Colors.grey,
                  ))
            ],
          ),
        ),
      );
}
