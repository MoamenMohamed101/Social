abstract class SocialState {}

final class SocialInitial extends SocialState {}

final class SocialChangeIndex extends SocialState {}

final class SocialChangeIndexUploadPost extends SocialState {}

final class SocialGetUserDataLoading extends SocialState {}

final class SocialGetUserDataSuccess extends SocialState {}

final class SocialGetUserDataError extends SocialState {}

final class SocialGetAllUserDataLoading extends SocialState {}

final class SocialGetAllUserDataSuccess extends SocialState {}

final class SocialGetAllUserDataError extends SocialState {}

final class SocialGetUserPostsLoading extends SocialState {}

final class SocialGetUserPostsSuccess extends SocialState {}

final class SocialGetUserPostsError extends SocialState {}

final class SocialUpdateUserDataError extends SocialState {}

final class SocialUpdateUserDataLoading extends SocialState {}

final class SocialGetProfileImageSuccess extends SocialState {}

final class SocialGetProfileImageError extends SocialState {}

final class SocialGetCoverImageSuccess extends SocialState {}

final class SocialGetCoverImageError extends SocialState {}

final class SocialCreatePostImageSuccess extends SocialState {}

final class SocialCreatePostImageError extends SocialState {}

final class SocialUploadCoverImageError extends SocialState {}

final class SocialUploadCoverImageSuccess extends SocialState {}

final class SocialUploadCoverImageLoading extends SocialState {}

final class SocialUploadProfileImageError extends SocialState {}

final class SocialUploadProfileImageSuccess extends SocialState {}

final class SocialUploadProfileImageLoading extends SocialState {}

final class SocialCreatePostError extends SocialState {}

final class SocialCreatePostSuccess extends SocialState {}

final class SocialCreatePostLoading extends SocialState {}

final class SocialCreatePostWithImageError extends SocialState {}

final class SocialCreatePostWithImageSuccess extends SocialState {}

final class SocialCreatePostWithImageLoading extends SocialState {}

final class SocialCreatePostWithImageDelete extends SocialState {}

final class SocialCreateLikePostSuccess extends SocialState {}

final class SocialCreateLikePostLoading extends SocialState {}

final class SocialCreateLikePostDelete extends SocialState {}

final class SocialSignOutSuccess extends SocialState {}

final class SocialSignOutLoading extends SocialState {}

final class SocialSignOutError extends SocialState {}

final class SocialSendMessageSuccess extends SocialState {}

final class SocialSendMessageError extends SocialState {}

final class SocialGetMessageSuccess extends SocialState {}

final class SocialGetMessageError extends SocialState {}