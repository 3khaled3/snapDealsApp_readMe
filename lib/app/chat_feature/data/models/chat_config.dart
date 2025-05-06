import 'package:snap_deals/core/constants/constants.dart';

enum ChatType {
  free,
  support,
}

class ChatConfig {
  final String chatRoomsCollection;
  final String chatMessagesCollection;

  ChatConfig({
    required this.chatRoomsCollection,
    required this.chatMessagesCollection,
  });

  factory ChatConfig.fromType(ChatType chatType) {
    switch (chatType) {
      case ChatType.free:
        return ChatConfig(
          chatRoomsCollection: Constants.freeChatRooms,
          chatMessagesCollection: Constants.freeChatMessages,
        );
      case ChatType.support:
        return ChatConfig(
          chatRoomsCollection: Constants.supportChatRooms,
          chatMessagesCollection: Constants.supportChatMessages,
        );
    }
  }

  static ChatType getChatType(ChatConfig chatConfig) {
    return chatConfig.chatRoomsCollection == Constants.freeChatRooms
        ? ChatType.free
        : ChatType.support;
  }
}
