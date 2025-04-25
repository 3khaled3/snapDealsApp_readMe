part of 'chat_view.dart';

class SendBar extends StatefulWidget {
  const SendBar({super.key, required this.chatRoomId});
  final String chatRoomId;

  @override
  createState() => _SendBarState();
}

class _SendBarState extends State<SendBar> {
  bool _isRecording = false;
  bool _isTextEntered = false;

  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final messageContent = _messageController.text.trim();
    if (messageContent.isNotEmpty) {
      final message = MessageModel(
        chatRoomId: widget.chatRoomId,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: ProfileCubit.instance.state.profile.id,
        content: messageContent,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        type: MessageType.text,
        status: MessageStatus.sending,
      );
      try {
        context.read<ChatMessagesCubit>().sendMessage(message);
        _messageController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send message. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    setState(() {
      _isTextEntered = false;
    });
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });
  }

  void _handleFileUpload(FileType fileType, MessageType messageType) async {
    final result = await FilePicker.platform.pickFiles(type: fileType);
    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path!;
      final message = UploadingMessage(
        chatRoomId: widget.chatRoomId,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: ProfileCubit.instance.state.profile.id,
        content: filePath,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        type: messageType,
        status: MessageStatus.attachmentUploading,
        progress: "0",
      );
      try {
        context.read<ChatMessagesCubit>().uploadAttachment(message);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload file: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file selected.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildSendBar(context);
  }

  Widget _buildSendBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          if (!_isRecording) ...[
            IconButton(
              icon: Icon(Icons.attach_file, color: Colors.grey[600]),
              onPressed: () => _openAttachmentMenu(context),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _messageController,
                  onChanged: (text) {
                    setState(() {
                      _isTextEntered = text.isNotEmpty;
                    });
                  },
                  minLines: 1,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Type a message…',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ] else ...[
            Expanded(child: SizedBox())
          ],
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _isTextEntered
          ? IconButton(
              icon: const Icon(Icons.send, color: Colors.blue),
              onPressed: _sendMessage,
            )
          : Row(
              children: [
                RecordingButton(
                  onRecordingStarted: () => _toggleRecording(),
                  onRecordingComplete: (File? file) {
                    if (file != null) {
                      _toggleRecording();
                      final message = UploadingMessage(
                        chatRoomId: widget.chatRoomId,
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        senderId: ProfileCubit.instance.state.profile.id,
                        content: file.path,
                        timestamp: DateTime.now().millisecondsSinceEpoch,
                        type: MessageType.audio,
                        status: MessageStatus.attachmentUploading,
                        progress: "0",
                      );
                      try {
                        context
                            .read<ChatMessagesCubit>()
                            .uploadAttachment(message);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Failed to upload audio: ${e.toString()}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
    );
  }

  void _openAttachmentMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (newContext) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AttachmentOption(
                      icon: Icons.image,
                      label: 'Image',
                      color: Colors.blue,
                      onTap: () =>
                          _handleFileUpload(FileType.image, MessageType.image),
                    ),
                    AttachmentOption(
                      icon: Icons.video_library,
                      label: 'Video',
                      color: Colors.green,
                      onTap: () =>
                          _handleFileUpload(FileType.video, MessageType.video),
                    ),
                    AttachmentOption(
                      icon: Icons.insert_drive_file,
                      label: 'Files',
                      color: Colors.orange,
                      onTap: () =>
                          _handleFileUpload(FileType.any, MessageType.file),
                    ),
                    AttachmentOption(
                      icon: Icons.location_on,
                      label: 'Location',
                      color: Colors.red,
                      onTap: () {
                        determinePosition(context).then((value) {
                          if (value != null) {
                            final message = MessageModel(
                              chatRoomId: widget.chatRoomId,
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              senderId: ProfileCubit.instance.state.profile.id,
                              content:
                                  'https://www.google.com/maps/search/?api=1&query=${value.latitude},${value.longitude}',
                              timestamp: DateTime.now().millisecondsSinceEpoch,
                              type: MessageType.location,
                              status: MessageStatus.sending,
                            );
                            context
                                .read<ChatMessagesCubit>()
                                .sendMessage(message);
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
