import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/model/post_model.dart';
import 'package:socialite/pages/post/edit_post.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';

Future<dynamic> moreOption(BuildContext context, SocialCubit cubit,
    String postId, PostModel postModel) {
  return showModalBottomSheet(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (postModel.uId == uId)
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
                iconData: IconlyBroken.editSquare,
                text: AppString.editPost,
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
              iconData: IconlyBroken.document,
              text: AppString.savePost,
            ),
            if (postModel.postImage != '')
              ShowModalSheetItems(
                function: () {
                  // cubit.saveToGallery(postModel.postImage!);
                },
                iconData: IconlyBroken.download,
                text: AppString.saveImage,
              ),
            ShowModalSheetItems(
              function: () {
                SocialCubit.get(context).createPost(
                  userName: SocialCubit.get(context).userModel!.name,
                  profileImage: SocialCubit.get(context).userModel!.image,
                  text: postModel.text!,
                  postImage: postModel.postImage,
                  dateTime: DateTime.now(),
                );
                showToast(
                  text: AppString.sharedPostSuccessfully,
                  state: ToastStates.success,
                );
              },
              iconData: IconlyBroken.upload,
              text: AppString.share,
            ),
            if (postModel.uId == cubit.userModel!.uId)
              ShowModalSheetItems(
                function: () {
                  cubit.deletePost(postId);
                },
                iconData: IconlyBroken.delete,
                text: AppString.deletePost,
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
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Row(
          children: [
            Icon(
              iconData,
              color: cubit.isDark
                  ? ColorManager.blackColor
                  : ColorManager.titanWithColor,
              size: 30,
            ),
            const SizedBox(width: 10),
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
