import 'package:dartz/dartz.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../entity/video/video_entity.dart';

abstract interface class IVideoRepository {
  Future<Either<AppException, List<VideoEntity>>> getVideoFeed({
    required String query,
    required int page,
    required int perPage,
  });
}