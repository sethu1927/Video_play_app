
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final File videoFile;

  const VideoPlayerWidget({Key? key, required this.videoFile}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(28.0),
      borderOnForeground: true,
      elevation: 16,
      child: GestureDetector(
      onTap: (){
        setState(() {
          if(_controller.value.isPlaying) {
            _controller.pause();

          } else{
            _controller.play();
          }
        });
      },
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),

            if( !_controller.value.isPlaying)
              Icon( Icons.play_arrow,
              size: 64,
              color: Colors.white.withOpacity(0.7),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(

                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 32,
                  ),
                  iconSize: 32,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying ? _controller.pause() : _controller.play();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
