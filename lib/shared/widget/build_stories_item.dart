import 'package:flutter/material.dart';
import 'package:sociality/model/story_model.dart';
import 'package:sociality/pages/story/veiw_story.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';

class BuildStoriesItem extends StatelessWidget {
  const BuildStoriesItem({super.key, required this.storyModel});
  final StoryModel storyModel;
  @override
  Widget build(BuildContext context) {
    var bloc = SocialCubit.get(context).userModel;
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewStory(storyModel)));
      },
      child: Container(
        width: 110,
        height: 180,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(17)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: NetworkImage(storyModel.storyImage!),
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 23,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: storyModel.uId == bloc!.uId
                          ? NetworkImage(bloc.image)
                          : NetworkImage(storyModel.image!),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 110,
                    height: 25,
                    child: Text(
                      storyModel.uId == bloc.uId ? bloc.name : storyModel.name!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
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
  }
}
