// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pexels_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PexelsResponseModel _$PexelsResponseModelFromJson(Map<String, dynamic> json) =>
    PexelsResponseModel(
      videos: (json['videos'] as List<dynamic>?)
          ?.map((e) => PexelsVideoItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PexelsResponseModelToJson(
        PexelsResponseModel instance) =>
    <String, dynamic>{
      'videos': instance.videos,
    };

PexelsVideoItemModel _$PexelsVideoItemModelFromJson(
        Map<String, dynamic> json) =>
    PexelsVideoItemModel(
      id: (json['id'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      image: json['image'] as String?,
      user: json['user'] == null
          ? null
          : PexelsUserModel.fromJson(json['user'] as Map<String, dynamic>),
      videoFiles: (json['video_files'] as List<dynamic>?)
          ?.map((e) => PexelsVideoFileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PexelsVideoItemModelToJson(
        PexelsVideoItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'width': instance.width,
      'height': instance.height,
      'image': instance.image,
      'user': instance.user,
      'video_files': instance.videoFiles,
    };

PexelsVideoFileModel _$PexelsVideoFileModelFromJson(
        Map<String, dynamic> json) =>
    PexelsVideoFileModel(
      id: (json['id'] as num?)?.toInt(),
      quality: json['quality'] as String?,
      fileType: json['file_type'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      link: json['link'] as String?,
    );

Map<String, dynamic> _$PexelsVideoFileModelToJson(
        PexelsVideoFileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quality': instance.quality,
      'file_type': instance.fileType,
      'width': instance.width,
      'height': instance.height,
      'link': instance.link,
    };

PexelsUserModel _$PexelsUserModelFromJson(Map<String, dynamic> json) =>
    PexelsUserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$PexelsUserModelToJson(PexelsUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };
