import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../model/user_model.dart';
import '../../shared/Cubit/socialCubit/SocialCubit.dart';
import '../../shared/Cubit/socialCubit/SocialState.dart';
import '../../shared/componnetns/components.dart';
import '../../shared/componnetns/constants.dart';
import '../friend/profileScreen.dart';
import '../profile/My_profile_screen.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // This list holds the data for the list view
  List<UserModel> foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    foundUsers = SocialCubit.get(context).users;
    super.initState();
  }

  // This function is called whenever the text field changes
  void runFilter(String enteredKeyword) {
    List<UserModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = SocialCubit.get(context).users;
    } else {
      results = SocialCubit.get(context)
          .users
          .where((user) =>
          user.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark),
              elevation: 0,
              backgroundColor: Colors.green.withOpacity(0.4),
              leading: IconButton(
                icon: Icon(
                  IconlyBroken.arrowLeft2,
                  color: Colors.brown,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: TextFormField(
                maxLines: 1,
                autofocus: true,
                keyboardType: TextInputType.text,
                enableInteractiveSelection: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                enableSuggestions: true,
                scrollPhysics: BouncingScrollPhysics(),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: 'Search',
                ),
                autocorrect: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'The search can\'t be empty';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {},
                onChanged: (value) {
                  runFilter(value);
                },
              ),
            ),
            body: foundUsers.length > 0
                ? ListView.separated(
                itemBuilder: (context, index) =>
                    singleUserBuilder(foundUsers[index], context),
                separatorBuilder: (context, index) => SizedBox(
                  height: 0,
                ),
                itemCount: foundUsers.length)
                : Center(child: Text('No result is found!')),
          );
        },
        listener: (context, state) {});
  }
  Widget singleUserBuilder(UserModel user, BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
    child: InkWell(
      onTap: () {
        if (user.uId == uId) {
          navigateTo(context, MyProfileScreen());
        } else {
          SocialCubit.get(context).getFriends( user.uId);
          navigateTo(
              context,
              FriendsProfileScreen(
                 user.uId,
              ));
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 23,
            backgroundImage: NetworkImage(
              '${user.image}',
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.brown,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '${SocialCubit.get(context).users.length - 1} mutual friends',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 9, color: Colors.green, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                IconlyBroken.user2,
                color: Colors.brown,
              ))
        ],
      ),
    ),
  );

}