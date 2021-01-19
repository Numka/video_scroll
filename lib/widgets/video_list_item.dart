import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:video_player/video_player.dart';

import '../redux/actions.dart';
import '../redux/store.dart';

class VideoListItem extends StatefulWidget {
  final String url;
  final bool inView;

  VideoListItem({
    @required this.url,
    @required this.inView,
    Key key,
  }) : super(key: key);
  @override
  _VideoListItemState createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  VideoPlayerController _controller;
  Future<void> _initVideoPlayerFuture;
  Store<AppState> store;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _controller.setVolume(1.0);
    _initVideoPlayerFuture = _controller.initialize();

    if (widget.inView) {
      _controller.play();
      _controller.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(covariant VideoListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.inView != widget.inView) {
      if (widget.inView) {
        store = StoreProvider.of<AppState>(context);
        _controller.setVolume(store.state.isSoundOn ? 1.0 : 0.0);
        _controller.play();
        _controller.setLooping(true);
      } else {
        _controller.pause();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).primaryColor,
        elevation: 8,
        child: Column(
          children: [
            FutureBuilder(
              future: _initVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: 4 / 3,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    ),
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
                  },
                ),
                IconButton(
                  icon: Icon(
                    _controller.value.volume == 0.0
                        ? Icons.volume_off
                        : Icons.volume_up,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_controller.value.volume == 0.0) {
                        _controller.setVolume(1.0);
                      } else {
                        _controller.setVolume(0.0);
                      }
                    });
                    store.dispatch(ToggleAudio());
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
