import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socialite/model/post_model.dart';
import 'package:socialite/pages/post/edit_post.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/styles/color.dart';

Future<dynamic> moreOption(BuildContext context, SocialCubit cubit,
    String postId, PostModel postModel) {
  return showModalBottomSheet(
    backgroundColor: cubit.isDark
        ? AppMainColors.titanWithColor
        : AppColorsDark.primaryDarkColor,
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)).r,
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(15.0).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (postModel.uId == cubit.userModel!.uId)
              ShowModalSheetItems(
                function: () {
                  navigateTo(
                    context,
                    EditPosts(
                      postModel: postModel,
                      postId: postId,
                    ),
                  );
                },
                iconData: Icons.edit_location_outlined,
                text: 'Edit Post',
              ),
            ShowModalSheetItems(
              function: () {
                // cubit.savePost(
                //     postId: postId,
                //     date: DateTime.now(),
                //     userName: model.name,
                //     userId: model.uId,
                //     userImage: model.image,
                //     postText: model.text,
                //     postImage: model.postImage);
              },
              iconData: Icons.turned_in_not_sharp,
              text: "Save Post",
            ),
            if (postModel.postImage != '')
              ShowModalSheetItems(
                function: () {
                  cubit.saveToGallery(postModel.postImage!);
                },
                iconData: IconlyLight.download,
                text: 'Saved Image',
              ),
            ShowModalSheetItems(
              function: () {},
              iconData: Icons.share,
              text: 'Share',
            ),
            if (postModel.uId == cubit.userModel!.uId)
              ShowModalSheetItems(
                function: () {
                  cubit.deletePost(postId);
                },
                iconData: Icons.delete,
                text: "Delete Post",
              ),
          ],
        ),
      );
    },
  );
}

class ShowModalSheetItems extends StatelessWidget {
  const ShowModalSheetItems({
    super.key,
    required this.iconData,
    required this.text,
    required this.function,
  });

  final IconData iconData;
  final String text;
  final void Function()? function;
  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    return InkWell(
      onTap: () {
        function!();
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
              iconData,
              color: cubit.isDark
                  ? AppMainColors.blackColor
                  : AppMainColors.titanWithColor,
              size: 30.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }
}
