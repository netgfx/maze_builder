import 'dart:core';
import 'package:example/maze_drawer.dart';
import 'package:flutter/material.dart';
import 'package:maze_builder/maze_builder.dart';
import 'dart:ui' as ui;
import 'package:vector_math/vector_math.dart' as vectorMath;

class MazeDriverCanvas extends CustomPainter {
  List<Map<String, dynamic>> points = [];

  Color color = Colors.black;
  var index = 0;
  var offset = 0;
  AnimationController? controller;
  Canvas? canvas;
  int delay = 500;
  int currentTime = 0;
  int fps = 24;
  int printTime = DateTime.now().millisecondsSinceEpoch;
  int timeDecay = 0;
  double rate = 1.0;
  int timeToLive = 24;
  double width = 100;
  double height = 100;
  int curveIndex = 0;
  double computedAngle = 0.0;
  List<List<vectorMath.Vector2>> curve = [];
  Function? update;
  Paint _paint = Paint();
  int blockSize = 8;
  BoxConstraints sceneSize = const BoxConstraints(
      minWidth: 800, maxWidth: 1600, minHeight: 450, maxHeight: 900);
  ui.BlendMode? blendMode = ui.BlendMode.src;

  bool maxRightReached = false;
  List<List<Cell>> maze = [];
  MazeDrawer? mazeMap;
  //

  /// Constructor
  MazeDriverCanvas({
    /// <-- The animation controller
    required this.controller,

    /// <-- The delay until the animation starts
    required this.width,
    required this.height,
    required this.blockSize,
    required this.maze,

    /// <-- The particles blend mode (default: BlendMode.src)
    this.blendMode,
  }) : super(repaint: controller) {
    /// the delay in ms based on desired fps
    timeDecay = (1 / fps * 1000).round();
    _paint = Paint()
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..color = Colors.yellow
      ..strokeWidth = 2.0
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    /// make maze
    mazeMap = MazeDrawer(maze: maze, blockSize: blockSize);
  }

  @override
  void paint(Canvas canvas, Size size) {
    this.canvas = canvas;

    paintImage(canvas, size);

    mazeMap!.update(canvas);
  }

  void paintImage(Canvas canvas, Size size) async {
    draw(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void draw(Canvas canvas, Size size) {
    ///
  }
}
