import 'package:equatable/equatable.dart';

sealed class IVideoFeedEvent extends Equatable {
  const IVideoFeedEvent();

  @override
  List<Object?> get props => [];
}

class FetchVideosEvent extends IVideoFeedEvent {
  final String query;
  final bool isRefresh;

  const FetchVideosEvent({required this.query, this.isRefresh = false});

  @override
  List<Object?> get props => [query, isRefresh];
}

class ToggleLikeVideoEvent extends IVideoFeedEvent {
  final int videoId;

  const ToggleLikeVideoEvent({required this.videoId});

  @override
  List<Object?> get props => [videoId];
}