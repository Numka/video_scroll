import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:video_scroll/redux/actions.dart';
import 'package:video_scroll/redux/middleware.dart';
import 'package:video_scroll/redux/reducers.dart';
import 'package:video_scroll/redux/store.dart';
import './screens/video_list_screen.dart';

void main() {
  Store<AppState> _store = Store<AppState>(
    reducers,
    initialState: AppState.initial(),
    middleware: [
      fetchVideosMiddleware,
      appStateMiddleware,
    ],
  );
  runApp(MyApp(
    store: _store,
  ));
}

class MyApp extends StatelessWidget {
  final Store store;

  const MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    store.dispatch(FetchVideos(pageNumber: store.state.pageNumber));
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: VideoListScreen(),
      ),
    );
  }
}
