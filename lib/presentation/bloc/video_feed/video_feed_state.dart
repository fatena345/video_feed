import 'package:equatable/equatable.dart';
import 'package:tiktok/domain/entity/video/video_entity.dart';


sealed class IVideoFeedState extends Equatable {
  const IVideoFeedState();

  @override
  List<Object?> get props => [];
}

final class VideoFeedInitial extends IVideoFeedState {}

final class VideoFeedLoading extends IVideoFeedState {}

final class VideoFeedLoaded extends IVideoFeedState {
  final List<VideoEntity> videos;
  final String query;

  const VideoFeedLoaded({required this.videos, required this.query});

  @override
  List<Object?> get props => [videos, query];
}

final class VideoFeedFailed extends IVideoFeedState {
  final String errorMessage;

  const VideoFeedFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}