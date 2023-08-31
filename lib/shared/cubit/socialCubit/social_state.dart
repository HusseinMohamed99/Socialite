abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class GetUserDataLoadingState extends SocialStates {}

class GetUserDataSuccessState extends SocialStates {}

class GetUserDataErrorState extends SocialStates {
  final String error;
  GetUserDataErrorState(this.error);
}

class GetAllUsersLoadingState extends SocialStates {}

class GetAllUsersSuccessState extends SocialStates {}

class GetAllUsersErrorState extends SocialStates {
  final String error;
  GetAllUsersErrorState(this.error);
}

class SocialChangeTabBarState extends SocialStates {}

class ChangeMenuItemState extends SocialStates {}

class ChangeMenuScreenState extends SocialStates {}

class ChangeThemeState extends SocialStates {}

class GetProfileImagePickedSuccessState extends SocialStates {}

class GetProfileImagePickedErrorState extends SocialStates {}

class GetCoverImagePickedSuccessState extends SocialStates {}

class GetCoverImagePickedErrorState extends SocialStates {}

class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {}

class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}

class UpdateUserLoadingState extends SocialStates {}

class UpdateUserSuccessState extends SocialStates {}

class UpdateUserErrorState extends SocialStates {}

class CreatePostLoadingState extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostErrorState extends SocialStates {}

class UploadPostLoadingState extends SocialStates {}

class UploadPostSuccessState extends SocialStates {}

class UploadPostErrorState extends SocialStates {}

class GetPostImagePickedSuccessState extends SocialStates {}

class GetPostImagePickedErrorState extends SocialStates {}

class RemovePostImageSuccessState extends SocialStates {}

class GetPostsLoadingState extends SocialStates {}

class GetPostsSuccessState extends SocialStates {}

class GetPostsErrorState extends SocialStates {
  final String error;
  GetPostsErrorState(this.error);
}

class GetSinglePostSuccessState extends SocialStates {}

class GetUserPostsSuccessState extends SocialStates {}

class LikesLoadingState extends SocialStates {}

class LikesSuccessState extends SocialStates {}

class LikesErrorState extends SocialStates {
  final String error;
  LikesErrorState(this.error);
}

class LikedByMeCheckedLoadingState extends SocialStates {}

class LikedByMeCheckedSuccessState extends SocialStates {}

class DisLikesSuccessState extends SocialStates {}

class DisLikesErrorState extends SocialStates {
  final String error;
  DisLikesErrorState(this.error);
}

class GetLikedUsersSuccessState extends SocialStates {}

class UpdatePostLoadingState extends SocialStates {}

class GetCommentImageSuccessState extends SocialStates {}

class GetCommentImageErrorState extends SocialStates {}

class DeleteCommentImageState extends SocialStates {}

class UploadCommentImageLoadingState extends SocialStates {}

class UploadCommentImageSuccessState extends SocialStates {}

class UploadCommentImageErrorState extends SocialStates {}

class CommentPostSuccessState extends SocialStates {}

class CommentPostErrorState extends SocialStates {}

class GetCommentsSuccessState extends SocialStates {}

class SavedToGalleryLoadingState extends SocialStates {}

class SavedToGallerySuccessState extends SocialStates {}

class SavedToGalleryErrorState extends SocialStates {}

class EditPostLoadingState extends SocialStates {}

class EditPostSuccessState extends SocialStates {}

class EditPostErrorState extends SocialStates {}

class DeletePostSuccessState extends SocialStates {}

class ChangeUserPasswordLoadingState extends SocialStates {}

class ChangeUserPasswordSuccessState extends SocialStates {}

class ChangeUserPasswordErrorState extends SocialStates {
  final String error;
  ChangeUserPasswordErrorState(this.error);
}

class ShowPasswordState extends SocialStates {}

class ChangeConfirmPasswordState extends SocialStates {}

class SendMessageSuccessState extends SocialStates {}

class SendFCMNotificationSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}

class GetMessageSuccessState extends SocialStates {}

class GetMessageErrorState extends SocialStates {}

class MessageImagePickedSuccessState extends SocialStates {}

class MessageImagePickedErrorState extends SocialStates {}

class UploadMessageImageLoadingState extends SocialStates {}

class UploadMessageImageSuccessState extends SocialStates {}

class UploadMessageImageErrorState extends SocialStates {}

class GetMessageImageSuccessState extends SocialStates {}

class GetMessageImageErrorState extends SocialStates {}

class DeleteMessageImageSuccessState extends SocialStates {}

class GetFriendProfileLoadingState extends SocialStates {}

class GetFriendProfileSuccessState extends SocialStates {}

class AddFriendLoadingState extends SocialStates {}

class AddFriendSuccessState extends SocialStates {}

class AddFriendErrorState extends SocialStates {}

class GetFriendLoadingState extends SocialStates {}

class GetFriendSuccessState extends SocialStates {}

class GetFriendErrorState extends SocialStates {}

class CheckFriendSuccessState extends SocialStates {}

class UnFriendLoadingState extends SocialStates {}

class UnFriendSuccessState extends SocialStates {}

class UnFriendErrorState extends SocialStates {}

class FriendRequestLoadingState extends SocialStates {}

class FriendRequestSuccessState extends SocialStates {}

class FriendRequestErrorState extends SocialStates {}

class CheckFriendRequestSuccessState extends SocialStates {}

class DeleteFriendRequestLoadingState extends SocialStates {}

class DeleteFriendRequestSuccessState extends SocialStates {}

class DeleteFriendRequestErrorState extends SocialStates {}

class GetStoryLoadingState extends SocialStates {}

class GetStorySuccessState extends SocialStates {}

class CreateStoryImagePickedSuccessState extends SocialStates {}

class CreateStoryImagePickedErrorState extends SocialStates {}

class CreateStoryLoadingState extends SocialStates {}

class CreateStorySuccessState extends SocialStates {}

class CreateStoryErrorState extends SocialStates {}

class RemoveStoryImagePickedSuccessState extends SocialStates {}

class CloseCreateStoryScreenState extends SocialStates {}

class AddTextSuccessState extends SocialStates {}

class SearchLoadingState extends SocialStates {}

class SearchSuccessState extends SocialStates {}

class SearchErrorState extends SocialStates {
  final String error;
  SearchErrorState(this.error);
}

class SendInAppNotificationLoadingState extends SocialStates {}

class GetInAppNotificationLoadingState extends SocialStates {}

class GetInAppNotificationSuccessState extends SocialStates {}

class ReadNotificationSuccessState extends SocialStates {}

class SetNotificationIdSuccessState extends SocialStates {}

class GetNotificationsErrorState extends SocialStates {
  final String error;
  GetNotificationsErrorState(this.error);
}

class SetUSerTokenLoadingState extends SocialStates {}

class SetUSerTokenSuccessState extends SocialStates {}

class ErrorDuringOpenWebsiteUrlState extends SocialStates {}
