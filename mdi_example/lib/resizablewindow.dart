// ignore: file_names
import 'package:flutter/material.dart';

class ResizableWindow extends StatefulWidget {
  final String title;
  final Widget body;

  const ResizableWindow(this.title, this.body, {super.key});

  @override
  State<ResizableWindow> createState() => _ResizableWindowState();
}

class _ResizableWindowState extends State<ResizableWindow> {
  final _headerSize = 50.0;
  final _borderRadius = 10.0;

  double currentHeight = 400;
  double currentWidth = 400;

  double defaultHeight = 400;
  double defaultWidth = 400;

  double x = 10;
  double y = 10;

  late Function(double, double) onWindowDragged;
  late VoidCallback onCloseButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //Here goes the same radius, u can put into a var or function
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x54000000),
            spreadRadius: 4,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        child: Stack(
          children: [
            Column(
              children: [_getHeader(), _getBody()],
            ),
            Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragRight,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    opaque: true,
                    child: Container(
                      width: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragLeft,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    opaque: true,
                    child: Container(
                      width: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragUpdate: _onHorizontalDragTop,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    opaque: true,
                    child: Container(
                      height: 4,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragUpdate: _onHorizontalDragBottom,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    opaque: true,
                    child: Container(
                      height: 4,
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragBottomRight,
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: SizedBox(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                bottom: 0,
                left: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragBottomLeft,
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: SizedBox(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragTopRight,
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    opaque: true,
                    child: SizedBox(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                child: GestureDetector(
                  onPanUpdate: _onHorizontalDragTopLeft,
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    opaque: true,
                    child: SizedBox(
                      height: 6,
                      width: 6,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  _getHeader() {
    return GestureDetector(
      onPanUpdate: (tapInfo) {
        onWindowDragged(tapInfo.delta.dx, tapInfo.delta.dy);
      },
      child: Container(
        width: currentWidth,
        height: _headerSize,
        color: Colors.lightBlueAccent,
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                  onTap: () {
                    onCloseButtonClicked();
                  },
                  child: const Icon(
                    Icons.circle,
                    color: Colors.red,
                  )),
            ),
            Positioned.fill(child: Center(child: Text(widget.title))),
          ],
        ),
      ),
    );
  }

  _getBody() {
    return Container(
      width: currentWidth,
      height: currentHeight - _headerSize,
      color: Colors.blueGrey,
      child: widget.body,
    );
  }

  void _onHorizontalDragLeft(DragUpdateDetails details) {
    setState(() {
      currentWidth -= details.delta.dx;
      if (currentWidth < defaultWidth) {
        currentWidth = defaultWidth;
      } else {
        onWindowDragged(details.delta.dx, 0);
      }
    });
  }

  void _onHorizontalDragRight(DragUpdateDetails details) {
    setState(() {
      currentWidth += details.delta.dx;
      if (currentWidth < defaultWidth) {
        currentWidth = defaultWidth;
      }
    });
  }

  void _onHorizontalDragBottom(DragUpdateDetails details) {
    setState(() {
      currentHeight += details.delta.dy;
      if (currentHeight < defaultHeight) {
        currentHeight = defaultHeight;
      }
    });
  }

  void _onHorizontalDragTop(DragUpdateDetails details) {
    setState(() {
      currentHeight -= details.delta.dy;
      if (currentHeight < defaultHeight) {
        currentHeight = defaultHeight;
      } else {
        onWindowDragged(0, details.delta.dy);
      }
    });
  }

  void _onHorizontalDragBottomRight(DragUpdateDetails details) {
    _onHorizontalDragRight(details);
    _onHorizontalDragBottom(details);
  }

  void _onHorizontalDragBottomLeft(DragUpdateDetails details) {
    _onHorizontalDragLeft(details);
    _onHorizontalDragBottom(details);
  }

  void _onHorizontalDragTopRight(DragUpdateDetails details) {
    _onHorizontalDragRight(details);
    _onHorizontalDragTop(details);
  }

  void _onHorizontalDragTopLeft(DragUpdateDetails details) {
    _onHorizontalDragLeft(details);
    _onHorizontalDragTop(details);
  }
}
