abstract class SocialStates {}
class SocialInitialState extends SocialStates {}

// ----------------------------------------------------------//

///START : GetUserData
class SocialGetUserDataLoadingState extends SocialStates {}
class SocialGetUserDataSuccessState extends SocialStates {}
class SocialGetUserDataErrorState extends SocialStates {
  final String error ;
  SocialGetUserDataErrorState (this.error);
}
///END : GetUserData

// ----------------------------------------------------------//

///START : ChangeTabBar
class SocialChangeTabBarState extends SocialStates {}
///END : ChangeTabBar

// ----------------------------------------------------------//

///START : ChangeMenuItem
class ChangeMenuItemState extends SocialStates {}
class ChangeMenuScreenState extends SocialStates {}
///END : ChangeMenuItem

// ----------------------------------------------------------//

///START : ChangeTheme
class ChangeThemeState extends SocialStates {}
///END : ChangeTheme

// ----------------------------------------------------------//

///START : GetProfileImage
class GetProfileImagePickedSuccessState extends SocialStates {}
class GetProfileImagePickedErrorState extends SocialStates {}
///END : GetProfileImage

// ----------------------------------------------------------//

///START : GetCoverImage
class GetCoverImagePickedSuccessState extends SocialStates {}
class GetCoverImagePickedErrorState extends SocialStates {}
///END : GetCoverImage

// ----------------------------------------------------------//

///START : UploadProfileImage
class UploadProfileImageSuccessState extends SocialStates {}
class UploadProfileImageErrorState extends SocialStates {}
///END : UploadProfileImage

// ----------------------------------------------------------//

///START : UploadCoverImage
class UploadCoverImageSuccessState extends SocialStates {}
class UploadCoverImageErrorState extends SocialStates {}
///END : UploadCoverImage

// ----------------------------------------------------------//

///START : UpdateUserData
class UpdateUserLoadingState extends SocialStates {}
class UpdateUserErrorState extends SocialStates {}
///END : UpdateUserData

// ----------------------------------------------------------//

