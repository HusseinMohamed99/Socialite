import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:socialite/model/message_model.dart';
import 'package:socialite/shared/components/components.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/cubit/socialCubit/social_cubit.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:socialite/shared/utils/color_manager.dart';
import 'package:socialite/shared/widget/expandable_text_widget.dart';

class BuildOwnMessageItem extends StatelessWidget {
  const BuildOwnMessageItem({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    if (messageModel.messageImage == '') {
      return InkWell(
        onTap: () {
          cubit.showTimes();
        },
        onLongPress: () async {
          final result = await showDialog(
              context: context,
              builder: (context) => baseAlertDialog(context: context));
          switch (result) {
            case AppString.deleteForEveryOne:
              cubit.deleteForEveryone(
                  messageId: messageModel.messageId,
                  receiverId: messageModel.receiverId);
              break;
            case AppString.deleteForMe:
              cubit.deleteForMe(
                  messageId: messageModel.messageId,
                  receiverId: messageModel.receiverId);
              break;
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 8,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Bubble(
                    nip: BubbleNip.rightBottom,
                    color: cubit.isDark
                        ? ColorManager.primaryDarkColor
                        : ColorManager.titanWithColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          messageModel.text!,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: cubit.isDark
                                        ? ColorManager.titanWithColor
                                        : ColorManager.blackColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 12,
                  child: ImageWithShimmer(
                    imageUrl: cubit.userModel!.image,
                    width: 25,
                    height: 25,
                    radius: 25,
                  ),
                ),
              ],
            ),
            if (cubit.showTime)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  daysBetween(DateTime.parse(messageModel.dateTime.toString())),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorManager.greyColor,
                      ),
                ),
              ),
          ],
        ),
      );
    } else if (messageModel.messageImage != '' && messageModel.text != '') {
      return InkWell(
        onTap: () {
          cubit.showTimes();
        },
        onLongPress: () async {
          final result = await showDialog(
              context: context,
              builder: (context) => baseAlertDialog(context: context));
          switch (result) {
            case AppString.deleteForEveryOne:
              cubit.deleteForEveryone(
                  messageId: messageModel.messageId,
                  receiverId: messageModel.receiverId);
              break;
            case AppString.deleteForMe:
              cubit.deleteForMe(
                  messageId: messageModel.messageId,
                  receiverId: messageModel.receiverId);
              break;
          }
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    cubit.saveImageToGallery(
                        context, messageModel.messageImage!);
                  },
                  icon: const Icon(
                    IconlyBroken.download,
                  ),
                ),
                Container(
                  width: 250,
                  clipBehavior: Clip.none,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: Bubble(
                    padding: const BubbleEdges.all(4),
                    nip: BubbleNip.rightBottom,
                    color: cubit.isDark
                        ? ColorManager.primaryDarkColor
                        : ColorManager.titanWithColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          width: 250,
                          height: 150,
                          child: imagePreview(
                            '${messageModel.messageImage}',
                          ),
                        ),
                        const SizedBox(height: 5),
                        Column(
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: ExpandableText(
                                text: messageModel.text!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 12,
                  child: ImageWithShimmer(
                    imageUrl: cubit.userModel!.image,
                    width: 25,
                    height: 25,
                    radius: 25,
                  ),
                ),
              ],
            ),
            if (cubit.showTime)
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  daysBetween(DateTime.parse(messageModel.dateTime.toString())),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorManager.greyColor,
                      ),
                ),
              ),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          cubit.showTimes();
        },
        onLongPress: () async {
          final result = await showDialog(
              context: context,
              builder: (context) => baseAlertDialog(context: context));
          switch (result) {
            case AppString.deleteForEveryOne:
              cubit.deleteForEveryone(
                  messageId: messageModel.messageId,
                  receiverId: messageModel.receiverId);
              break;
            case AppString.deleteForMe:
              cubit.deleteForMe(
                  messageId: messageModel.messageId,
                  receiverId: messageModel.receiverId);
              break;
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    cubit.saveImageToGallery(
                        context, messageModel.messageImage!);
                  },
                  icon: const Icon(
                    IconlyBroken.download,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 8,
                    top: 5,
                    bottom: 5,
                  ),
                  child: Container(
                      width: 250,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorManager.greenColor,
                        ),
                      ),
                      child: imagePreview(
                        '${messageModel.messageImage}',
                      )),
                ),
                CircleAvatar(
                  radius: 12,
                  child: ImageWithShimmer(
                    imageUrl: cubit.userModel!.image,
                    width: 25,
                    height: 25,
                    radius: 25,
                  ),
                ),
              ],
            ),
            if (cubit.showTime)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  daysBetween(DateTime.parse(messageModel.dateTime.toString())),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorManager.greyColor,
                      ),
                ),
              ),
          ],
        ),
      );
    }
  }
}
