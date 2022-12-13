

import 'package:f_app/model/drawerModel.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class MenuItems {
  static final profile = ItemsModel(title: 'Profile', icon: IconlyBroken.user2);
  static final notifications = ItemsModel(title: 'Notifications', icon: IconlyBroken.notification);
  static final savedPost = ItemsModel(title: 'Saved Post', icon: IconlyBroken.bookmark);
  static final restPassword = ItemsModel(title: 'Rest Password', icon: IconlyBroken.password);




 static  List<ItemsModel> all = [
    profile,
    notifications,
    savedPost,
    restPassword,

  ];
}