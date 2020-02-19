import 'dart:ui';

import 'package:flutter/material.dart';

class BLUR extends StatefulWidget {
  final Widget child;
  const BLUR({Key key, @required this.child}) : super(key: key);

  @override
  _BLURState createState() {
    return new _BLURState();
  }
}

class _BLURState extends State<BLUR> {
  final max = 10;

  ScrollPosition _position;
  double blur = 0;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings =
        context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);

    double maxReal = settings.maxExtent - settings.minExtent;
    double current = settings.currentExtent - settings.minExtent;
    double newBlur = max - ((current * max) / maxReal);
    setState(() {
      blur = newBlur;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blur,
              sigmaY: blur,
            ),
            child: Container(color: Colors.black.withOpacity(0)),
          ),
        ),
      ],
    );
  }
}
