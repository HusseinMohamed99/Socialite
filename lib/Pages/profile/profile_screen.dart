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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        var cubit = SocialCubit.get(context);
        return Scaffold(
          backgroundColor:
              cubit.isDark ? Colors.white : const Color(0xff063750),
          appBar: AppBar(
            backgroundColor:
                cubit.isDark ? Colors.white : const Color(0xff063750),
            title: Text(
              'Profile',
              style: GoogleFonts.lobster(
                fontSize: 24,
                color: cubit.isDark ? Colors.blue : Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 240,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            children: [
                              Container(
                                decoration:  BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        '${userModel!.cover}'
                                      ),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      topRight: Radius.circular(8.0),
                                    )),
                                width: double.infinity,
                                height: 200,
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: cubit.isDark
                                      ? Colors.grey.shade50
                                      : const Color(0xff063750),
                                  child: IconButton(
                                    splashRadius: 1,
                                    onPressed: () {},
                                    icon: Icon(
                                      IconlyLight.camera,
                                      color: cubit.isDark
                                          ? Colors.black
                                          : Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
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
                              top: 90,
                              left: 90,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: cubit.isDark
                                    ? Colors.grey.shade50
                                    : const Color(0xff063750),
                                child: IconButton(
                                  splashRadius: 1,
                                  onPressed: () {},
                                  icon: Icon(
                                    IconlyLight.camera,
                                    color: cubit.isDark
                                        ? Colors.black
                                        : Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                  Row(
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
                          onPressed: () {},
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
                  myDivider2(),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'Posts',
                      style: GoogleFonts.lobster(
                        fontSize: 24,
                        color: cubit.isDark ? Colors.black : Colors.white,
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                  width: 220,
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
                    itemBuilder: (context, index) => (buildPostItem(context)),
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
}
