import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'store.dart';
import 'actions.dart';
import '../models/video_item.dart';

void appStateMiddleware(
  Store<AppState> store,
  dynamic action,
  NextDispatcher next,
) {
  next(action);
}

void fetchVideosMiddleware(
  Store<AppState> store,
  dynamic action,
  NextDispatcher next,
) async {
  if (action is FetchVideos) {
    print('page = ${action.pageNumber} #######');
    var url =
        'https://my-json-server.typicode.com/Numka/video_list/pages/${action.pageNumber}';
    try {
      final response = await http.get(url);

      var extractedVideos = json.decode(response.body);
      final List<VideoItem> videoList = store.state.videos;
      for (var exvideo in extractedVideos['videos']) {
        videoList
            .add(VideoItem(id: exvideo['id'].toString(), url: exvideo['url']));
      }
      store.dispatch(FetchVideosSucceded(fetchedVideos: videoList));
    } catch (error) {
      throw error;
    }
  }
  next(action);
}
