import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entity/video/video_entity.dart';
import '../../../domain/usecase/video/get_video_feed_usecase.dart';

import 'video_feed_event.dart';
import 'video_feed_state.dart';


@injectable
class VideoFeedBloc extends Bloc<IVideoFeedEvent, IVideoFeedState> {

  final GetVideoFeedUseCase _getVideoFeedUseCase;

  VideoFeedBloc(
    this._getVideoFeedUseCase,
  ) : super(VideoFeedInitial()) {

    on<FetchVideosEvent>(_onFetchVideos);

    on<ToggleLikeVideoEvent>(_onToggleLikeVideo);
  }


  FutureOr<void> _onFetchVideos(
    FetchVideosEvent event,
    Emitter<IVideoFeedState> emit,
  ) async {

    if (event.isRefresh || state is! VideoFeedLoaded) {
      emit(VideoFeedLoading());
    }


    final result = await _getVideoFeedUseCase(
      GetVideoFeedParams(
        query: event.query,
        page: 1,
        perPage: 15,
      ),
    );


    result.fold(
      (failure) {

        emit(
          VideoFeedFailed(
            errorMessage: failure.message,
          ),
        );

      },

      (videos) {

        if (videos.isEmpty) {

          emit(
            const VideoFeedFailed(
              errorMessage: 'No videos available.',
            ),
          );

        } else {

          emit(
            VideoFeedLoaded(
              videos: videos,
              query: event.query,
            ),
          );

        }

      },
    );
  }




  FutureOr<void> _onToggleLikeVideo(
    ToggleLikeVideoEvent event,
    Emitter<IVideoFeedState> emit,
  ) {

    final currentState = state;


    if (currentState is VideoFeedLoaded) {


      final List<VideoEntity> updatedList =
          currentState.videos.map((video) {


        if (video.id == event.videoId) {


          final bool isLikedNow = !video.isLiked;


          final int newLikesCount =
              isLikedNow
                  ? video.likesCount + 1
                  : video.likesCount - 1;


          return video.copyWith(
            isLiked: isLikedNow,
            likesCount: newLikesCount < 0
                ? 0
                : newLikesCount,
          );

        }


        return video;


      }).toList();



      emit(
        VideoFeedLoaded(
          videos: updatedList,
          query: currentState.query,
        ),
      );

    }

  }

}