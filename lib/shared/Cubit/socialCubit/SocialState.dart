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
///START : GetAllUsers
class GetAllUsersLoadingState extends SocialStates {}
class GetAllUsersSuccessState extends SocialStates {}
class GetAllUsersErrorState extends SocialStates {
  final String error ;
  GetAllUsersErrorState (this.error);
}
///END : GetAllUsers

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
///START : GetUserPosts
class GetUserPostsSuccessState extends SocialStates {}
///END : GetUserPosts

// ----------------------------------------------------------//
///START : Likes
class LikesLoadingState extends SocialStates {}
class LikesSuccessState extends SocialStates {}
class LikesErrorState extends SocialStates {
  final String error ;
  LikesErrorState (this.error);
}

class DisLikesSuccessState extends SocialStates {}
class DisLikesErrorState extends SocialStates {
  final String error ;
  DisLikesErrorState (this.error);
}


class GetLikedUsersSuccessState extends  SocialStates {}
///END : Likes

// ----------------------------------------------------------//
///START : Comments
class SendCommentSuccessState extends  SocialStates {}
class SendCommentErrorState extends  SocialStates {}
class GetCommentsSuccessState extends  SocialStates {}
class RemoveCommentImageSuccessState extends  SocialStates {}
///END : Comments

// ----------------------------------------------------------//
///START : SavedToGallery
class SavedToGalleryLoadingState extends SocialStates{}
class SavedToGallerySuccessState extends SocialStates{}
class SavedToGalleryErrorState extends SocialStates{}
///END : SavedToGallery
//------------------------------------------------------------//
///START : EditPost
class EditPostLoadingState extends SocialStates {}
class EditPostSuccessState extends SocialStates {}
class EditPostErrorState extends SocialStates {}

class DeletePostSuccessState extends SocialStates {}
///END : EditPost

//------------------------------------------------------------//
///START : ChangeUserPassword
class ChangeUserPasswordLoadingState extends SocialStates {}
class ChangeUserPasswordSuccessState extends SocialStates {}
class ChangeUserPasswordErrorState extends SocialStates {
  final String error ;
  ChangeUserPasswordErrorState(this.error);
}

class ShowPasswordState extends SocialStates {}
///END : ChangeUserPassword

//------------------------------------------------------------//
///START : Message
class SendMessageSuccessState extends SocialStates {}
class SendMessageErrorState extends SocialStates {}

class GetMessageSuccessState extends SocialStates {}
class GetMessageErrorState extends SocialStates {}

class GetMessageImageSuccessState extends SocialStates {}
class GetMessageImageErrorState extends SocialStates {}

///END : Message

//------------------------------------------------------------//
