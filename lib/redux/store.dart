import '../models/video_item.dart';
import 'package:flutter/material.dart';

class AppState {
  List<VideoItem> videos;
  bool isFetching;
  Exception error;
  int pageNumber;
  bool isSoundOn;

  AppState({
    @required this.videos,
    @required this.isFetching,
    @required this.error,
    @required this.pageNumber,
    @required this.isSoundOn,
  });

  AppState copyWith({
    AppState prev,
    List<VideoItem> videos,
    bool isFetching,
    Exception error,
    int pageNumber,
    bool isSoundOn,
  }) {
    return AppState(
      videos: videos ?? this.videos,
      isFetching: isFetching ?? this.isFetching,
      error: error ?? this.error,
      pageNumber: pageNumber ?? this.pageNumber,
      isSoundOn: isSoundOn ?? this.isSoundOn,
    );
  }

  AppState.initial() {
    this.videos = [];
    this.isFetching = false;
    this.error = null;
    this.pageNumber = 1;
    this.isSoundOn = true;
  }
}
