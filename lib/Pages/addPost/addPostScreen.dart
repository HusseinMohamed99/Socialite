import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/componnetns/components.dart';
import '../../shared/componnetns/constants.dart';

class AddPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  AddPostScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    var userModel = SocialCubit.get(context).userModel!;
    return Scaffold(
      backgroundColor: cubit.isDark ? Colors.white : const Color(0xff063750),
      appBar: AppBar(
        backgroundColor: cubit.isDark ? Colors.white : const Color(0xff063750),
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: Icon(
            IconlyLight.arrowLeft2,
            size: 30,
            color: cubit.isDark ? Colors.black : Colors.white,
          ),
        ),
        titleSpacing: 1,
        title: Text(
          'Create Post',
          style: GoogleFonts.lobster(
            color: cubit.isDark ? Colors.blue : Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Post',
              style: GoogleFonts.lobster(
                color: cubit.isDark ? Colors.blue : Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
        elevation: 5,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    20,
                    20,
                    20,
                    0,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          userModel.image!,
                        ),
                      ),
                      space(10, 0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userModel.name!,
                            style: GoogleFonts.lobster(
                              color: cubit.isDark ? Colors.black : Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          space(0, 8),
                          Row(
                            children: [
                              Icon(
                                IconlyLight.user2,
                                color: cubit.isDark ? Colors.black : Colors.white,
                              ),
                              space(5, 0),
                              Text(
                                'public',
                                style: GoogleFonts.lobster(
                                  textStyle:
                                      Theme.of(context).textTheme.caption!.copyWith(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                space(0, 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    maxLines: 5,
                    style: GoogleFonts.cairo(
                      height: 1.5,
                      color: cubit.isDark ? Colors.black : Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind? ',
                      hintStyle: GoogleFonts.lobster(
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                      border: InputBorder.none,

                    ),
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

                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  // blurRadius: 9,
                                  // spreadRadius: 4,
                                  // offset: Offset(0, 4)
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                                image: NetworkImage(
                                  'https://img.freepik.com/free-photo/enthusiastic-beautiful-girl-with-short-hairstyle-posing-with-kissing-face-expression-indoor-photo-gorgeous-romantic-woman-with-flowers-hair-isolated_197531-20580.jpg?w=360&t=st=1660176975~exp=1660177575~hmac=88c32690ca5d7eaf716996c376956968d776958df0f82e113be0cdfc138d9a09'
                                ),
                                fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                           // bloc.removePostImage();
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 9,
                                      spreadRadius: 4,
                                      offset: Offset(0, 4))
                                ]),
                            child: CircleAvatar(
                                backgroundColor: Theme.of(context)
                                    .scaffoldBackgroundColor,
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                )),
                          ))
                    ],
                  ),
                ),
                //Spacer(),

              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      cubit.isDark ? Colors.white : const Color(0xff063750),
                    ),
                  ),
                  onPressed: () {},
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  label: Text(
                    'Add photo'.toUpperCase(),
                    style: GoogleFonts.lobster(
                        fontSize: 20,
                        color: cubit.isDark ? Colors.blue : Colors.white),
                  ),
                  icon: Icon(
                    IconlyLight.image,
                    color: cubit.isDark ? Colors.blue : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
