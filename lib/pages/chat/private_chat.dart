import 'package:bubble/bubble.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/model/message_model.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/components/show_toast.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:socialite/shared/styles/color.dart';

class PrivateChatScreen extends StatelessWidget {
  final UserModel userModel;

  PrivateChatScreen({
    required this.userModel,
    Key? key,
  }) : super(key: key);
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ItemScrollController scroll = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(
          receiverId: userModel.uId,
        );

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {
            if (state is SendMessageSuccessState) {
              if (SocialCubit.get(context).messageImagePicked != null) {
                SocialCubit.get(context).removeMessageImage();
              }
              scroll.scrollTo(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  index: SocialCubit.get(context).message.length);
              textController.clear();
            }
            if (state is SavedToGallerySuccessState) {
              showToast(
                  text: "Downloaded to Gallery!", state: ToastStates.success);
            }
          },
          builder: (context, state) {
            SocialCubit cubit = SocialCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    pop(context);
                  },
                  icon: Icon(
                    IconlyBroken.arrowLeft2,
                    size: 30.sp,
                    color: cubit.isDark ? Colors.black : Colors.white,
                  ),
                ),
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 15.r,
                      child: ImageWithShimmer(
                        imageUrl: userModel.image,
                        width: 30.w,
                        height: 30.h,
                        radius: 15.r,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        userModel.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconlyBroken.video,
                      size: 24.sp,
                      color: cubit.isDark ? Colors.black : Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconlyBroken.call,
                      size: 24.sp,
                      color: cubit.isDark ? Colors.black : Colors.white,
                    ),
                  ),
                ],
                elevation: 1,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8).r,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: ScrollablePositionedList.separated(
                          initialScrollIndex:
                              SocialCubit.get(context).message.length,
                          itemScrollController: scroll,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message = cubit.message[index];
                            if (cubit.userModel!.uId == message.senderId) {
                              return BuildUserMessageItem(
                                messageModel: message,
                              );
                            } else {
                              return buildMessageItem(message, context);
                            }
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8.h),
                          itemCount: cubit.message.length,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      if (cubit.messageImagePicked != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 170.h,
                              decoration: BoxDecoration(
                                color: cubit.isDark
                                    ? AppMainColors.greyColor.withOpacity(0.5)
                                    : AppMainColors.greyDarkColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                ).r,
                                image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: FileImage(cubit.messageImagePicked!),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 20.r,
                              backgroundColor: AppMainColors.blueColor,
                              child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).removeMessageImage();
                                },
                                icon: Icon(
                                  IconlyBroken.closeSquare,
                                  size: 24.sp,
                                  color: AppMainColors.titanWithColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (state is UploadMessageImageLoadingState)
                        const Center(child: LinearProgressIndicator()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16).r,
                                border: Border.all(
                                  color:
                                      AppMainColors.greyColor.withOpacity(0.2),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: TextFormField(
                                  style: GoogleFonts.roboto(
                                    color: cubit.isDark
                                        ? AppMainColors.blackColor
                                        : AppMainColors.titanWithColor,
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  maxLines: 3,
                                  minLines: 1,
                                  controller: textController,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    counterStyle: const TextStyle(
                                      height: double.minPositive,
                                    ),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(12).r,
                                    hintText: "Type a message",
                                    hintStyle: GoogleFonts.roboto(
                                      color: AppMainColors.greyColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    border: InputBorder.none,
                                    prefixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Octicons.smiley,
                                        size: 20.sp,
                                        color: AppMainColors.greyColor,
                                      ),
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            SocialCubit.get(context)
                                                .getMessageImage();
                                          },
                                          icon: Icon(
                                            IconlyBroken.camera,
                                            size: 24.sp,
                                            color: AppMainColors.greyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Enter your message';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: cubit.isDark
                                  ? AppMainColors.blueColor
                                  : AppMainColors.titanWithColor,
                              shape: BoxShape.circle,
                            ),
                            child: MaterialButton(
                              minWidth: 1,
                              onPressed: () {
                                if (cubit.messageImagePicked == null &&
                                    formKey.currentState!.validate()) {
                                  cubit.sendMessage(
                                    receiverId: userModel.uId,
                                    dateTime: DateTime.now(),
                                    text: textController.text,
                                  );
                                  textController.clear();
                                  scroll.scrollTo(
                                      duration: const Duration(milliseconds: 1),
                                      curve: Curves.linearToEaseOut,
                                      index: cubit.message.length);
                                } else if (cubit.messageImagePicked != null) {
                                  SocialCubit.get(context).uploadMessageImage(
                                    receiverId: userModel.uId,
                                    datetime: DateTime.now(),
                                    text: textController.text,
                                  );
                                  textController.clear();
                                  cubit.removeMessageImage();
                                  scroll.scrollTo(
                                    duration: const Duration(milliseconds: 1),
                                    curve: Curves.linearToEaseOut,
                                    index: cubit.message.length,
                                  );
                                } else {}
                                cubit.sendFCMNotification(
                                  senderName: cubit.userModel!.name,
                                  messageText: textController.text,
                                  messageImage: cubit.imageURL,
                                  token: userModel.token,
                                );
                              },
                              child: Icon(
                                IconlyBroken.send,
                                color: cubit.isDark
                                    ? AppMainColors.titanWithColor
                                    : AppMainColors.blackColor,
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
      },
    );
  }

  Widget buildMessageItem(MessageModel messageModel, context) {
    SocialCubit cubit = SocialCubit.get(context);
    if (messageModel.messageImage == '') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage(
              userModel.image,
            ),
          ),
          Flexible(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
              child: Bubble(
                nip: BubbleNip.leftTop,
                color:
                    cubit.isDark ? Colors.blue : Colors.blue.withOpacity(0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      messageModel.text!,
                      style: GoogleFonts.libreBaskerville(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    space(0, 5),
                    Text(
                      daysBetween(
                          DateTime.parse(messageModel.dateTime.toString())),
                      style: GoogleFonts.roboto(
                        color: Colors.white70,
                        textStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else if (messageModel.messageImage != '' && messageModel.text != '') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 300,
            height: 290,
            clipBehavior: Clip.none,
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              ),
            ),
            child: Bubble(
              padding: const BubbleEdges.all(4),
              nip: BubbleNip.leftTop,
              color: cubit.isDark ? Colors.blue : Colors.blue.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.all(
                        Radius.circular(10),
                      ),
                    ),
                    width: 300,
                    height: 220,
                    child: InkWell(
                      onLongPress: () {
                        cubit.saveToGallery(messageModel.messageImage!);
                      },
                      onTap: () {
                        // navigateTo(
                        //     context,
                        //     ImageViewScreen(
                        //         image: messageModel.messageImage, body: ''));
                      },
                      child: Image(
                        image: NetworkImage(
                          '${messageModel.messageImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Column(
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          messageModel.text!,
                          style: GoogleFonts.libreBaskerville(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.7,
                          ),
                        ),
                        Text(
                          daysBetween(
                              DateTime.parse(messageModel.dateTime.toString())),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.grey,
                                    height: 2.2,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Align(
        alignment: AlignmentDirectional.bottomStart,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            InkWell(
              onLongPress: () {
                cubit.saveToGallery(messageModel.messageImage!);
              },
              onTap: () {
                // navigateTo(
                //     context,
                //     ImageViewScreen(
                //         image: messageModel.messageImage, body: ''));
              },
              child: Container(
                  width: 300,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(20),
                      topEnd: Radius.circular(20),
                      topStart: Radius.circular(20),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('${messageModel.messageImage}')),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                daysBetween(DateTime.parse(messageModel.dateTime.toString())),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class BuildUserMessageItem extends StatelessWidget {
  const BuildUserMessageItem({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    if (messageModel.messageImage == '') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 8, top: 5, bottom: 5).r,
              child: Bubble(
                nip: BubbleNip.rightBottom,
                color: cubit.isDark
                    ? AppColorsDark.primaryDarkColor
                    : AppMainColors.titanWithColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      messageModel.text!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: cubit.isDark
                                ? AppMainColors.titanWithColor
                                : AppMainColors.blackColor,
                          ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      daysBetween(
                          DateTime.parse(messageModel.dateTime.toString())),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppMainColors.greyColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 12.r,
            child: ImageWithShimmer(
              imageUrl: cubit.userModel!.image,
              width: 25.w,
              height: 25.h,
              radius: 25.r,
            ),
          ),
        ],
      );
    } else if (messageModel.messageImage != '' && messageModel.text != '') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 250.w,
            height: 225.h,
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ).r,
            ),
            child: Bubble(
              padding: const BubbleEdges.all(4),
              nip: BubbleNip.rightBottom,
              color: cubit.isDark
                  ? AppColorsDark.primaryDarkColor
                  : AppMainColors.titanWithColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ).r,
                    ),
                    width: 250.w,
                    height: 150.h,
                    child: InkWell(
                      onLongPress: () {
                        cubit.saveToGallery(messageModel.messageImage!);
                      },
                      onTap: () {
                        // navigateTo(
                        //     context,
                        //     ImageViewScreen(
                        //         image: messageModel.messageImage, body: ''));
                      },
                      child: Image(
                        image: NetworkImage(
                          '${messageModel.messageImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Column(
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          messageModel.text!,
                          style: GoogleFonts.libreBaskerville(
                            color: cubit.isDark ? Colors.white : Colors.black,
                            fontSize: 16,
                            height: 1.7,
                          ),
                        ),
                        Text(
                          daysBetween(
                              DateTime.parse(messageModel.dateTime.toString())),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color:
                                    cubit.isDark ? Colors.grey : Colors.black54,
                                height: 2.2,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            InkWell(
              onLongPress: () {
                cubit.saveToGallery(messageModel.messageImage!);
              },
              onTap: () {
                // navigateTo(
                //     context,
                //     ImageViewScreen(
                //         image: messageModel.messageImage, body: ''));
              },
              child: Container(
                  width: 300,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(20),
                      topEnd: Radius.circular(20),
                      topStart: Radius.circular(20),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('${messageModel.messageImage}')),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                daysBetween(DateTime.parse(messageModel.dateTime.toString())),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class BuildFriendMessageItem extends StatelessWidget {
  const BuildFriendMessageItem(
      {super.key, required this.messageModel, required this.userModel});
  final MessageModel messageModel;
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    if (messageModel.messageImage == '') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage(
              userModel.image,
            ),
          ),
          Flexible(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
              child: Bubble(
                nip: BubbleNip.leftTop,
                color:
                    cubit.isDark ? Colors.blue : Colors.blue.withOpacity(0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      messageModel.text!,
                      style: GoogleFonts.libreBaskerville(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    space(0, 5),
                    Text(
                      daysBetween(
                          DateTime.parse(messageModel.dateTime.toString())),
                      style: GoogleFonts.roboto(
                        color: Colors.white70,
                        textStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else if (messageModel.messageImage != '' && messageModel.text != '') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 300,
            height: 290,
            clipBehavior: Clip.none,
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              ),
            ),
            child: Bubble(
              padding: const BubbleEdges.all(4),
              nip: BubbleNip.leftTop,
              color: cubit.isDark ? Colors.blue : Colors.blue.withOpacity(0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.all(
                        Radius.circular(10),
                      ),
                    ),
                    width: 300,
                    height: 220,
                    child: InkWell(
                      onLongPress: () {
                        cubit.saveToGallery(messageModel.messageImage!);
                      },
                      onTap: () {
                        // navigateTo(
                        //     context,
                        //     ImageViewScreen(
                        //         image: messageModel.messageImage, body: ''));
                      },
                      child: Image(
                        image: NetworkImage(
                          '${messageModel.messageImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Column(
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          messageModel.text!,
                          style: GoogleFonts.libreBaskerville(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.7,
                          ),
                        ),
                        Text(
                          daysBetween(
                              DateTime.parse(messageModel.dateTime.toString())),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.grey,
                                    height: 2.2,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Align(
        alignment: AlignmentDirectional.bottomStart,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            InkWell(
              onLongPress: () {
                cubit.saveToGallery(messageModel.messageImage!);
              },
              onTap: () {
                // navigateTo(
                //     context,
                //     ImageViewScreen(
                //         image: messageModel.messageImage, body: ''));
              },
              child: Container(
                  width: 300,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(20),
                      topEnd: Radius.circular(20),
                      topStart: Radius.circular(20),
                    ),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('${messageModel.messageImage}')),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                daysBetween(DateTime.parse(messageModel.dateTime.toString())),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
