import 'package:socialite/image_assets.dart';
import 'package:socialite/model/message_model.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/model/user_model.dart';
import 'package:socialite/shared/components/navigator.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/cubit/socialCubit/social_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/widget/friends_message_widget.dart';
import 'package:socialite/shared/widget/own_message_widget.dart';
import 'package:uuid/uuid.dart';

class PrivateChatScreen extends StatelessWidget {
  final UserModel userModel;

  PrivateChatScreen({
    required this.userModel,
    Key? key,
  }) : super(key: key);
  final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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

              textController.clear();
            }
          },
          builder: (context, state) {
            SocialCubit cubit = SocialCubit.get(context);
            var uuid = const Uuid();
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    cubit.isDark
                        ? Assets.imagesWhatsappBack
                        : Assets.imagesBackgroundImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      pop(context);
                    },
                    icon: Icon(
                      IconlyBroken.arrowLeft2,
                      color: cubit.isDark
                          ? ColorManager.blackColor
                          : ColorManager.whiteColor,
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
                          style: Theme.of(context).textTheme.titleMedium,
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
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              MessageModel message = cubit.message[index];
                              if (cubit.userModel!.uId == message.senderId) {
                                return BuildOwnMessageItem(
                                  messageModel: message,
                                );
                              } else {
                                return BuildFriendMessageItem(
                                  messageModel: message,
                                );
                              }
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemCount: cubit.message.length,
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (cubit.messageImagePicked != null)
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 170.h,
                                decoration: BoxDecoration(
                                  color: cubit.isDark
                                      ? ColorManager.greyColor.withOpacity(0.5)
                                      : ColorManager.greyDarkColor,
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
                                backgroundColor: ColorManager.blueColor,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .removeMessageImage();
                                  },
                                  icon: const Icon(
                                    IconlyBroken.closeSquare,
                                    color: ColorManager.titanWithColor,
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
                                        ColorManager.greyColor.withOpacity(0.2),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: TextFormField(
                                    style: GoogleFonts.roboto(
                                      color: cubit.isDark
                                          ? ColorManager.blackColor
                                          : ColorManager.titanWithColor,
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
                                      contentPadding:
                                          const EdgeInsets.all(12).r,
                                      hintText: AppString.message,
                                      hintStyle: GoogleFonts.roboto(
                                        color: ColorManager.greyColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      border: InputBorder.none,
                                      prefixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.emoji_emotions_outlined,
                                          size: 20.sp,
                                          color: ColorManager.greyColor,
                                        ),
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              SocialCubit.get(context)
                                                  .getMessageImage();
                                            },
                                            icon: Icon(
                                              IconlyBroken.camera,
                                              size: 24.sp,
                                              color: ColorManager.greyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return AppString.message;
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
                                    ? ColorManager.blueColor
                                    : ColorManager.titanWithColor,
                                shape: BoxShape.circle,
                              ),
                              child: MaterialButton(
                                minWidth: 1,
                                onPressed: () {
                                  sendMessageMethod(cubit, uuid, context);
                                },
                                child: Icon(
                                  IconlyBroken.send,
                                  color: cubit.isDark
                                      ? ColorManager.titanWithColor
                                      : ColorManager.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void sendMessageMethod(SocialCubit cubit, Uuid uuid, BuildContext context) {
    if (cubit.messageImagePicked == null && formKey.currentState!.validate()) {
      cubit.sendMessage(
        receiverId: userModel.uId,
        dateTime: DateTime.now(),
        text: textController.text,
        messageId: uuid.v4(),
      );
      textController.clear();
    } else if (cubit.messageImagePicked != null) {
      SocialCubit.get(context).uploadMessageImage(
        receiverId: userModel.uId,
        datetime: DateTime.now(),
        text: textController.text,
        messageId: uuid.v4(),
      );
      textController.clear();
      cubit.removeMessageImage();
    } else {}
    cubit.sendFCMNotification(
      senderName: cubit.userModel!.name,
      messageText: textController.text,
      messageImage: cubit.imageURL,
      token: userModel.token,
    );
  }
}
