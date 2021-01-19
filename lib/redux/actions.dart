import 'package:flutter/material.dart';
import 'package:video_scroll/models/video_item.dart';

abstract class Action {}

class FetchVideos extends Action {
  int pageNumber;

  FetchVideos({
    @required this.pageNumber,
  });
}

class FetchingVideos extends Action {}

class FetchVideosSucceded extends Action {
  final List<VideoItem> fetchedVideos;

  FetchVideosSucceded({
    @required this.fetchedVideos,
  });
}

class FetchVideosFailed extends Action {
  final Exception error;

  FetchVideosFailed({
    @required this.error,
  });
}

class FetchLastPage extends Action {}

class FetchLastPageSucceded extends Action {
  final int lastPage;

  FetchLastPageSucceded({
    @required this.lastPage,
  });
}

class ToggleAudio extends Action {}
