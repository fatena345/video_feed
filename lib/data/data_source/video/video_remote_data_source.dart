import 'package:injectable/injectable.dart';
import 'package:tiktok/core/exceptions/app_exception.dart';
import '../../../core/helper/network_helper.dart';
import '../../models/video/pexels_response_model.dart';

abstract interface class IVideoRemoteDataSource {
  Future<List<PexelsVideoItemModel>> searchVideos({
    required String query,
    required int page,
    required int perPage,
  });
}

@Injectable(as: IVideoRemoteDataSource)
class VideoRemoteDataSourceImpl implements IVideoRemoteDataSource {
  final NetworkHelper _networkHelper;

  VideoRemoteDataSourceImpl(this._networkHelper);

  @override
  Future<List<PexelsVideoItemModel>> searchVideos({
    required String query,
    required int page,
    required int perPage,
  }) async {
    final response = await _networkHelper.get(
      '/v1/videos/search',
      queryParams: {
        'query': query,
        'page': page,
        'per_page': perPage,
      },
    );

    return response.fold(
      (exception) => throw AppException(exception.message),
      (dioResponse) {
        final data = dioResponse.data;
        if (data == null) return [];
        final pexelsResponse = PexelsResponseModel.fromJson(data);
        return pexelsResponse.videos ?? [];
      },
    );
  }
}