import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tiktok/data/data_source/video/video_remote_data_source.dart';
import 'package:tiktok/domain/repository/i_video_repository.dart/i_video_repository.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../domain/entity/video/video_entity.dart';
import '../../models/video/video_model_mapper.dart';

@Injectable(as: IVideoRepository)
class VideoRepositoryImpl implements IVideoRepository {
  final IVideoRemoteDataSource _remoteDataSource;

  VideoRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<AppException, List<VideoEntity>>> getVideoFeed({
    required String query,
    required int page,
    required int perPage,
  }) async {
    try {
      final remoteModels = await _remoteDataSource.searchVideos(
        query: query,
        page: page,
        perPage: perPage,
      );
      final List<VideoEntity> entities = remoteModels
          .map((model) => VideoModelMapper.toEntity(model))
          .toList();
      return Right(entities);
    } catch (e) {
      return Left(e is AppException ? e : UnKnownException(e.toString()));
    }
  }
}