import 'package:f_app/Pages/profile/My_profile_screen.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:f_app/shared/componnetns/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/user_model.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';
import '../../shared/componnetns/constants.dart';
import '../addPost/addPostScreen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                color: SocialCubit.get(context).isDark
                    ? Colors.white
                    : const Color(0xff063750),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10,
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: ()
                        {
                          navigateTo(context, MyProfileScreen());
                        },
                        child:  CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            '${userModel!.image}'
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 220,
                          height: 50,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextButton(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.grey[300]),
                            ),
                            child: Text(
                              '\' What\'s on your mind ? \'',
                              style: GoogleFonts.lobster(
                                fontSize: 16,
                                color: SocialCubit.get(context).isDark
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            onPressed: ()
                            {
                              navigateTo(context, AddPostScreen());
                            },
                          ),
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
                itemBuilder: (context, index) => (buildPostItem(userModel,context)),),
              space(0, 10),
            ],
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
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
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
                            image: NetworkImage(
                              'https://img.freepik.com/free-photo/close-up-photo-sensual-blonde-woman-pink-sunglasses-hiding-green-leaf_197531-20666.jpg?w=996&t=st=1660179701~exp=1660180301~hmac=91b7894c159519c97b5e8953e1718a1ab374ad47f5abd0d5c00e871da5dacbab',
                            ),
                            fit: BoxFit.contain),
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
                InkWell(
                  onTap: ()
                  {
                    navigateTo(context, MyProfileScreen());
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                        '${userModel.image}'
                    ),
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
