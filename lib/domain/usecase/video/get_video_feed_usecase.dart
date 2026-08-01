import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tiktok/domain/entity/video/video_entity.dart';
import 'package:tiktok/domain/repository/i_video_repository.dart/i_video_repository.dart';
import '../../../core/exceptions/app_exception.dart';
import '../i_use_case.dart';

class GetVideoFeedParams {
  final String query;
  final int page;
  final int perPage;

  GetVideoFeedParams({
    required this.query,
    this.page = 1,
    this.perPage = 15,
  });
}

@injectable
class GetVideoFeedUseCase implements IUseCase<List<VideoEntity>, GetVideoFeedParams> {
  final IVideoRepository _repository;

  GetVideoFeedUseCase(this._repository);

  @override
  Future<Either<AppException, List<VideoEntity>>> call(GetVideoFeedParams params) {
    return _repository.getVideoFeed(
      query: params.query,
      page: params.page,
      perPage: params.perPage,
    );
  }
}