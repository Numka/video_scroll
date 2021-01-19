import 'actions.dart';
import 'store.dart';

AppState reducers(AppState prevState, dynamic action) {
  if (action is FetchVideosSucceded) {
    return prevState.copyWith(
      videos: action.fetchedVideos,
      pageNumber: prevState.pageNumber + 1,
      isFetching: false,
    );
  } else if (action is FetchingVideos) {
    return prevState.copyWith(
      isFetching: true,
    );
  } else if (action is FetchLastPageSucceded) {
    return prevState.copyWith(
      lastPage: action.lastPage,
    );
  } else if (action is ToggleAudio) {
    return prevState.copyWith(
      isSoundOn: !prevState.isSoundOn,
    );
  } else {
    return prevState.copyWith();
  }
}
