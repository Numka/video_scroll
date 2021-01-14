import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//import 'package:chewie/chewie.dart';
import 'package:video_scroll/widgets/video_list_item.dart';
import 'package:video_scroll/dummy_data.dart';

class VideoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List Screen'),
      ),
      body: Container(
        //color: Colors.black87,
        child: ListView.builder(
          itemCount: DUMMY_DATA.length,
          itemBuilder: (BuildContext ctx, int index) => VideoListItem(
            videoPlayerController: VideoPlayerController.network(
              DUMMY_DATA[index]['url'],
              //'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            ),
            looping: DUMMY_DATA[index]['looping'],
          ),
        ),
      ),
    );
  }
}
