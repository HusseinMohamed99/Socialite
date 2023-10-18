import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/friend/friends_profile_screen.dart';
import 'package:socialite/pages/profile/user_profile_screen.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';

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
                  size: 30.sp,
                  color: cubit.isDark
                      ? ColorManager.blackColor
                      : ColorManager.titanWithColor,
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
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: ColorManager.blueColor),
                enableSuggestions: true,
                scrollPhysics: const BouncingScrollPhysics(),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: AppString.search,
                  hintStyle: GoogleFonts.roboto(
                    color: ColorManager.greyColor,
                    fontSize: 18.sp,
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
                        UsersBuilderItems(user: foundUsers[index]),
                    separatorBuilder: (context, index) => const MyDivider(),
                    itemCount: foundUsers.length,
                  )
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconlyBroken.search,
                        color: ColorManager.greyColor,
                        size: 60.sp,
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        AppString.noResult,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  )),
          );
        },
        listener: (context, state) {});
  }
}

class UsersBuilderItems extends StatelessWidget {
  const UsersBuilderItems({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              const UserProfileScreen(),
            );
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage: NetworkImage(
                user.image,
              ),
              child: ImageWithShimmer(
                imageUrl: user.image,
                width: 50.w,
                height: 50.h,
                radius: 25.r,
                boxFit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 10.w),
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
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    '${SocialCubit.get(context).users.length - 1} ${AppString.mutualFriends}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorManager.greyColor,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              IconlyBroken.user2,
              color: ColorManager.greyColor,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
