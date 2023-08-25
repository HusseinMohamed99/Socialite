import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/Pages/friend/friend_screen.dart';
import 'package:sociality/Pages/profile/edit_profile_screen.dart';
import 'package:sociality/Pages/viewPhoto/image_view.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/model/post_model.dart';
import 'package:sociality/model/user_model.dart';
import 'package:sociality/shared/components/my_divider.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/components/show_toast.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sociality/shared/styles/color.dart';
import 'package:sociality/shared/widget/build_post_item.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SavedToGalleryLoadingState) {
          Navigator.pop(context);
        }
        if (state is SavedToGallerySuccessState) {
          showToast(text: "Downloaded to Gallery!", state: ToastStates.success);
        }

        if (state is LikesSuccessState) {
          showToast(text: "Likes Success!", state: ToastStates.success);
        }

        if (state is DisLikesSuccessState) {
          showToast(text: "UnLikes Success!", state: ToastStates.warning);
        }
      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        SocialCubit cubit = SocialCubit.get(context);
        return SocialCubit.get(context).userModel == null
            ? Scaffold(
                body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      IconlyLight.infoSquare,
                      size: 100.sp,
                      color: AppMainColors.greyColor,
                    ),
                    Text(
                      'No Posts yet',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const CircularProgressIndicator(),
                  ],
                ),
              ))
            : AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                ),
                child: Scaffold(
                  body: cubit.userPosts.isEmpty
                      ? buildProfileWithOutPosts()
                      : ConditionalBuilder(
                          condition: cubit.userPosts.isNotEmpty,
                          builder: (BuildContext context) =>
                              SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 220.h,
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                            ).r,
                                          ),
                                          width: double.infinity,
                                          height: 230,
                                          child: imagePreview(
                                            userModel!.cover,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          navigateTo(
                                              context,
                                              ImageViewScreen(
                                                  image: cubit.userModel!.image,
                                                  body: ''));
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 75,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              userModel.image,
                                            ),
                                            radius: 70,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 60,
                                        left: 5,
                                        child: IconButton(
                                          onPressed: () {
                                            pop(context);
                                          },
                                          icon: const CircleAvatar(
                                            backgroundColor: Colors.black,
                                            child: Icon(
                                              IconlyLight.arrowLeft2,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                space(0, 5),
                                Text(
                                  userModel.name,
                                  style: GoogleFonts.libreBaskerville(
                                    fontSize: 20,
                                    color: cubit.isDark
                                        ? Colors.blue
                                        : Colors.white,
                                  ),
                                ),
                                space(0, 5),
                                Text(
                                  userModel.bio,
                                  style: GoogleFonts.libreBaskerville(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                  ),
                                ),
                                space(0, 15),
                                Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  color: Colors.grey[100],
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              '${cubit.userPosts.length}',
                                              style: GoogleFonts.roboto(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(fontSize: 20),
                                              ),
                                            ),
                                            Text(
                                              'Posts',
                                              style:
                                                  GoogleFonts.libreBaskerville(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontSize: 16,
                                                        color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              '10K',
                                              style:
                                                  GoogleFonts.libreBaskerville(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(fontSize: 20),
                                              ),
                                            ),
                                            Text(
                                              'Followers',
                                              style:
                                                  GoogleFonts.libreBaskerville(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        fontSize: 16,
                                                        color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            navigateTo(
                                                context,
                                                FriendsScreen(
                                                  cubit.friends,
                                                  myFriends: true,
                                                ));
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                '${cubit.friends.length}',
                                                style: GoogleFonts
                                                    .libreBaskerville(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(fontSize: 20),
                                                ),
                                              ),
                                              Text(
                                                'Friends',
                                                style: GoogleFonts
                                                    .libreBaskerville(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                space(0, 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextButton.icon(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.blue)),
                                          onPressed: () {
                                            cubit.getStoryImage(context);
                                          },
                                          icon: const Icon(
                                            IconlyLight.plus,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            'Add story',
                                            style: GoogleFonts.libreBaskerville(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      space(20, 0),
                                      Expanded(
                                        child: TextButton.icon(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              cubit.isDark
                                                  ? Colors.grey.shade400
                                                  : const Color(0xff404258),
                                            ),
                                          ),
                                          onPressed: () {
                                            navigateTo(
                                                context, EditProfileScreen());
                                          },
                                          icon: Icon(
                                            IconlyLight.edit,
                                            color: cubit.isDark
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                          label: Text(
                                            'Edit profile',
                                            style: GoogleFonts.libreBaskerville(
                                              color: cubit.isDark
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const MyDivider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      'Posts',
                                      style: GoogleFonts.roboto(
                                        fontSize: 24,
                                        color: cubit.isDark
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                space(0, 10),
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cubit.userPosts.length,
                                  separatorBuilder: (context, index) =>
                                      space(0, 10),
                                  itemBuilder: (context, index) =>
                                      (BuildPostItem(
                                    postModel: cubit.userPosts[index],
                                    userModel: cubit.userModel!,
                                    index: index,
                                  )),
                                ),
                                space(0, 10),
                              ],
                            ),
                          ),
                          fallback: (BuildContext context) => Center(
                            child: AdaptiveIndicator(
                              os: getOs(),
                            ),
                          ),
                        ),
                ),
              );
      },
    );
  }
}

Widget buildProfileWithOutPosts() => Builder(builder: (context) {
      var cubit = SocialCubit.get(context);
      var userModel = SocialCubit.get(context).userModel;
      List<PostModel>? posts = SocialCubit.get(context).userPosts;
      List<UserModel>? friends = SocialCubit.get(context).friends;

      return Column(
        children: [
          SizedBox(
            height: 240,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                InkWell(
                  onTap: () {
                    ///view Photo
                    // Navigator.push(
                    //     context, MaterialPageRoute(builder: (context) => view()));
                  },
                  child: Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(userModel!.cover),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          )),
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 65,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      userModel.image,
                    ),
                    radius: 60,
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 5,
                  child: IconButton(
                    onPressed: () {
                      pop(context);
                    },
                    icon: const CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(
                        IconlyLight.arrowLeft2,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          space(0, 5),
          Text(
            userModel.name,
            style: GoogleFonts.roboto(
              fontSize: 24,
              color: cubit.isDark ? Colors.blue : Colors.white,
            ),
          ),
          space(0, 5),
          Text(
            userModel.bio,
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
            ),
          ),
          space(0, 15),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${posts.length}',
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      Text(
                        'Posts',
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '10K',
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      Text(
                        'Followers',
                        style: GoogleFonts.roboto(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      navigateTo(
                          context,
                          FriendsScreen(
                            friends,
                            myFriends: true,
                          ));
                    },
                    child: Column(
                      children: [
                        Text(
                          '${friends.length}',
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 20),
                          ),
                        ),
                        Text(
                          'Friends',
                          style: GoogleFonts.roboto(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          space(0, 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () {
                      cubit.getStoryImage(context);
                    },
                    icon: const Icon(
                      IconlyLight.plus,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Add story',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                space(20, 0),
                Expanded(
                  child: TextButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        cubit.isDark
                            ? Colors.grey.shade400
                            : const Color(0xff404258),
                      ),
                    ),
                    onPressed: () {
                      navigateTo(context, EditProfileScreen());
                    },
                    icon: Icon(
                      IconlyLight.edit,
                      color: cubit.isDark ? Colors.black : Colors.white,
                    ),
                    label: Text(
                      'Edit profile',
                      style: GoogleFonts.roboto(
                        color: cubit.isDark ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const MyDivider(),
          const Spacer(),
          const Icon(
            IconlyLight.infoSquare,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'No Posts yet',
            style: GoogleFonts.libreBaskerville(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
        ],
      );
    });
