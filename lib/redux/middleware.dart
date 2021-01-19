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
  if (action is FetchLastPage) {
    var urlForLastPage =
        'https://my-json-server.typicode.com/Numka/video_list/lastPage';
    try {
      final responseForLastPage = await http.get(urlForLastPage);
      var extractedLastPage = json.decode(responseForLastPage.body);
      store.dispatch(FetchLastPageSucceded(lastPage: extractedLastPage['at']));
    } catch (error) {
      throw error;
    }
  } else if (action is FetchVideos) {
    var urlForVideos =
        'https://my-json-server.typicode.com/Numka/video_list/pages/${action.pageNumber}';
    try {
      store.dispatch(FetchingVideos());
      final responseForVideos = await http.get(urlForVideos);

      var extractedVideos = json.decode(responseForVideos.body);

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
