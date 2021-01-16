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
    var url =
        'https://my-json-server.typicode.com/Numka/video_list/pages/${action.pageNumber}';
    try {
      //print('get to: $url');
      final response = await http.get(url);
      //print(json.decode(response.body));

      var extractedVideos = json.decode(response.body);
      print(extractedVideos);
    } catch (error) {
      throw error;
    }
  }
  next(action);
}
