import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helium_chat_application/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:helium_chat_application/helpers/base_colors.dart';
import 'package:helium_chat_application/helpers/base_fonts.dart';
import 'package:helium_chat_application/widgets/busy_button.dart';
import 'package:helium_chat_application/widgets/screen.dart';
import 'package:helium_chat_application/widgets/spacer_widgets.dart';
import 'package:helium_chat_application/widgets/teritiary_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Screen(
            backgroundColor: BaseColors.white2,
            trailing: state.hasUnsavedChanges
                ? Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: TeritiaryButton(
                      title: "Save",
                      onPressed: () => BlocProvider.of<ProfileBloc>(context)
                          .add(OnSaveChangesEvent()),
                    ),
                  )
                : state.isSavingUserInfo
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: BaseColors.black,
                      )
                    : null,
            title: "Profile",
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        verticalLargeSpace,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 12.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: BaseColors.white,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: BaseColors.white,
                                backgroundImage: state.profilePicture,
                                radius: 33,
                                child: state.isUploadingImage
                                    ? const CircularProgressIndicator()
                                    : null,
                              ),
                              horizontalMediumSpace,
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    state.getUserEmail,
                                    style: BaseFonts.headline3(),
                                  ),
                                  TeritiaryButton(
                                    onPressed: () =>
                                        BlocProvider.of<ProfileBloc>(context)
                                            .add(OnPictureChangeEvent()),
                                    title: "Change Profile",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        BusyButton(
                          title: "Logout",
                          enabled: true,
                          onPressed: () =>
                              BlocProvider.of<ProfileBloc>(context).add(
                            OnLogoutEvent(),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
