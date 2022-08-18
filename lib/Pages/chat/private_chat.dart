import 'package:bubble/bubble.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:f_app/model/messageModel.dart';
import 'package:f_app/model/user_model.dart';
import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/componnetns/components.dart';
import '../../shared/componnetns/constants.dart';

class PrivateChatScreen extends StatelessWidget {
  UserModel userModel;
  PrivateChatScreen(
    this.userModel, {
    Key? key,
  }) : super(key: key);
  var textController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessage(
        receiverId: userModel.uId!,
      );

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);

          return Scaffold(
            backgroundColor:
                cubit.isDark ? Colors.white : const Color(0xff063750),
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor:
                    cubit.isDark ? Colors.white : const Color(0xff063750),
                statusBarIconBrightness:
                    cubit.isDark ? Brightness.dark : Brightness.light,
                statusBarBrightness:
                    cubit.isDark ? Brightness.dark : Brightness.light,
              ),
              backgroundColor:
                  cubit.isDark ? Colors.white : const Color(0xff063750),
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
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${userModel.image}',
                    ),
                  ),
                  space(15, 0),
                  Expanded(
                    child: Text(
                      '${userModel.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lobster(
                        color: cubit.isDark ? Colors.blue : Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  space(30, 0),
                ],
              ),
              elevation: 1,
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).message.isNotEmpty,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).message[index];
                            if (SocialCubit.get(context).userModel!.uId ==
                                message.senderId) {
                              return buildMyMessageItem(message, context);
                            } else {
                              return buildMessageItem(message, context);
                            }
                          },
                          separatorBuilder: (context, index) => space(0, 15),
                          itemCount: SocialCubit.get(context).message.length,
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: Colors.grey.shade300, width: 1.0)),
                              child: SingleChildScrollView(
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  maxLines: 3,
                                  minLines: 1,
                                  controller: textController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding:
                                        const EdgeInsetsDirectional.all(12),
                                    hintText: ' \' Type a message \' ',
                                    hintStyle: GoogleFonts.lobster(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    border: InputBorder.none,
                                    prefixIcon: IconButton(
                                      onPressed: ()
                                      {

                                      },
                                      icon: const Icon(
                                        Octicons.smiley,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: ()
                                          {

                                          },
                                          icon: Icon(
                                            IconlyLight.camera,
                                            size: 25,
                                            color: cubit.isDark
                                                ? Colors.black
                                                : Colors.white,
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
                            height: 50,
                            decoration: BoxDecoration(
                              color: cubit.isDark ? Colors.blue : Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: MaterialButton(
                              minWidth: 1,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.sendMessage(
                                    receiverId: userModel.uId!,
                                    dateTime: DateTime.now().toString(),
                                    text: textController.text,
                                  );
                                  textController.clear();
                                }
                              },
                              child: Icon(
                                IconlyLight.send,
                                color:
                                    cubit.isDark ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      );
    });
  }

  Widget buildMyMessageItem(MessageModel messageModel, context) {
    SocialCubit cubit = SocialCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
            child: Bubble(
              nip: BubbleNip.rightBottom,
              color: cubit.isDark ? Colors.blue : Colors.blue.withOpacity(0.4),
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
                    style: GoogleFonts.lobster(
                      color: Colors.grey,
                      textStyle: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: 12,
          backgroundImage: NetworkImage(
            '${userModel.image}',
          ),
        ),
      ],
    );
  }

  Widget buildMessageItem(MessageModel messageModel, context) {
    SocialCubit cubit = SocialCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundImage: NetworkImage(
            '${SocialCubit.get(context).userModel!.image}',
          ),
        ),
        Flexible(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 8, top: 5, bottom: 5),
            child: Bubble(
              nip: BubbleNip.leftTop,
              color: Colors.black38,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    messageModel.text!,
                    style: GoogleFonts.libreBaskerville(
                      color: cubit.isDark ? Colors.black : Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  space(0, 5),
                  Text(
                    daysBetween(
                        DateTime.parse(messageModel.dateTime.toString())),
                    style: GoogleFonts.lobster(
                      color: Colors.grey,
                      textStyle: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

}
