import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:video_scroll/widgets/video_list_item.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';

import '../redux/store.dart';
import '../redux/actions.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final store = StoreProvider.of<AppState>(context);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('page = ${store.state.pageNumber} #######');
        if (store.state.pageNumber <= store.state.lastPage) {
          store.dispatch(FetchVideos(pageNumber: store.state.pageNumber));
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List Screen'),
      ),
      body: Container(
        //color: Colors.black87,
        child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) => Stack(
            children: [
              InViewNotifierList(
                controller: _scrollController,
                isInViewPortCondition:
                    (double deltaTop, double deltaBottom, double vpHeight) {
                  return deltaTop < (0.50 * vpHeight) &&
                      deltaBottom > (0.50 * vpHeight);
                },
                itemCount: state.videos.length,
                builder: (BuildContext ctx, int index) => InViewNotifierWidget(
                  id: state.videos[index].id,
                  builder: (BuildContext ctx, bool isInView, Widget child) {
                    return VideoListItem(
                      url: state.videos[index].url,
                      inView: isInView,
                    );
                  },
                ),
              ),
              state.isFetching
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    )
                  : SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// child: ListView.builder(
//   itemCount: DUMMY_DATA.length,
//   itemBuilder: (BuildContext ctx, int index) => VideoListItem(
//     videoPlayerController: VideoPlayerController.network(
//       DUMMY_DATA[index]['url'],
//       //'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
//     ),
//     looping: DUMMY_DATA[index]['looping'],
//   ),
// ),
