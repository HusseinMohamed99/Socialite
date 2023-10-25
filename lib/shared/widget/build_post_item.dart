import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialite/model/post_model.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/pages/comment/comment_screen.dart';
import 'package:socialite/pages/friend/friends_profile_screen.dart';
import 'package:socialite/pages/post_like/likes_screen.dart';
import 'package:socialite/pages/profile/user_profile_screen.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/components/my_divider.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/utils/value_manager.dart';
import 'package:socialite/shared/widget/more_options.dart';

class BuildPostItem extends StatelessWidget {
  const BuildPostItem({
    super.key,
    required this.postModel,
    required this.index,
    required this.userModel,
    required this.screenHeight,
    required this.screenWidth,
  });

  final PostModel postModel;
  final int index;
  final UserModel? userModel;
  final double screenHeight;
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    late String postId;
    postId = SocialCubit.get(context).postsId[index];
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          postMethod(context);
                        },
                        borderRadius: BorderRadius.circular(25),
                        child: CircleAvatar(
                          radius: 25,
                          child: ImageWithShimmer(
                            radius: 75,
                            imageUrl: postModel.image!,
                            width: 100,
                            height: 100,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    postMethod(context);
                                  },
                                  child: Text(
                                    postModel.name!,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  IconlyBold.tickSquare,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  daysBetween(
                                    DateTime.parse(
                                      postModel.dateTime.toString(),
                                    ),
                                  ),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      IconButton(
                        onPressed: () {
                          moreOption(context, cubit, postId, postModel);
                        },
                        icon: const Icon(
                          IconlyBroken.moreCircle,
                          color: ColorManager.greyColor,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
                    child: MyDivider(vertical: AppPadding.p2),
                  ),
                  Text(
                    '${postModel.text}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  if (postModel.postImage != '')
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: imagePostPreview(
                              '${postModel.postImage}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          cubit.getLikes(postId);
                          navigateTo(
                            context,
                            LikesScreen(
                              postID: SocialCubit.get(context).postsId[index],
                            ),
                          );
                        },
                        icon: const Icon(
                          IconlyBroken.heart,
                          color: ColorManager.redColor,
                        ),
                        label: Text(
                          '${postModel.likes}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: ColorManager.redColor),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          SocialCubit.get(context).getSinglePost(postId);
                          cubit.getComments(
                              SocialCubit.get(context).postsId[index]);
                          navigateTo(
                            context,
                            CommentsScreen(
                              likes: postModel.likes!,
                              postId: postModel.postId!,
                              postUid: postModel.uId!,
                            ),
                          );
                        },
                        icon: const Icon(
                          IconlyBroken.chat,
                          color: ColorManager.blueColor,
                        ),
                        label: Text(
                          '${postModel.comments}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: ColorManager.blueColor),
                        ),
                      ),
                    ],
                  ),
                  const MyDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          navigateTo(context, const UserProfileScreen());
                        },
                        child: CircleAvatar(
                          radius: 15,
                          child: userModel?.image != null
                              ? ImageWithShimmer(
                                  radius: 25,
                                  imageUrl: userModel!.image,
                                  width: 40,
                                  height: 40,
                                  boxFit: BoxFit.fill,
                                )
                              : const ImageWithShimmer(
                                  radius: 25,
                                  imageUrl:
                                      'https://img.freepik.com/free-vector/mysterious-mafia-man-smoking-cigarette_52683-34828.jpg?w=740&t=st=1692497461~exp=1692498061~hmac=4e76f888ce2372f12e339835e14f04b559236b4ae063439961923a24133f274b',
                                  width: 40,
                                  height: 40,
                                  boxFit: BoxFit.fill,
                                ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          SocialCubit.get(context).getSinglePost(postId);
                          SocialCubit.get(context).getComments(postId);
                          SocialCubit.get(context).getUserData();
                          navigateTo(
                            context,
                            CommentsScreen(
                              likes: postModel.likes!,
                              postId: postModel.postId!,
                              postUid: postModel.uId!,
                            ),
                          );
                        },
                        child: Text(
                          AppString.writeComment,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButton.icon(
                        onPressed: () async {
                          UserModel? postUser =
                              SocialCubit.get(context).userModel;
                          DateTime now = DateTime.now();
                          SocialCubit.get(context).likeByMe(
                            postUser: postUser,
                            context: context,
                            postModel: postModel,
                            postId: postId,
                            dataTime: now,
                          );
                        },
                        label: Text(
                          AppString.likes,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: ColorManager.greyColor,
                                  ),
                        ),
                        icon: const Icon(
                          IconlyBroken.heart,
                          color: ColorManager.greyColor,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          SocialCubit.get(context).createPost(
                            userName: SocialCubit.get(context).userModel!.name,
                            profileImage:
                                SocialCubit.get(context).userModel!.image,
                            text: postModel.text!,
                            postImage: postModel.postImage,
                            dateTime: DateTime.now(),
                          );
                          showToast(
                            text: AppString.sharedPostSuccessfully,
                            state: ToastStates.success,
                          );
                        },
                        icon: const Icon(
                          Icons.share,
                          color: ColorManager.greenColor,
                        ),
                        label: Text(
                          AppString.share,
                          style: GoogleFonts.roboto(
                            color: ColorManager.greenColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void postMethod(BuildContext context) {
    if (postModel.uId != uId) {
      SocialCubit.get(context).getFriendsProfile(postModel.uId);
      SocialCubit.get(context).getUserPosts(postModel.uId);
      navigateTo(
        context,
        FriendsProfileScreen(postModel.uId!),
      );
    } else {
      SocialCubit.get(context).getUserPosts(postModel.uId);
      SocialCubit.get(context).getUserData();

      navigateTo(
        context,
        const UserProfileScreen(),
      );
    }
  }
}
