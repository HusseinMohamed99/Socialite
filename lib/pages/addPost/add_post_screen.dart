import 'package:sociality/model/post_model.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/components/components.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key, this.postModel}) : super(key: key);
  final TextEditingController textController = TextEditingController();
  final PostModel? postModel;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    var userModel = SocialCubit.get(context).userModel!;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is CreatePostSuccessState) {
          cubit.getPosts();
          pop(context);
          showToast(
              text: 'Create Post Successfully', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                pop(context);
                cubit.removePostImage();
              },
              icon: Icon(
                IconlyLight.arrowLeft2,
                size: 30.sp,
                color: cubit.isLight ? Colors.black : Colors.white,
              ),
            ),
            titleSpacing: 1,
            title: Text(
              'Create Post',
              style: GoogleFonts.roboto(
                color: cubit.isLight ? Colors.blue : Colors.white,
                fontSize: 20.sp,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  DateTime now = DateTime.now();
                  if (textController.text.trim().isNotEmpty &&
                      cubit.postImagePicked == null) {
                    cubit.createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );

                    cubit.removePostImage();
                  } else if (cubit.postImagePicked != null) {
                    cubit.uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                    pop(context);
                    cubit.removePostImage();
                  } else {
                    pop(context);
                  }
                },
                child: Text(
                  'Post',
                  style: GoogleFonts.roboto(
                    color: cubit.isLight ? Colors.blue : Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ],
            elevation: 0,
          ),
          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is CreatePostLoadingState)
                        const LinearProgressIndicator(),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          20.r,
                          20.r,
                          20.r,
                          0.r,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 35.r,
                              backgroundImage: NetworkImage(
                                userModel.image,
                              ),
                            ),
                            space(10.w, 0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userModel.name,
                                  style: GoogleFonts.roboto(
                                    color: cubit.isLight
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                space(0, 8.h),
                                Row(
                                  children: [
                                    Icon(
                                      IconlyLight.user2,
                                      color: cubit.isLight
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    space(5.w, 0),
                                    Text(
                                      'public',
                                      style: GoogleFonts.roboto(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: Colors.grey,
                                              fontSize: 16.sp,
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
                      space(0, 10.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                        child: TextFormField(
                          maxLines: 6,
                          minLines: 1,
                          style: GoogleFonts.cairo(
                            height: 1.5.h,
                            color: cubit.isLight ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          controller: textController,
                          decoration: InputDecoration(
                            hintText: ' \' What\'s on your mind ? \' ',
                            hintStyle: GoogleFonts.roboto(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (SocialCubit.get(context).postImagePicked != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10).r,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: FileImage(cubit.postImagePicked!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.removePostImage();
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        blurRadius: 9.r,
                                        spreadRadius: 4.r,
                                        offset: const Offset(0, 4),
                                      )
                                    ]),
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: Colors.white,
                                    size: 24.sp,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      space(0, 50.h),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          cubit.isLight
                              ? Colors.white
                              : const Color(0xff404258),
                        ),
                      ),
                      onPressed: () {
                        cubit.getPostImage();
                      },
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      label: Text(
                        'Add photo'.toUpperCase(),
                        style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          color: cubit.isLight ? Colors.blue : Colors.white,
                        ),
                      ),
                      icon: Icon(
                        IconlyLight.image,
                        color: cubit.isLight ? Colors.blue : Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
