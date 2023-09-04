part of 'profile_bloc.dart';

final class ProfileState extends Equatable {
  final bool isLoading;
  final HUser? userData;
  final bool isUploadingImage;
  final String localImageFilePath;
  final bool hasUnsavedChanges;
  final bool isSavingUserInfo;

  const ProfileState({
    this.userData,
    this.isLoading = false,
    this.isUploadingImage = false,
    this.localImageFilePath = "",
    this.hasUnsavedChanges = false,
    this.isSavingUserInfo = false,
  });

  ImageProvider get profilePicture => localImageFilePath.isNotEmpty
      ? AssetImage(localImageFilePath)
      : userData?.profilePicUrl != null
          ? NetworkImage(userData!.profilePicUrl!) as ImageProvider
          : const AssetImage(kPlaceholderImage);
  @override
  List<Object> get props => [
        isLoading,
        isUploadingImage,
        localImageFilePath,
        hasUnsavedChanges,
      ];

  ProfileState copyWith({
    HUser? userData,
    bool? isLoading,
    bool? isUploadingImage,
    String? localImageFilePath,
    bool? hasUnsavedChanges,
    bool? isSavingUserInfo,
  }) {
    return ProfileState(
      userData: userData ?? this.userData,
      isLoading: isLoading ?? this.isLoading,
      isUploadingImage: isUploadingImage ?? this.isUploadingImage,
      localImageFilePath: localImageFilePath ?? this.localImageFilePath,
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
      isSavingUserInfo: isSavingUserInfo ?? this.isSavingUserInfo,
    );
  }

  String get getUserEmail => userData?.email ?? "";
}
