import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociality/shared/components/components.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/shared/widget/build_post_item.dart';
import 'package:sociality/shared/widget/create_post.dart';
import 'package:sociality/shared/widget/sotry_widget.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SavedToGalleryLoadingState) {
          Navigator.pop(context);
        }
        if (state is SavedToGallerySuccessState) {
          showToast(text: "Downloaded to Gallery!", state: ToastStates.success);
        }
        if (state is LikesSuccessState) {
          showToast(text: "Likes Successfully!", state: ToastStates.success);
        }
        if (state is DisLikesSuccessState) {
          showToast(text: "UnLikes Successfully!", state: ToastStates.success);
        }
      },
      builder: (context, state) {
        //  var userModel = SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);
        return SocialCubit.get(context).posts.isEmpty
            ? Scaffold(
                body: Column(
                  children: [
                    ListOfStoryItem(cubit: cubit),
                    CreatePost(cubit: cubit),
                    const Spacer(),
                    Column(
                      children: [
                        Icon(
                          IconlyLight.infoSquare,
                          size: 100.sp,
                          color: Colors.grey,
                        ),
                        Text(
                          'No Posts yet',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              )
            : ConditionalBuilder(
                condition: cubit.posts.isNotEmpty,
                builder: (BuildContext context) => RefreshIndicator(
                  onRefresh: () async {
                    cubit.getPosts();
                    return cubit.getUserData();
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListOfStoryItem(cubit: cubit),
                        CreatePost(cubit: cubit),
                        space(0, 10.h),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cubit.posts.length,
                          separatorBuilder: (context, index) => space(0, 10.h),
                          itemBuilder: (context, index) => (BuildPostItem(
                            postModel: cubit.posts[index],
                            index: index,
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (BuildContext context) => Center(
                  child: AdaptiveIndicator(
                    os: getOs(),
                  ),
                ),
              );
      },
    );
  }

  // Widget buildPostItem(PostModel postModel, context, index) {
  //   late String postId;
  //   var cubit = SocialCubit.get(context);
  //   postId = SocialCubit.get(context).postsId[index];
  //   return Card(
  //     clipBehavior: Clip.antiAliasWithSaveLayer,
  //     elevation: 10,
  //     margin: const EdgeInsets.symmetric(horizontal: 8).r,
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                   if (postModel.uId !=
  //                       SocialCubit.get(context).userModel!.uId) {
  //                     navigateTo(
  //                       context,
  //                       FriendsProfileScreen(postModel.uId),
  //                     );
  //                     SocialCubit.get(context).getFriendsProfile(postModel.uId);
  //                   } else {
  //                     navigateTo(
  //                       context,
  //                       const MyProfileScreen(),
  //                     );
  //                   }
  //                 },
  //                 borderRadius: BorderRadius.circular(25).r,
  //                 child: CircleAvatar(
  //                   radius: 25.r,
  //                   backgroundImage: NetworkImage(
  //                     '${postModel.image}',
  //                   ),
  //                 ),
  //               ),
  //               space(15.w, 0),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         InkWell(
  //                           onTap: () {
  //                             if (postModel.uId !=
  //                                 SocialCubit.get(context).userModel!.uId) {
  //                               navigateTo(context,
  //                                   FriendsProfileScreen(postModel.uId));
  //                             } else {
  //                               navigateTo(
  //                                 context,
  //                                 const MyProfileScreen(),
  //                               );
  //                             }
  //                           },
  //                           child: Text(
  //                             '${postModel.name}',
  //                             style: GoogleFonts.roboto(
  //                               fontSize: 20.sp,
  //                               height: 1.3.h,
  //                               color: SocialCubit.get(context).isDark
  //                                   ? CupertinoColors.activeBlue
  //                                   : Colors.white,
  //                             ),
  //                           ),
  //                         ),
  //                         space(5.w, 0),
  //                         Icon(
  //                           Icons.check_circle,
  //                           color: Colors.blue,
  //                           size: 20.sp,
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       children: [
  //                         Icon(
  //                           LineariconsFree.earth,
  //                           size: 20.sp,
  //                           color: Colors.grey,
  //                         ),
  //                         space(10.w, 0),
  //                         Text(
  //                           daysBetween(
  //                               DateTime.parse(postModel.dateTime.toString())),
  //                           style: GoogleFonts.roboto(
  //                             fontSize: 15.sp,
  //                             color: Colors.grey,
  //                             textStyle: Theme.of(context).textTheme.bodySmall,
  //                             height: 1.3.h,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               space(15.w, 0),
  //               IconButton(
  //                 onPressed: () {
  //                   showModalBottomSheet(
  //                       context: context,
  //                       isScrollControlled: true,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: const BorderRadius.vertical(
  //                           top: Radius.circular(30),
  //                         ).r,
  //                       ),
  //                       builder: (context) {
  //                         return Padding(
  //                           padding: const EdgeInsets.all(15.0).r,
  //                           child: Column(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               if (postModel.uId == cubit.userModel!.uId)
  //                                 InkWell(
  //                                   onTap: () {
  //                                     navigateTo(
  //                                       context,
  //                                       EditPosts(
  //                                         postModel: postModel,
  //                                         postId: postId,
  //                                       ),
  //                                     );
  //                                   },
  //                                   child: Padding(
  //                                     padding: EdgeInsets.only(
  //                                       left: 8.r,
  //                                       right: 8.r,
  //                                       top: 20.r,
  //                                       bottom: 0.r,
  //                                     ),
  //                                     child: Row(
  //                                       children: [
  //                                         Icon(
  //                                           Icons.edit_location_outlined,
  //                                           color: cubit.isDark
  //                                               ? Colors.black
  //                                               : Colors.white,
  //                                           size: 30.sp,
  //                                         ),
  //                                         space(10.w, 0),
  //                                         Text(
  //                                           "Edit Post",
  //                                           style: TextStyle(
  //                                               color: cubit.isDark
  //                                                   ? Colors.black
  //                                                   : Colors.white,
  //                                               fontWeight: FontWeight.w600,
  //                                               fontSize: 20.sp),
  //                                         )
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                               InkWell(
  //                                 onTap: () {
  //                                   // cubit.savePost(
  //                                   //     postId: postId,
  //                                   //     date: DateTime.now(),
  //                                   //     userName: model.name,
  //                                   //     userId: model.uId,
  //                                   //     userImage: model.image,
  //                                   //     postText: model.text,
  //                                   //     postImage: model.postImage);
  //                                 },
  //                                 child: Padding(
  //                                   padding: EdgeInsets.only(
  //                                     left: 8.r,
  //                                     right: 8.r,
  //                                     top: 20.r,
  //                                     bottom: 0.r,
  //                                   ),
  //                                   child: Row(
  //                                     children: [
  //                                       Icon(
  //                                         Icons.turned_in_not_sharp,
  //                                         color: cubit.isDark
  //                                             ? Colors.black
  //                                             : Colors.white,
  //                                         size: 30.sp,
  //                                       ),
  //                                       space(10.w, 0),
  //                                       Text(
  //                                         "Save Post",
  //                                         style: TextStyle(
  //                                           color: cubit.isDark
  //                                               ? Colors.black
  //                                               : Colors.white,
  //                                           fontWeight: FontWeight.w600,
  //                                           fontSize: 20.sp,
  //                                         ),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                               if (postModel.postImage != '')
  //                                 InkWell(
  //                                   onTap: () {
  //                                     cubit.saveToGallery(postModel.postImage!);
  //                                   },
  //                                   child: Padding(
  //                                     padding: EdgeInsets.only(
  //                                       left: 8.r,
  //                                       right: 8.r,
  //                                       top: 20.r,
  //                                       bottom: 0.r,
  //                                     ),
  //                                     child: Row(
  //                                       children: [
  //                                         Icon(
  //                                           IconlyLight.download,
  //                                           color: cubit.isDark
  //                                               ? Colors.black
  //                                               : Colors.white,
  //                                           size: 30.sp,
  //                                         ),
  //                                         space(10.w, 0),
  //                                         Text(
  //                                           "Save Image",
  //                                           style: TextStyle(
  //                                             color: cubit.isDark
  //                                                 ? Colors.black
  //                                                 : Colors.white,
  //                                             fontWeight: FontWeight.w600,
  //                                             fontSize: 20.sp,
  //                                           ),
  //                                         )
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                               InkWell(
  //                                 onTap: () {},
  //                                 child: Padding(
  //                                   padding: EdgeInsets.only(
  //                                     left: 8.r,
  //                                     right: 8.r,
  //                                     top: 20.r,
  //                                     bottom: 0.r,
  //                                   ),
  //                                   child: Row(
  //                                     children: [
  //                                       Icon(
  //                                         Icons.share,
  //                                         color: cubit.isDark
  //                                             ? Colors.black
  //                                             : Colors.white,
  //                                         size: 30.sp,
  //                                       ),
  //                                       space(10.w, 0),
  //                                       Text(
  //                                         "Share",
  //                                         style: TextStyle(
  //                                           color: cubit.isDark
  //                                               ? Colors.black
  //                                               : Colors.white,
  //                                           fontWeight: FontWeight.w600,
  //                                           fontSize: 20.sp,
  //                                         ),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                               if (postModel.uId == cubit.userModel!.uId)
  //                                 InkWell(
  //                                   onTap: () {
  //                                     cubit.deletePost(postId);
  //                                   },
  //                                   child: Padding(
  //                                     padding: EdgeInsets.only(
  //                                       left: 8.r,
  //                                       right: 8.r,
  //                                       top: 20.r,
  //                                       bottom: 0.r,
  //                                     ),
  //                                     child: Row(
  //                                       children: [
  //                                         Icon(
  //                                           Icons.delete,
  //                                           color: cubit.isDark
  //                                               ? Colors.black
  //                                               : Colors.white,
  //                                           size: 30.sp,
  //                                         ),
  //                                         space(10.w, 0),
  //                                         Text(
  //                                           "Delete Post",
  //                                           style: TextStyle(
  //                                             color: cubit.isDark
  //                                                 ? Colors.black
  //                                                 : Colors.white,
  //                                             fontWeight: FontWeight.w600,
  //                                             fontSize: 20.sp,
  //                                           ),
  //                                         )
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                             ],
  //                           ),
  //                         );
  //                       });
  //                 },
  //                 icon: Icon(
  //                   IconlyLight.moreCircle,
  //                   size: 25.sp,
  //                   color: SocialCubit.get(context).isDark
  //                       ? Colors.black
  //                       : Colors.white,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 10.0).r,
  //             child: Container(
  //               color: Colors.grey[300],
  //               height: 2.h,
  //               width: double.infinity,
  //             ),
  //           ),
  //           Text(
  //             '${postModel.text}',
  //             style: GoogleFonts.libreBaskerville(
  //               color: SocialCubit.get(context).isDark
  //                   ? Colors.black
  //                   : Colors.white,
  //             ),
  //           ),
  //           space(0, 12.h),
  //           if (postModel.postImage != '')
  //             InkWell(
  //               onTap: () {
  //                 navigateTo(
  //                   context,
  //                   FullScreen(
  //                     postModel,
  //                     index: index,
  //                   ),
  //                 );
  //               },
  //               child: Stack(
  //                 alignment: AlignmentDirectional.topEnd,
  //                 children: [
  //                   Align(
  //                     alignment: AlignmentDirectional.bottomCenter,
  //                     child: Container(
  //                       height: 320,
  //                       width: double.infinity,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(4).r,
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.grey.withOpacity(0.4),
  //                           ),
  //                         ],
  //                       ),
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(15).r,
  //                         child: Image(
  //                           image: NetworkImage('${postModel.postImage}'),
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               TextButton.icon(
  //                 onPressed: () {
  //                   // navigateTo(context, LikesScreen(SocialCubit.get(context).postsId[index],postModel.uId));
  //                 },
  //                 icon: Icon(
  //                   IconlyLight.heart,
  //                   color: Colors.red,
  //                   size: 24.sp,
  //                 ),
  //                 label: Text(
  //                   SocialCubit.get(context).likes.isEmpty
  //                       ? ''
  //                       : '${SocialCubit.get(context).likes[index]}',
  //                   style: GoogleFonts.roboto(
  //                     color: Colors.red,
  //                   ),
  //                 ),
  //               ),
  //               TextButton.icon(
  //                 onPressed: () {
  //                   navigateTo(
  //                     context,
  //                     CommentsScreen(
  //                       SocialCubit.get(context).postsId[index],
  //                       postModel.uId,
  //                     ),
  //                   );
  //                 },
  //                 icon: Icon(
  //                   IconlyLight.chat,
  //                   color: Colors.orangeAccent,
  //                   size: 24.sp,
  //                 ),
  //                 label: Text(
  //                   '${SocialCubit.get(context).commentsNum[index]}',
  //                   style: GoogleFonts.roboto(
  //                     color: Colors.orangeAccent,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Container(
  //             color: Colors.grey[300],
  //             height: 1.h,
  //             width: double.infinity,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                   navigateTo(context, const MyProfileScreen());
  //                 },
  //                 child: CircleAvatar(
  //                   radius: 17.r,
  //                   backgroundImage:
  //                       NetworkImage(SocialCubit.get(context).userModel!.image),
  //                 ),
  //               ),
  //               space(8.w, 0),
  //               InkWell(
  //                 onTap: () {
  //                   navigateTo(
  //                     context,
  //                     CommentsScreen(
  //                       SocialCubit.get(context).postsId[index],
  //                       postModel.uId,
  //                     ),
  //                   );
  //                 },
  //                 child: SizedBox(
  //                   width: 120.w,
  //                   child: Text(
  //                     'Write a comment ...',
  //                     style: GoogleFonts.roboto(
  //                       textStyle: Theme.of(context).textTheme.bodySmall,
  //                       fontSize: 12.sp,
  //                       color: Colors.grey,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               TextButton.icon(
  //                 onPressed: () {
  //                   if (SocialCubit.get(context).likedByMe[index] == true) {
  //                     SocialCubit.get(context)
  //                         .disLikePost(SocialCubit.get(context).postsId[index]);
  //                     SocialCubit.get(context).likedByMe[index] = false;
  //                     SocialCubit.get(context).likes[index]--;
  //                   } else {
  //                     SocialCubit.get(context)
  //                         .likePost(SocialCubit.get(context).postsId[index]);
  //                     SocialCubit.get(context).likedByMe[index] = true;
  //                     SocialCubit.get(context).likes[index]++;
  //                   }
  //                 },
  //                 label: Text(
  //                   'Like',
  //                   style: GoogleFonts.roboto(color: Colors.amber
  //                       // color: SocialCubit.get(context).likedByMe[index] == true
  //                       //     ? Colors.red
  //                       //     : Colors.grey,
  //                       ),
  //                 ),
  //                 icon: Icon(
  //                   IconlyLight.heart,
  //                   color: SocialCubit.get(context).likedByMe[index] == true
  //                       ? Colors.red
  //                       : Colors.grey,
  //                   size: 24.sp,
  //                 ),
  //               ),
  //               TextButton.icon(
  //                 onPressed: () {},
  //                 icon: Icon(
  //                   IconlyLight.upload,
  //                   color: Colors.green,
  //                   size: 24.sp,
  //                 ),
  //                 label: Text(
  //                   'Share',
  //                   style: GoogleFonts.roboto(
  //                     color: Colors.green,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );

  // }
}
