import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//import 'package:chewie/chewie.dart';

class VideoListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  VideoListItem({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);
  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  //ChewieController _chewieController;
  VideoPlayerController _controller;
  Future<void> _initVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = widget.videoPlayerController;
    _controller.setLooping(widget.looping);
    _initVideoPlayerFuture = _controller.initialize();
    // _chewieController = ChewieController(
    //   videoPlayerController: widget.videoPlayerController,
    //   //: widget.videoPlayerController.value.aspectRatio,
    //   aspectRatio: 4 / 3,
    //   customControls: ,
    //   autoInitialize: true,
    //   looping: widget.looping,
    //   errorBuilder: (context, errorMessage) {
    //     return Center(
    //       child: Text(
    //         errorMessage,
    //         style: TextStyle(color: Colors.white),
    //       ),
    //     );
    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    //_chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.black54,
        elevation: 8,
        child: Column(
          children: [
            FutureBuilder(
              future: _initVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    //aspectRatio: _controller.value.aspectRatio,
                    aspectRatio: 4 / 3,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    }),
                Icon(
                  Icons.volume_mute,
                  size: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
