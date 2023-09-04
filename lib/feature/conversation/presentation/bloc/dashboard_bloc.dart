import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helium_chat_application/feature/chat/presentation/screen/chat_screen.dart';
import 'package:helium_chat_application/feature/conversation/data/models/conversation_model.dart';
import 'package:helium_chat_application/feature/conversation/data/services/conversation_service.dart';
import 'package:helium_chat_application/feature/profile/presentation/screen/profile_screen.dart';
import 'package:helium_chat_application/shared_services/locator.dart';
import 'package:helium_chat_application/shared_services/navigation_service.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ConversationService _conversationService = ConversationService();
  DashboardBloc()
      : super(
          const DashboardState(
            isLoading: true,
          ),
        ) {
    on<DashboardEvent>(
      (event, emit) async {
        await emit.forEach(event.handle(), onData: (state) => state);
      },
    );

    _conversationService.streamAllConversations().listen((conversations) {
      log("Conversation Stream triggered in $runtimeType - $conversations");
      add(OnUsersLoadedEvent(conversations: conversations));
    });
  }

  @override
  Future<void> close() {
    _conversationService.close();
    log("Closing $runtimeType");
    return super.close();
  }
}
