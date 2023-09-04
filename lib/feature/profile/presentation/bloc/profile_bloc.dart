import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:helium_chat_application/feature/profile/data/model/huser.dart';
import 'package:helium_chat_application/feature/profile/data/services/file_storage_service.dart';
import 'package:helium_chat_application/feature/profile/data/services/profile_services.dart';
import 'package:helium_chat_application/shared_services/auth_service.dart';

import '../../../../helpers/db_constants.dart';
import '../../data/services/image_upload_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileServices _profileServices;
  ProfileBloc({String? userID})
      : _profileServices = ProfileServices(
          userID: userID,
        ),
        super(const ProfileState()) {
    on<ProfileEvent>((event, emit) async {
      await emit.forEach(
        event.handle(
          prevState: state,
          bloc: this,
        ),
        onData: (state) {
          log("New State emitted $state");
          return state;
        },
      );
    });
    _profileServices.onUserData().listen((data) {
      add(
        OnUserDataLoadedEvent(
          userData: data,
        ),
      );
    });
  }

  pickImage() async {
    ImagePickerService imagePickerService = ImagePickerService();
    return await imagePickerService.getPickedImagePath();
  }

  uploadImageAtPath(String path) async {
    try {
      final FileStorageService fileStorageService = FileStorageService();
      final AuthService authService = AuthService();
      return await fileStorageService.storeFileAtPath(
        storagePath:
            "$kProfilePic/${authService.currentAuthenticatedUserID}/${DateTime.now()}",
        localFilePath: path,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> close() {
    _profileServices.close();
    return super.close();
  }

  saveChanges() async {
    if (state.hasUnsavedChanges && state.userData != null) {
      log("State has data ${state.userData}");
      await _profileServices.updateUserDataWith(
        state.userData!,
      );
    }
  }
}
