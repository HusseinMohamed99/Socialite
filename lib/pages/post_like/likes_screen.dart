import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:sociality/model/likes_model.dart';
import 'package:sociality/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:sociality/shared/components/indicator.dart';
import 'package:sociality/shared/cubit/socialCubit/social_cubit.dart';

class LikesScreen extends StatelessWidget {
  final String? postId;
  LikesScreen(
    this.postId, {
    Key? key,
  }) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Likes'),
          titleSpacing: 0,
          elevation: 8,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .orderBy('dateTime', descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: AdaptiveIndicator(os: getOs()));
              } else {
                cubit.peopleReacted = [];
                snapshot.data.docs.forEach((element) {
                  cubit.peopleReacted.add(LikesModel.fromJson(element.data()));
                });
                return ConditionalBuilder(
                    condition: snapshot.hasData == true &&
                        cubit.peopleReacted.isNotEmpty == true,
                    builder: (BuildContext context) => Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  reverse: false,
                                  itemBuilder: (context, index) {
                                    return userLikeItem(
                                        context, cubit.peopleReacted[index]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 0,
                                      ),
                                  itemCount: cubit.peopleReacted.length),
                            ),
                          ],
                        ),
                    fallback: (BuildContext context) =>
                        AdaptiveIndicator(os: getOs()));
              }
            }));
  }

  Widget userLikeItem(context, LikesModel like) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('${like.image}'),
            radius: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${like.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (uId != like.uId)
            SizedBox(
              width: 120,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  // SocialCubit.get(context).addFriend(
                  //     friendName: like.name,
                  //     friendProfilePic: like.profilePicture,
                  //     friendsUid: like.uId
                  // );
                  // SocialCubit.get(context).getFriends(like.uId);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_alt_1_rounded,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('LocaleKeys.addFriend.tr()',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
//  class WhoLikedScreen extends StatelessWidget {
// String ?postId;
// WhoLikedScreen(this.postId);
//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context){
//       SocialCubit.get(context).getLikes(postId);
//       return BlocConsumer<SocialCubit,SocialStates>(
//           listener: (context,state){},
//           builder: (context,state) {
//             List<LikesModel> peopleReacted = SocialCubit.get(context).peopleReacted;
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text(LocaleKeys.Peoplewhoreacted.tr()),
//                 titleSpacing: 0,
//                 elevation: 8,
//               ),
//               body: ListView.separated(
//                   itemBuilder: (context,index) => userLikeItem(context, peopleReacted[index]),
//                   separatorBuilder:(context,index) => const SizedBox(height: 0,),
//                   itemCount: peopleReacted.length
//               ),
//             );
//       },
//       );
//     });
//   }
//   Widget userLikeItem (context,LikesModel userModel) {
//     return Builder(
//       builder:(context) {
//         return InkWell(
//         onTap: (){
//           if (SocialCubit.get(context).model!.uID == userModel.uId) {
//             navigateTo(context, SocialLayout(3));
//           } else {
//             navigateTo(context, FriendsProfileScreen(userModel.uId));
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage:NetworkImage('${userModel.profilePicture}'),
//                 radius: 20,
//               ),
//               const SizedBox(width: 10,),
//               Text('${userModel.name}',
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   color: SocialCubit.get(context).textColor,
//                   fontSize: 17,
//                   fontWeight: FontWeight.bold,
//                 ),),
//               const Spacer(),
//               if (SocialCubit.get(context).model!.uID != userModel.uId)
//                 SizedBox(
//                 width: 120,
//                 child: ElevatedButton(
//                   style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.blueAccent)) ,
//                   onPressed: (){
//                     SocialCubit.get(context).addFriend(
//                       friendName: userModel.name,
//                       friendProfilePic: userModel.profilePicture,
//                       friendsUid: userModel.uId
//                     );
//                     SocialCubit.get(context).getFriends(userModel.uId);
//                   },
//                   child:Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(Icons.person_add_alt_1_rounded,size: 15,),
//                       const SizedBox(width: 5,),
//                       Text(LocaleKeys.addFriend.tr(),style: const TextStyle(color: Colors.white,fontSize: 12)),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),);
//       },
//     );
//   }

// }