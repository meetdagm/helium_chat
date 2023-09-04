import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helium_chat_application/feature/conversation/presentation/bloc/dashboard_bloc.dart';
import 'package:helium_chat_application/feature/conversation/presentation/widgets/message_preview_widget.dart';
import 'package:helium_chat_application/widgets/screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context) => DashboardBloc(),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (
          context,
          state,
        ) {
          return Screen(
            title: "Messages",
            trailing: IconButton(
              icon: const Icon(
                Icons.settings_rounded,
                color: Colors.black,
              ),
              onPressed: () => BlocProvider.of<DashboardBloc>(context).add(
                OnSettingsPressedEvent(),
              ),
            ),
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: state.count,
                    itemBuilder: (listContext, index) {
                      return MessagePreviewWidget(
                        title: state.getEmailAtIndex(index),
                        description: state.getDescriptionAtIndex(index),
                        timeStamp: state.getTimestampAtIndex(index),
                        onTap: () =>
                            BlocProvider.of<DashboardBloc>(context).add(
                          OnStartChatWithUserIDEvent(
                            state.getConversationAtIndex(index),
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
