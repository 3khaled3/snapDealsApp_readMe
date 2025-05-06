part of 'audio_message.dart';

class _PlayerWidget extends StatefulWidget {
  final String url;
  final Color color;

  const _PlayerWidget({
    required this.url,
    required this.color,
  });

  @override
  State<_PlayerWidget> createState() => __PlayerWidgetState();
}

class __PlayerWidgetState extends State<_PlayerWidget> {
  final FlutterSoundPlayer _myPlayer = FlutterSoundPlayer();
  final StreamController<PlaybackDisposition> _localController =
      StreamController<PlaybackDisposition>.broadcast();
  final _sliderPosition = _SliderPosition();
  late Stream<PlaybackDisposition> playerStream;

  @override
  void initState() {
    setupPlayer();
    playerStream = _localController.stream;
    super.initState();
  }

  @override
  void dispose() {
    _localController.close();
    _myPlayer.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPlayPauseButton(),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * .25,
          // fit: BoxFit.scaleDown,
          child: _buildPlayBar(),
        ),
        8.pw,
        _buildDuration()
      ],
    );
  }

  Widget _buildPlayPauseButton() => IconButton(
        key: ValueKey(const Uuid().v4()),
        onPressed: () => buttonClick(),
        icon: Icon(_myPlayer.isPlaying
            ? Icons.pause_circle_outline
            : Icons.play_circle_outline),
        iconSize: 35,
        color: widget.color,
      );

  Widget _buildPlayBar() => StreamBuilder<PlaybackDisposition>(
      stream: playerStream,
      initialData: PlaybackDisposition.zero(),
      builder: (context, snapshot) {
        var disposition = snapshot.data!;
        return SliderTheme(
          data: SliderThemeData(
            trackShape: CustomTrackShape(),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
            thumbColor: widget.color,
            activeTrackColor: widget.color,
            inactiveTrackColor: Colors.grey.shade400,
            disabledThumbColor: widget.color,
          ),
          child: Slider(
            onChanged: (value) {
              Duration position = Duration(milliseconds: value.toInt());
              _sliderPosition.position = position;
              if (_myPlayer.isPlaying || _myPlayer.isPaused) {
                _myPlayer.seekToPlayer(position);
              }
            },
            max: disposition.duration.inMilliseconds.toDouble(),
            value: disposition.position.inMilliseconds.toDouble(),
          ),
        );
      });

  Widget _buildDuration() => StreamBuilder<PlaybackDisposition>(
      stream: playerStream,
      initialData: PlaybackDisposition.zero(),
      builder: (context, snapshot) {
        var disposition = snapshot.data!;
        var durationDate = DateTime.fromMillisecondsSinceEpoch(
            disposition.duration.inMilliseconds,
            isUtc: true);
        var positionDate = DateTime.fromMillisecondsSinceEpoch(
            disposition.position.inMilliseconds,
            isUtc: true);
        return Text(
          '${positionDate.minute.toString().padLeft(2, '0')}:${positionDate.second.toString().padLeft(2, '0')} / ${durationDate.minute.toString().padLeft(2, '0')}:${durationDate.second.toString().padLeft(2, '0')}',
          style: AppTextStyles.regular14().copyWith(color: widget.color),
        );
      });

  /// Call [resume] to resume playing the audio.
  Future<void> resume() async =>
      await _myPlayer.resumePlayer().catchError((dynamic e) async {
        await _myPlayer.stopPlayer();
      });

  /// Call [pause] to pause playing the audio.
  Future<void> pause() async =>
      await _myPlayer.pausePlayer().catchError((dynamic e) async {
        await _myPlayer.stopPlayer();
      });

  Future<void> start() async {
    try {
      print('Starting player with URL: ${widget.url}');
      await _myPlayer.startPlayer(
        fromURI: widget.url,
        codec: Codec.aacADTS,
        whenFinished: () {
          if (mounted) {
            setState(() {
              _localController.add(PlaybackDisposition.zero());
            });
          }
        },
      );
      print('Player started successfully');
    } catch (e) {
      print(
          '😵‍💫😵‍💫😵‍💫😵‍💫😵‍💫😵‍💫😵‍💫😵‍💫😵‍💫  Error starting player: $e');
      await _myPlayer.stopPlayer();
    }
  }

  buttonClick() async {
    if (_myPlayer.isPaused) {
      print('__PlayerWidgetState.buttonClick isPaused');
      await resume();
    } else if (_myPlayer.isPlaying) {
      print('__PlayerWidgetState.buttonClick isPlaying');
      await pause();
    } else {
      print('__PlayerWidgetState.buttonClick starting');
      await start();
    }
    if (mounted) {
      setState(() {});
    }
  }

  void setupPlayer() async {
    try {
      await _myPlayer.openPlayer();
      print('Player opened successfully');
      _sliderPosition.position = const Duration(seconds: 0);
      _sliderPosition.maxPosition = const Duration(seconds: 0);
      _myPlayer.onProgress!.listen((disposition) {
        if (mounted) {
          _localController.add(disposition);
        }
      });
      _myPlayer.setSubscriptionDuration(const Duration(milliseconds: 100));
    } catch (e) {
      print(
          '😵‍💫😵‍💫😵‍💫😵‍💫😵‍💫😵‍💫😵‍💫😵‍💫😵‍💫 Error opening player: $e');
    }
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 0.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 10;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

//
// ///
class _SliderPosition extends ChangeNotifier {
  /// The current position of the slider.
  Duration _position = Duration.zero;

  /// The max position of the slider.
  Duration maxPosition = Duration.zero;

  bool _disposed = false;

  ///
  set position(Duration position) {
    _position = position;

    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  ///
  Duration get position {
    return _position;
  }
}