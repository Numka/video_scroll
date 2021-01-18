import '../models/video_item.dart';
import 'package:flutter/material.dart';

class AppState {
  List<VideoItem> videos;
  bool isFetching;
  Exception error;
  int pageNumber;
  int lastPage;
  bool isSoundOn;

  AppState({
    @required this.videos,
    @required this.isFetching,
    @required this.error,
    @required this.pageNumber,
    @required this.isSoundOn,
    @required this.lastPage,
  });

  AppState copyWith({
    AppState prev,
    List<VideoItem> videos,
    bool isFetching,
    Exception error,
    int pageNumber,
    int lastPage,
    bool isSoundOn,
  }) {
    return AppState(
      videos: videos ?? this.videos,
      isFetching: isFetching ?? this.isFetching,
      error: error ?? this.error,
      pageNumber: pageNumber ?? this.pageNumber,
      isSoundOn: isSoundOn ?? this.isSoundOn,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  AppState.initial() {
    this.videos = [];
    this.isFetching = false;
    this.error = null;
    this.pageNumber = 1;
    this.lastPage = null;
    this.isSoundOn = true;
  }
}
