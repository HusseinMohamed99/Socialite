import 'package:sociality/Pages/friend/profile_screen.dart';
import 'package:sociality/model/story_model.dart';
import 'package:sociality/shared/Cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/Cubit/socialCubit/social_state.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class ViewStory extends StatelessWidget {
  final StoryModel? model;

  const ViewStory(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var bloc = SocialCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
                child: Stack(
              children: [
                SizedBox.expand(
                  child: InteractiveViewer(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(model!.storyImage!),
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 9,
                                          spreadRadius: 4,
                                          offset: const Offset(0, 4))
                                    ]),
                                child: CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: const Icon(
                                      Icons.arrow_back_ios_outlined,
                                      color: Colors.red,
                                    )),
                              )),
                          InkWell(
                            onTap: () {
                              if (model!.uId != bloc.userModel!.uId) {
                                bloc.getFriends(model!.uId!);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FriendsProfileScreen(model!.uId),
                                  ),
                                );
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                model!.image!,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      model!.name!,
                                      style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.blue,
                                      size: 23,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  daysBetween(DateTime.parse(
                                      model!.dateTime.toString())),
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      textStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      height: 1.3),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          if (model!.text != "")
                            Center(
                                child: Text(
                              model!.text!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                            )),
                          space(0, 35)
                        ],
                      ),
                    )),
                  ],
                )
              ],
            )),
          );
        });
  }
}
