import 'package:f_app/Pages/profile/Edit_profile_screen.dart';
import 'package:f_app/model/user_model.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:f_app/shared/componnetns/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor:
                cubit.isDark ? Colors.white : const Color(0xff063750),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 240,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            decoration:  BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    '${userModel!.cover}'
                                  ),
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft:  Radius.circular(8.0),
                                  topRight:  Radius.circular(8.0),
                                )),
                            width: double.infinity,
                            height: 200,
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
                                onPressed: ()
                                {
                                  pop(context);
                                },
                                icon: CircleAvatar(
                                  backgroundColor:  Colors.black,
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
                      color: cubit.isDark ? Colors.blue : Colors.white,
                    ),
                  ),
                  space(0, 5),
                  Text(
                    '${userModel.bio}',
                    style: GoogleFonts.lobster(
                      textStyle: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                    ),
                  ),
                  space(0, 15),
                  Card(
                    margin:const EdgeInsets.symmetric(horizontal: 10),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue)),
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
                              backgroundColor: MaterialStateProperty.all(
                                cubit.isDark
                                    ? Colors.grey.shade400
                                    : const Color(0xff063750),
                              ),
                            ),
                            onPressed: ()
                            {
                              navigateTo(context, EditProfileScreen());
                            },
                            icon: Icon(
                              IconlyLight.edit,
                              color: cubit.isDark ? Colors.black : Colors.white,
                            ),
                            label: Text(
                              'Edit profile',
                              style: GoogleFonts.lobster(
                                color: cubit.isDark ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  myDivider2(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Posts',
                        style: GoogleFonts.lobster(
                          fontSize: 24,
                          color: cubit.isDark ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  space(0, 5),
                  Card(
                    color: SocialCubit.get(context).isDark
                        ? Colors.white
                        : const Color(0xff063750),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10,
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {},
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
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '\' What\'s on your mind ? \'',
                                      style: GoogleFonts.lobster(
                                        fontSize: 16,
                                        color: SocialCubit.get(context).isDark
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
                            onPressed: () {},
                            icon: Icon(
                              Icons.photo_library_outlined,
                              size: 30,
                              color: cubit.isDark
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
                    itemCount: 10,
                    separatorBuilder: (context, index) => space(0, 10),
                    itemBuilder: (context, index) => (buildPostItem(userModel,context)),
                  ),
                  space(0, 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget buildPostItem(UserModel userModel,context) {

    return Card(
      color: SocialCubit.get(context).isDark
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
                      '${userModel.image}',
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
                              '${userModel.name}',
                              style: GoogleFonts.lobster(
                                fontSize: 20,
                                height: 1.3,
                                color: SocialCubit.get(context).isDark
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
                        'May 15,2022 at 9:00 pm',
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
                    color: SocialCubit.get(context).isDark
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
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: const DecorationImage(
                    image: NetworkImage(
                    'https://img.freepik.com/free-photo/outdoor-portrait-happy-white-girl-posing-nature-photo-relaxed-lady-with-wavy-hair-standing-near-beautiful-rose-bush_197531-10489.jpg?w=996&t=st=1660093589~exp=1660094189~hmac=abd4a9f52ce9be8e9f6d38cc4e82d8d2de7ce55638fc37686d9d690789bbf775',
                    ),
                    fit: BoxFit.cover,
                  ),
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
                    '1200 Like',
                    style: GoogleFonts.lobster(
                      color: Colors.red,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.chat,
                    color: Colors.orangeAccent,
                  ),
                  label: Text(
                    '500 Comment',
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
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    '${userModel.image}'
                  ),
                ),
                space(10, 0),
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      'Write a comment ...',
                      style: GoogleFonts.lobster(
                        textStyle: Theme.of(context).textTheme.caption,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.heart,
                    color: Colors.red,
                  ),
                  label: Text(
                    'Like',
                    style: GoogleFonts.lobster(
                      color: Colors.red,
                    ),
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
}
