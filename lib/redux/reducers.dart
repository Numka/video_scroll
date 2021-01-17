import 'actions.dart';
import 'store.dart';

AppState reducers(AppState prevState, dynamic action) {
  // switch (action) {
  //   case FetchVideosSucceded:
  //     print('page ${action.fetchedVideos}');
  //     print('page ${prevState.pageNumber}');
  //     return prevState.copyWith(
  //       videos: action.fetchedVideos,
  //       pageNumber: prevState.pageNumber + 1,
  //     );
  //     break;
  //   // case FetchVideosFailed:
  //   //   return prevState.copyWith();
  //   //   break;
  //   default:
  //     return prevState.copyWith(
  //       videos: action.fetchedVideos,
  //       pageNumber: prevState.pageNumber,
  //     );
  //     break;
  // }

  if (action is FetchVideosSucceded) {
    print('page ${action.fetchedVideos}');
    print('page ${prevState.pageNumber}');
    return prevState.copyWith(
      videos: action.fetchedVideos,
      pageNumber: prevState.pageNumber + 1,
    );
  } else {
    return prevState.copyWith(
      videos: action.fetchedVideos,
      pageNumber: prevState.pageNumber,
    );
  }
}
