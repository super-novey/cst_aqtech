import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CaptureWidget extends StatefulWidget {
  final Widget child;
  final double fullWidth;
  final String fileName;
  final String shareText;

  const CaptureWidget({
    super.key,
    required this.child,
    required this.fullWidth,
    this.fileName = 'captured_widget.png',
    this.shareText = 'Check out this image!',
  });

  @override
  _CaptureWidgetState createState() => _CaptureWidgetState();
}

class _CaptureWidgetState extends State<CaptureWidget> {
  final GlobalKey _captureKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: RepaintBoundary(
          key: _captureKey,
          child: GestureDetector(
            child: SizedBox(
              width: widget.fullWidth, // Full width of the content
              child: GestureDetector(
                  onDoubleTap: _captureAndShareWidget,
                  child: Align(
                      alignment: Alignment.centerLeft, child: widget.child)),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _captureAndShareWidget() async {
    try {
      // Capture the entire widget as an image
      RenderRepaintBoundary boundary = _captureKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final buffer = byteData.buffer.asUint8List();
        final directory = await getTemporaryDirectory();
        String path = '${directory.path}/${widget.fileName}';
        final file = File(path);
        await file.writeAsBytes(buffer);
        await Share.shareXFiles([XFile(path)], text: widget.shareText);
      }
    } catch (e) {
      print('Error capturing or sharing widget: $e');
    }
  }
}
