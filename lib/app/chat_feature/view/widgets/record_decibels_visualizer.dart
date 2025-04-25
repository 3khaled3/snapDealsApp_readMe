part of 'recording_button.dart';

class _DecibelsVisualizer extends StatefulWidget {
  final List<double> decibels;
  const _DecibelsVisualizer({required this.decibels});

  @override
  State<_DecibelsVisualizer> createState() => __DecibelsVisualizerState();
}

class __DecibelsVisualizerState extends State<_DecibelsVisualizer> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant _DecibelsVisualizer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll to the end when new data comes in
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.sizeOf(context).width * .55,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          children: List.generate(
            widget.decibels.length,
            (index) {
              return Container(
                height: ((widget.decibels[index]) - 20).clamp(5, 40),
                width: 3,
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: ColorsBox.grey700,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color color;

  const _Blob({required this.color, this.rotation = 0, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          height: 270,
          width: 270,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}
