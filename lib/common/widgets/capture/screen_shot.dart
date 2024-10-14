import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';

class ScreenshotWidget extends StatefulWidget {
  final Widget child;
  final double fullWidth;
  final String fileName;
  final String shareText;

  const ScreenshotWidget({
    super.key,
    required this.child,
    required this.fullWidth,
    this.fileName = 'captured_widget.png',
    this.shareText = 'Check out this image!',
  });

  @override
  _ScreenshotWidgetState createState() => _ScreenshotWidgetState();
}

class _ScreenshotWidgetState extends State<ScreenshotWidget> {
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: widget.fullWidth, // Full width of the content
            child: GestureDetector(
              onDoubleTap: _captureAndShareWidget,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _captureAndShareWidget() async {
    try {
      // Capture the widget as an image
      Uint8List? imageBytes =
          await _screenshotController.capture(pixelRatio: 3.0);
      if (imageBytes != null) {
        final directory = await getTemporaryDirectory();
        String path = '${directory.path}/${widget.fileName}';
        final file = File(path);
        await file.writeAsBytes(imageBytes);
        await Share.shareXFiles([XFile(path)], text: widget.shareText);
      }
    } catch (e) {
      print('Error capturing or sharing widget: $e');
    }
  }
}
