import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sociality/model/story_model.dart';
import 'package:sociality/pages/story/veiw_story.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';
import 'package:sociality/shared/cubit/socialCubit/social_state.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({super.key, required this.storyModel});
  final StoryModel storyModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewStory(storyModel),
              ),
            );
          },
          child: Container(
            width: 110.w,
            height: 180.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(17).r,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14).r,
                      image: DecorationImage(
                        image: NetworkImage(storyModel.storyImage!),
                        fit: BoxFit.fill,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 23.r,
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundImage:
                              storyModel.uId == cubit.userModel!.uId
                                  ? NetworkImage(cubit.userModel!.image)
                                  : NetworkImage(storyModel.image!),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 110.w,
                        height: 25.h,
                        child: Text(
                          storyModel.uId == cubit.userModel!.uId
                              ? cubit.userModel!.name
                              : storyModel.name!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
