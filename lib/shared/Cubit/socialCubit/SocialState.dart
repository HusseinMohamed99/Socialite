abstract class SocialStates {}
class SocialInitialState extends SocialStates {}

// ----------------------------------------------------------//

///START : GetUserData
class GetUserDataLoadingState extends SocialStates {}
class GetUserDataSuccessState extends SocialStates {}
class GetUserDataErrorState extends SocialStates {
  final String error ;
  GetUserDataErrorState (this.error);
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

///START : CreatePost
class CreatePostLoadingState extends SocialStates {}
class CreatePostSuccessState extends SocialStates {}
class CreatePostErrorState extends SocialStates {}
///END : CreatePost

// ----------------------------------------------------------//

///START : UploadPost
class UploadPostLoadingState extends SocialStates {}
class UploadPostSuccessState extends SocialStates {}
class UploadPostErrorState extends SocialStates {}
///END : UploadPost

// ----------------------------------------------------------//

///START : GetPostImage
class GetPostImagePickedSuccessState extends SocialStates {}
class GetPostImagePickedErrorState extends SocialStates {}
///END : GetPostImage

// ----------------------------------------------------------//

///START : RemovePostImage
class RemovePostImageSuccessState extends SocialStates {}
///END : RemovePostImage

// ----------------------------------------------------------//

///START : GetPosts
class GetPostsLoadingState extends SocialStates {}
class GetPostsSuccessState extends SocialStates {}
class GetPostsErrorState extends SocialStates {
  final String error ;
  GetPostsErrorState (this.error);
}
///END : GetPosts

// ----------------------------------------------------------//

class GetUserPostsSuccessState extends SocialStates {}