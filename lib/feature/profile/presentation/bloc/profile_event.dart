part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  Stream<ProfileState> handle({
    required ProfileState prevState,
    required ProfileBloc bloc,
  });

  @override
  List<Object> get props => [];
}

class OnUserDataLoadedEvent extends ProfileEvent {
  final HUser userData;
  const OnUserDataLoadedEvent({
    required this.userData,
  });
  @override
  Stream<ProfileState> handle({
    required ProfileState prevState,
    required ProfileBloc bloc,
  }) async* {
    yield ProfileState(
      userData: userData,
    );
  }
}

class OnLogoutEvent extends ProfileEvent {
  final AuthService _authService = AuthService();
  @override
  Stream<ProfileState> handle({
    required ProfileState prevState,
    required ProfileBloc bloc,
  }) async* {
    await _authService.logout();
  }
}

class OnPictureChangeEvent extends ProfileEvent {
  @override
  Stream<ProfileState> handle({
    required ProfileState prevState,
    required ProfileBloc bloc,
  }) async* {
    var imagePath = await bloc.pickImage();
    yield prevState.copyWith(
      isUploadingImage: true,
      localImageFilePath: imagePath,
    );
    var remoteImagePath = await bloc.uploadImageAtPath(imagePath);
    log("Uploading iamge is complete");
    var newUserData = prevState.userData?.copyWith(
      profilePicUrl: remoteImagePath,
    );

    yield prevState.copyWith(
      userData: newUserData,
      hasUnsavedChanges: true,
    );
  }
}

class OnSaveChangesEvent extends ProfileEvent {
  @override
  Stream<ProfileState> handle({
    required ProfileState prevState,
    required ProfileBloc bloc,
  }) async* {
    yield prevState.copyWith(
      isSavingUserInfo: true,
    );
    await bloc.saveChanges();
    log("Finished Saving user info -----------------");
    yield prevState.copyWith(
      hasUnsavedChanges: false,
      isSavingUserInfo: false,
    );
  }
}
