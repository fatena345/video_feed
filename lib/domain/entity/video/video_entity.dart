import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final int id;
  final String videoUrl;
  final String thumbnail;
  final String username;
  final String caption;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final bool isLiked;

  const VideoEntity({
    required this.id,
    required this.videoUrl,
    required this.thumbnail,
    required this.username,
    required this.caption,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    this.isLiked = false,
  });

  VideoEntity copyWith({
    bool? isLiked,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
  }) {
    return VideoEntity(
      id: id,
      videoUrl: videoUrl,
      thumbnail: thumbnail,
      username: username,
      caption: caption,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  List<Object?> get props => [
        id,
        videoUrl,
        thumbnail,
        username,
        caption,
        likesCount,
        commentsCount,
        sharesCount,
        isLiked,
      ];
}