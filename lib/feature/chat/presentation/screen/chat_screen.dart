import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helium_chat_application/feature/chat/presentation/bloc/chat_bloc.dart';
import 'package:helium_chat_application/feature/chat/presentation/widgets/chat_bubble.dart';
import 'package:helium_chat_application/feature/chat/presentation/widgets/htextfield.dart';
import 'package:helium_chat_application/feature/conversation/data/models/conversation_model.dart';
import 'package:helium_chat_application/helpers/base_colors.dart';
import 'package:helium_chat_application/widgets/screen.dart';
import 'package:helium_chat_application/widgets/spacer_widgets.dart';

class ChatScreen extends StatelessWidget {
  final ConversationModel _conversationModel;
  final TextEditingController _editingController = TextEditingController();
  ChatScreen({
    super.key,
    required ConversationModel conversationModel,
  }) : _conversationModel = conversationModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(
        conversation: _conversationModel,
      ),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          _editingController.value = TextEditingValue(
            text: state.unsentMessage,
            selection: TextSelection.fromPosition(
              TextPosition(
                offset: state.unsentMessage.length,
              ),
            ),
          );
          return Screen(
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 7.0,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: state.isEmpty
                              ? const Center(
                                  child: Text(
                                      "Chat Is empty start a conversation"),
                                )
                              : ListView.builder(
                                  itemCount: state.count,
                                  itemBuilder: (context, index) {
                                    return ChatBubble(
                                      isOtherUser:
                                          state.didOtherUserSendMessageAtIndex(
                                              index),
                                      text: state.getContentAtIndex(index),
                                      sentAt: state.getMessageSentAtTime(index),
                                    );
                                  },
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 7,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: HTextfield(
                                  maxLines: null,
                                  placeholderText: "Type your message here...",
                                  editingController: _editingController,
                                  onTextChange: (value) {
                                    BlocProvider.of<ChatBloc>(context)
                                        .add(NewTextAddedEvent(value));
                                  },
                                ),
                              ),
                              horizontalTinySpace,
                              state.isSendingMessage
                                  ? const CircularProgressIndicator()
                                  : state.hasEnteredMessage
                                      ? IconButton(
                                          icon: const Icon(
                                            Icons.send_rounded,
                                          ),
                                          onPressed: () =>
                                              BlocProvider.of<ChatBloc>(context)
                                                  .add(SendMessageEvent()),
                                        )
                                      : const Icon(
                                          Icons.send_rounded,
                                          color: BaseColors.grey,
                                        ),
                            ],
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
