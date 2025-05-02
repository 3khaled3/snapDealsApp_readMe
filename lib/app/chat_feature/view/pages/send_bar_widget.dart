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
  late final SendBarHelper _sendBarHelper;

  @override
  void initState() {
    super.initState();
    _sendBarHelper = SendBarHelper(context, widget.chatRoomId);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    setState(() => _isRecording = !_isRecording);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: const BoxDecoration(
        // color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          if (!_isRecording) ...[
            IconButton(
              icon: Icon(Icons.attach_file, color: Colors.grey[600]),
              onPressed: () => _sendBarHelper.openAttachmentMenu(),
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                onChanged: (text) =>
                    setState(() => _isTextEntered = text.isNotEmpty),
                onSubmitted: (text) {
                  if (_messageController.text.trim().isNotEmpty) {
                    _sendBarHelper.sendMessage(_messageController.text.trim());
                    _messageController.clear();
                  }
                  setState(() => _isTextEntered = false);
                },
                textInputAction: TextInputAction.send,
                minLines: 1,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Type a message…',
                  border: InputBorder.none,
                ),
              ),
            ),
          ] else ...[
            const Expanded(child: SizedBox())
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
              onPressed: () {
                if (_messageController.text.trim().isNotEmpty) {
                  _sendBarHelper.sendMessage(_messageController.text.trim());
                  _messageController.clear();
                }
                setState(() => _isTextEntered = false);
              },
            )
          : RecordingButton(
              onRecordingStarted: _toggleRecording,
              onRecordingComplete: (file) {
                if (file != null) {
                  _toggleRecording();
                  _sendBarHelper.uploadAudio(file.path);
                }
              },
            ),
    );
  }
}
