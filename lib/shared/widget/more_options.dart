import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/model/post_model.dart';
import 'package:sociality/pages/post/edit_post.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:sociality/shared/components/navigator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';

Future<dynamic> moreOption(BuildContext context, SocialCubit cubit,
    String postId, PostModel postModel) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ).r,
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(15.0).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (postModel.uId == cubit.userModel!.uId)
                InkWell(
                  onTap: () {
                    navigateTo(
                      context,
                      EditPosts(
                        postModel: postModel,
                        postId: postId,
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8.r,
                      right: 8.r,
                      top: 20.r,
                      bottom: 0.r,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_location_outlined,
                          color: cubit.isDark ? Colors.black : Colors.white,
                          size: 30.sp,
                        ),
                        space(10.w, 0),
                        Text(
                          "Edit Post",
                          style: TextStyle(
                              color: cubit.isDark ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp),
                        )
                      ],
                    ),
                  ),
                ),
              InkWell(
                onTap: () {
                  // cubit.savePost(
                  //     postId: postId,
                  //     date: DateTime.now(),
                  //     userName: model.name,
                  //     userId: model.uId,
                  //     userImage: model.image,
                  //     postText: model.text,
                  //     postImage: model.postImage);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8.r,
                    right: 8.r,
                    top: 20.r,
                    bottom: 0.r,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.turned_in_not_sharp,
                        color: cubit.isDark ? Colors.black : Colors.white,
                        size: 30.sp,
                      ),
                      space(10.w, 0),
                      Text(
                        "Save Post",
                        style: TextStyle(
                          color: cubit.isDark ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (postModel.postImage != '')
                InkWell(
                  onTap: () {
                    cubit.saveToGallery(postModel.postImage!);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8.r,
                      right: 8.r,
                      top: 20.r,
                      bottom: 0.r,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          IconlyLight.download,
                          color: cubit.isDark ? Colors.black : Colors.white,
                          size: 30.sp,
                        ),
                        space(10.w, 0),
                        Text(
                          "Save Image",
                          style: TextStyle(
                            color: cubit.isDark ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8.r,
                    right: 8.r,
                    top: 20.r,
                    bottom: 0.r,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: cubit.isDark ? Colors.black : Colors.white,
                        size: 30.sp,
                      ),
                      space(10.w, 0),
                      Text(
                        "Share",
                        style: TextStyle(
                          color: cubit.isDark ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (postModel.uId == cubit.userModel!.uId)
                InkWell(
                  onTap: () {
                    cubit.deletePost(postId);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8.r,
                      right: 8.r,
                      top: 20.r,
                      bottom: 0.r,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: cubit.isDark ? Colors.black : Colors.white,
                          size: 30.sp,
                        ),
                        space(10.w, 0),
                        Text(
                          "Delete Post",
                          style: TextStyle(
                            color: cubit.isDark ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      });
}
