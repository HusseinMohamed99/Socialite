import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:f_app/Pages/addPost/addPostScreen.dart';
import 'package:f_app/Pages/profile/Edit_profile_screen.dart';
import 'package:f_app/model/post_model.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:f_app/shared/componnetns/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';
import '../comment/comment_screen.dart';
import '../veiw_photo/image_view.dart';
import '../veiw_photo/post_view.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context)
          .getMyPosts(SocialCubit.get(context).userModel!.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<PostModel>? userPosts = SocialCubit.get(context).userPosts;
          var userModel = SocialCubit.get(context).userModel;
          var cubit = SocialCubit.get(context);
          return SocialCubit.get(context).userModel == null
              ? Scaffold(
              backgroundColor:
              cubit.isLight ? Colors.white : const Color(0xff063750),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                    const CircularProgressIndicator(),
                  ],
                ),
              )):
            userPosts!.isEmpty
              ? SafeArea(
                child: Scaffold(
                 backgroundColor:
                 cubit.isLight ? Colors.white : const Color(0xff063750),
                    body: buildProfileWithOutPosts(),
                  ),
              )
              : ConditionalBuilder(
                  condition: userPosts.isNotEmpty,
                  builder: (BuildContext context) => SafeArea(
                    child: Scaffold(
                      backgroundColor:
                          cubit.isLight ? Colors.white : const Color(0xff063750),
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 280,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  InkWell(
                                    onTap: ()
                                    {
                                      navigateTo(context, ImageViewScreen(image: cubit.userModel!.cover, body: ''));

                                    },
                                    child: Align(
                                      alignment: AlignmentDirectional.topCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  '${userModel!.cover}'),
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            )),
                                        width: double.infinity,
                                        height: 230,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()
                                    {
                                      navigateTo(context, ImageViewScreen(image: cubit.userModel!.image, body: ''));

                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 75,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          '${userModel.image}',
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
                              '${userModel.name}',
                              style: GoogleFonts.lobster(
                                fontSize: 24,
                                color:
                                    cubit.isLight ? Colors.blue : Colors.white,
                              ),
                            ),
                            space(0, 5),
                            Text(
                              '${userModel.bio}',
                              style: GoogleFonts.lobster(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                              ),
                            ),
                            space(0, 15),
                            Card(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.grey[100],
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '100',
                                          style: GoogleFonts.lobster(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                        Text(
                                          'Friends',
                                          style: GoogleFonts.lobster(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '100',
                                          style: GoogleFonts.lobster(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                        Text(
                                          'Posts',
                                          style: GoogleFonts.lobster(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '100',
                                          style: GoogleFonts.lobster(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                        Text(
                                          'Photos',
                                          style: GoogleFonts.lobster(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            space(0, 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextButton.icon(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue)),
                                      onPressed: () {},
                                      icon: const Icon(
                                        IconlyLight.plus,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Add to story',
                                        style: GoogleFonts.lobster(
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
                                          cubit.isLight
                                              ? Colors.grey.shade400
                                              : const Color(0xff063750),
                                        ),
                                      ),
                                      onPressed: () {
                                        navigateTo(
                                            context, EditProfileScreen());
                                      },
                                      icon: Icon(
                                        IconlyLight.edit,
                                        color: cubit.isLight
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      label: Text(
                                        'Edit profile',
                                        style: GoogleFonts.lobster(
                                          color: cubit.isLight
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            myDivider2(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  'Posts',
                                  style: GoogleFonts.lobster(
                                    fontSize: 24,
                                    color: cubit.isLight
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            space(0, 5),
                            Card(
                              color: SocialCubit.get(context).isLight
                                  ? Colors.white
                                  : const Color(0xff063750),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 10,
                              margin: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: ()
                                      {
                                        navigateTo(context, AddPostScreen());
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                              '${userModel.image}',
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            height: 50,
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '\' What\'s on your mind ? \'',
                                                style: GoogleFonts.lobster(
                                                  fontSize: 16,
                                                  color:
                                                      SocialCubit.get(context)
                                                              .isLight
                                                          ? Colors.black
                                                          : Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 2,
                                      height: 50,
                                      color: Colors.grey,
                                    ),
                                    IconButton(
                                      onPressed: ()
                                      {
                                        cubit.getPostImage();
                                        navigateTo(context, AddPostScreen());
                                      },
                                      icon: Icon(
                                        Icons.photo_library_outlined,
                                        size: 30,
                                        color: cubit.isLight
                                            ? CupertinoColors.activeBlue
                                            : Colors.white,
                                      ),
                                      splashRadius: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            space(0, 10),
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: userPosts.length,
                              separatorBuilder: (context, index) =>
                                  space(0, 10),
                              itemBuilder: (context, index) =>
                                  (buildPostItem(userPosts[index], context,index)),
                            ),
                            space(0, 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  fallback: (BuildContext context) =>
                      const CircularProgressIndicator(),
                );
        },
      );
    });
  }
}
Widget buildProfileWithOutPosts () => Builder(
  builder: (context) {

    var userModel = SocialCubit.get(context).userModel;
    var cubit = SocialCubit.get(context);
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
                          image: NetworkImage(
                              '${userModel!.cover}'),
                        ),
                        borderRadius:
                        const BorderRadius.only(
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
                    '${userModel.image}',
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
          '${userModel.name}',
          style: GoogleFonts.lobster(
            fontSize: 24,
            color:
            cubit.isLight ? Colors.blue : Colors.white,
          ),
        ),
        space(0, 5),
        Text(
          '${userModel.bio}',
          style: GoogleFonts.lobster(
            textStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        space(0, 15),
        Card(
          margin:
          const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.grey[100],
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '100',
                      style: GoogleFonts.lobster(
                        textStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    Text(
                      'Friends',
                      style: GoogleFonts.lobster(
                        textStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '100',
                      style: GoogleFonts.lobster(
                        textStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    Text(
                      'Posts',
                      style: GoogleFonts.lobster(
                        textStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '100',
                      style: GoogleFonts.lobster(
                        textStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    Text(
                      'Photos',
                      style: GoogleFonts.lobster(
                        textStyle: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        space(0, 15),
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(
                          Colors.blue)),
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.plus,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Add to story',
                    style: GoogleFonts.lobster(
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
                      cubit.isLight
                          ? Colors.grey.shade400
                          : const Color(0xff063750),
                    ),
                  ),
                  onPressed: () {
                    navigateTo(
                        context, EditProfileScreen());
                  },
                  icon: Icon(
                    IconlyLight.edit,
                    color: cubit.isLight
                        ? Colors.black
                        : Colors.white,
                  ),
                  label: Text(
                    'Edit profile',
                    style: GoogleFonts.lobster(
                      color: cubit.isLight
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        myDivider2(),
        const Spacer(),
        const Icon(
          IconlyLight.infoSquare,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          'No Posts yet', style: GoogleFonts.libreBaskerville(
          fontWeight: FontWeight.w700,
          fontSize: 30,
          color:  Colors.grey,
        ),),
        const Spacer(),
      ],
    );
  }
);

Widget buildPostItem(PostModel postModel, context,index) {

  return Card(
    color: SocialCubit.get(context).isLight
        ? Colors.white
        : const Color(0xff063750),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(25),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    '${postModel.image}',
                  ),
                ),
              ),
              space(15, 0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Text(
                            '${postModel.name}',
                            style: GoogleFonts.lobster(
                              fontSize: 20,
                              height: 1.3,
                              color: SocialCubit.get(context).isLight
                                  ? CupertinoColors.activeBlue
                                  : Colors.white,
                            ),
                          ),
                        ),
                        space(5, 0),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ],
                    ),
                    Text(
                      daysBetween(
                          DateTime.parse(postModel.dateTime.toString())),
                      style: GoogleFonts.lobster(
                          fontSize: 15,
                          color: Colors.grey,
                          textStyle: Theme.of(context).textTheme.caption,
                          height: 1.3),
                    ),
                  ],
                ),
              ),
              space(15, 0),
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: Icon(
                  IconlyLight.moreCircle,
                  size: 25,
                  color: SocialCubit.get(context).isLight
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              color: Colors.grey[300],
              height: 2,
              width: double.infinity,
            ),
          ),
          Text(
            '${postModel.text}',
            style: GoogleFonts.libreBaskerville(
              color:
                  SocialCubit.get(context).isLight ? Colors.black : Colors.white,
            ),
          ),
          space(0, 12),
          if (postModel.postImage != '')
            InkWell(
              onTap: ()
              {
                navigateTo(context, FullScreen(postModel,index: index,));

              },
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      height: 400,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            // blurRadius: 0,
                            // spreadRadius: 0,
                            // offset: Offset(0, 0)
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                            image: NetworkImage('${postModel.postImage}'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.heart,
                  color: Colors.red,
                ),
                label: Text(
                  '${SocialCubit.get(context).likes[index]}',
                  style: GoogleFonts.lobster(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: ()
                {
                  navigateTo(context, CommentsScreen(SocialCubit.get(context).postsId[index],postModel.uId,));

                },
                icon: const Icon(
                  IconlyLight.chat,
                  color: Colors.orangeAccent,
                ),
                label: Text(
                  '${SocialCubit.get(context).commentsNum[index]}',
                  style: GoogleFonts.lobster(
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Container(
              color: Colors.grey[300],
              height: 2,
              width: double.infinity,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  navigateTo(context, const MyProfileScreen());
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('${postModel.image}'),
                ),
              ),
              space(10, 0),
              InkWell(
                onTap: ()
                {
                  navigateTo(context, CommentsScreen(SocialCubit.get(context).postsId[index],postModel.uId,));

                },
                child: SizedBox(
                  width: 150,
                  child: Text(
                    'Write a comment ...',
                    style: GoogleFonts.lobster(
                      textStyle: Theme.of(context).textTheme.caption,
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  if (SocialCubit.get(context).likedByMe[index] == true) {
                    SocialCubit.get(context)
                        .disLikePost(SocialCubit.get(context).postsId[index]);
                    SocialCubit.get(context).likedByMe[index] = false;
                    SocialCubit.get(context).likes[index]--;
                  } else {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsId[index]);
                    SocialCubit.get(context).likedByMe[index] = true;
                    SocialCubit.get(context).likes[index]++;
                  }
                },
                label: Text(
                  'Like',
                  style: GoogleFonts.lobster(
                    color: SocialCubit.get(context).likedByMe[index] == true
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
                icon: Icon(
                  IconlyLight.heart,
                  color: SocialCubit.get(context).likedByMe[index] == true
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.upload,
                  color: Colors.green,
                ),
                label: Text(
                  'Share',
                  style: GoogleFonts.lobster(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

