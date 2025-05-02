import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snap_deals/core/extensions/sized_box_extension.dart';

import 'package:snap_deals/core/themes/app_colors.dart';
import 'package:snap_deals/core/themes/text_styles.dart';
part 'record_decibels_visualizer.dart';

class RecordingButton extends StatefulWidget {
  final Function(File?) onRecordingComplete;
  final Function() onRecordingStarted;

  const RecordingButton({
    super.key,
    required this.onRecordingComplete,
    required this.onRecordingStarted,
  });

  @override
  createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton>
    with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);
  static const _kRotationDuration = Duration(seconds: 5);

  bool isPlaying = false;

  // rotation and scale animations
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  double _rotation = 0;
  double _scale = 0.5;

  // recording duration and decibels
  Duration _recordingDuration = Duration.zero;
  double _currentDecibels = 0.0;
  List<double> decibels = [];
  StreamSubscription? _recorderSubscription;

  bool get _showWaves => !_scaleController.isDismissed;

  void _updateRotation() => _rotation = _rotationController.value * 2 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  late FlutterSoundRecorder _audioRecorder;
  late String _recordingPath;

  @override
  void initState() {
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration)
          ..addListener(() => setState(_updateRotation))
          ..repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration)
          ..addListener(() => setState(_updateScale));

    _audioRecorder = FlutterSoundRecorder();
    _initRecorder();

    super.initState();
  }

  Future<void> _initRecorder() async {
    await _audioRecorder.openRecorder();
    if (!await _audioRecorder.isEncoderSupported(Codec.aacADTS)) {
      throw Exception("Codec not supported on this platform");
    }
    await _audioRecorder
        .setSubscriptionDuration(const Duration(milliseconds: 500));
    _recorderSubscription = _audioRecorder.onProgress!.listen((event) {
      // Update recording duration and decibels
      setState(() {
        _recordingDuration = event.duration;
        _currentDecibels =
            double.parse((event.decibels ?? 0.0).toStringAsFixed(2));
        decibels.add(_currentDecibels);
      });
    });
  }

  void _onToggle() {
    setState(() => isPlaying = !isPlaying);

    if (_scaleController.isCompleted) {
      _scaleController.reverse();
    } else {
      _scaleController.forward();
    }
    if (isPlaying) {
      _startRecording();
    } else {
      _stopRecording();
    }
  }

  Future<void> _startRecording() async {
    widget.onRecordingStarted();

    var status = await Permission.microphone.request();
    if (!status.isGranted) {
      throw RecordingPermissionException("Microphone permission not granted");
    }

    final tempDir = await getTemporaryDirectory();
    _recordingPath = '${tempDir.path}/recording.aac';

    await _audioRecorder.startRecorder(
      toFile: _recordingPath,
      codec: Codec.aacADTS,
    );
  }

  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }
  }

  Future<void> _stopRecording() async {
    await _audioRecorder.stopRecorder();
    final file = File(_recordingPath);
    widget.onRecordingComplete(file);
    decibels.clear();
  }

// Build the recording icon.
  Widget _buildIcon() {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: GestureDetector(
        onTap: _onToggle,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: isPlaying
              ? const Icon(Icons.stop, color: Colors.red)
              : const Icon(Icons.mic, color: Color(0xff0092ff)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isPlaying) ...[
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () async {
              await _audioRecorder.stopRecorder();

              final file = File(_recordingPath);
              if (file.existsSync()) {
                file.deleteSync();
              }
              setState(() => isPlaying = !isPlaying);
              print("isPlaying: $isPlaying");
              decibels.clear();

              if (_scaleController.isCompleted) {
                _scaleController.reverse();
              } else {
                _scaleController.forward();
              }
              widget.onRecordingStarted();
            },
          ),
          Text(
            "${_recordingDuration.inMinutes}:${(_recordingDuration.inSeconds % 60).toString().padLeft(2, '0')}",
            style: AppTextStyles.bold14(),
          ),
          10.pw,
          _DecibelsVisualizer(decibels: decibels),
          15.pw,
        ],
        ConstrainedBox(
          constraints: const BoxConstraints(
              minWidth: 30, minHeight: 30, maxWidth: 50, maxHeight: 50),
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_showWaves) ...[
                  _Blob(
                    color: const Color(0xff0092ff),
                    scale: ((_currentDecibels * .75) / 100) + _scale,
                    rotation: _rotation,
                  ),
                  _Blob(
                    color: const Color(0xff4ac7b7),
                    scale: ((_currentDecibels * .5) / 100) + _scale,
                    rotation: _rotation * 2 - 30,
                  ),
                  _Blob(
                    color: const Color(0xffa4a6f6),
                    scale: ((_currentDecibels * .2) / 100) + _scale,
                    rotation: _rotation * 3 - 45,
                  ),
                ],
                Align(
                  child: AnimatedSwitcher(
                    duration: _kToggleDuration,
                    child: _buildIcon(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    cancelRecorderSubscriptions();
    if (isPlaying) {
      _audioRecorder.stopRecorder();
    }
    _scaleController.dispose();
    _rotationController.dispose();
    _audioRecorder.closeRecorder();
    super.dispose();
  }
}