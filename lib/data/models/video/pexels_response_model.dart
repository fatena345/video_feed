import 'package:json_annotation/json_annotation.dart';

part 'pexels_response_model.g.dart';

@JsonSerializable()
class PexelsResponseModel {
  @JsonKey(name: 'videos')
  final List<PexelsVideoItemModel>? videos;

  PexelsResponseModel({this.videos});

  factory PexelsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PexelsResponseModelFromJson(json);
      
  Map<String, dynamic> toJson() => _$PexelsResponseModelToJson(this);
}

@JsonSerializable()
class PexelsVideoItemModel {
  final int? id;
  final int? width;
  final int? height;
  final String? image;
  final PexelsUserModel? user;
  @JsonKey(name: 'video_files')
  final List<PexelsVideoFileModel>? videoFiles;

  PexelsVideoItemModel({
    this.id,
    this.width,
    this.height,
    this.image,
    this.user,
    this.videoFiles,
  });

  factory PexelsVideoItemModel.fromJson(Map<String, dynamic> json) =>
      _$PexelsVideoItemModelFromJson(json);
      
  Map<String, dynamic> toJson() => _$PexelsVideoItemModelToJson(this);
}

@JsonSerializable()
class PexelsVideoFileModel {
  final int? id;
  final String? quality;
  @JsonKey(name: 'file_type')
  final String? fileType;
  final int? width;
  final int? height;
  final String? link;

  PexelsVideoFileModel({
    this.id,
    this.quality,
    this.fileType,
    this.width,
    this.height,
    this.link,
  });

  factory PexelsVideoFileModel.fromJson(Map<String, dynamic> json) =>
      _$PexelsVideoFileModelFromJson(json);
      
  Map<String, dynamic> toJson() => _$PexelsVideoFileModelToJson(this);
}

@JsonSerializable()
class PexelsUserModel {
  final int? id;
  final String? name;
  final String? url;

  PexelsUserModel({this.id, this.name, this.url});

  factory PexelsUserModel.fromJson(Map<String, dynamic> json) =>
      _$PexelsUserModelFromJson(json);
      
  Map<String, dynamic> toJson() => _$PexelsUserModelToJson(this);
}