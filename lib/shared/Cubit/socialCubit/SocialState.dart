abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

///START : GetUserData
class SocialGetUserDataLoadingState extends SocialStates {}

class SocialGetUserDataSuccessState extends SocialStates {}

class SocialGetUserDataErrorState extends SocialStates {
  final String error ;
  SocialGetUserDataErrorState (this.error);
}
///END : GetUserData

///START : ChangeTabBar
class SocialChangeTabBarState extends SocialStates {}
///END : ChangeTabBar

class ChangeMenuItemState extends SocialStates {}

class ChangeMenuScreenState extends SocialStates {}

class ChangeThemeState extends SocialStates {}


