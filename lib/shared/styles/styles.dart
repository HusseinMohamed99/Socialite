
///view Photo
// import 'package:f_app/shared/Cubit/socialCubit/SocialCubit.dart';
// import 'package:f_app/shared/Cubit/socialCubit/SocialState.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class view extends StatelessWidget {
//   const view({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SocialCubit, SocialStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var userModel = SocialCubit.get(context).userModel;
//         return Scaffold(
//             backgroundColor: Colors.black,
//             body: SafeArea(
//               child: Stack(children: [
//                 SizedBox.expand(
//                   child: InteractiveViewer(
//                     child: Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: NetworkImage('${userModel!.cover}'),
//                               fit: BoxFit.contain)),
//                     ),
//                   ),
//                 ),
//                 Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(children: [
//                           IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: Container(
//                                 decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: Colors.grey.withOpacity(0.3),
//                                           blurRadius: 9,
//                                           spreadRadius: 4,
//                                           offset: Offset(0, 4))
//                                     ]),
//                                 child: CircleAvatar(
//                                     backgroundColor: Theme.of(context)
//                                         .scaffoldBackgroundColor,
//                                     child: Icon(
//                                       Icons.arrow_back_ios_outlined,
//                                       color: Colors.red,
//                                     )),
//                               )),
//                         ]),
//                       ),
//                     ]),
//               ]),
//             ));
//       },
//     );
//   }
// }

///  const Color(0xff063750)
