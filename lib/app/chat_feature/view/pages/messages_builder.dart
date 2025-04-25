part of 'chat_view.dart';

class MessagesBuilder extends StatefulWidget {
  const MessagesBuilder({super.key});

  @override
  State<MessagesBuilder> createState() => _MessagesBuilderState();
}

class _MessagesBuilderState extends State<MessagesBuilder>
    with WidgetsBindingObserver {
  List<GlobalKey> keys = [];

  ValueNotifier<List<MessageModel>> reversedMessages = ValueNotifier([]);
  List<Widget> messagesWidget = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    /// Check if the keyboard is visible
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    if (bottomInset > 0) {
      /// Keyboard is visible, scroll to the last message
      Future.delayed(const Duration(milliseconds: 50), (() {
        if (keys.isNotEmpty && keys.last.currentContext != null) {
          Scrollable.ensureVisible(keys.last.currentContext!);
        }
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatMessagesCubit, List<MessageModel>>(
      listenWhen: (previous, current) {
        //rebuild when new messages are added
        return reversedMessages.value.length != current.length;
      },
      listener: (context, messages) {
        /// used to get new messages
        List<MessageModel> newMessages = messages.where((message) {
          return !reversedMessages.value.any((m) => m.id == message.id);
        }).toList();

        ///sort messages
        newMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

        /// add new messages as widgets and set  keys
        for (var message in newMessages) {
          keys.add(GlobalKey(debugLabel: message.id));
          messagesWidget
              .add(FinalMessageBubble(key: keys.last, message: message));
        }

        /// update reversed messages to new value to update in listener
        reversedMessages.value = messages.toList();

        /// Scroll to the last message
        //* used delay to wait for the widget to be built
        Future.delayed(const Duration(milliseconds: 50), (() {
          if (keys.isNotEmpty && keys.last.currentContext != null) {
            Scrollable.ensureVisible(keys.last.currentContext!);
          }
        }));
      },
      child: ValueListenableBuilder(
        valueListenable: reversedMessages,
        builder: (context, messages, _) {
          return SingleChildScrollView(
            child: Column(
              children: [...messagesWidget],
            ),
          );
        },
      ),
    );
  }
}
