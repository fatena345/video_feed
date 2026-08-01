// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../data/data_source/video/video_remote_data_source.dart' as _i408;
import '../../../data/repository/video/video_repository_impl.dart' as _i550;
import '../../../domain/repository/i_video_repository.dart/i_video_repository.dart'
    as _i831;
import '../../../domain/usecase/video/get_video_feed_usecase.dart' as _i1010;
import '../../../presentation/bloc/video_feed/video_feed_bloc.dart' as _i583;
import '../../helper/network_helper.dart' as _i779;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i779.NetworkHelper>(() => _i779.NetworkHelper());
    gh.factory<_i408.IVideoRemoteDataSource>(
        () => _i408.VideoRemoteDataSourceImpl(gh<_i779.NetworkHelper>()));
    gh.factory<_i831.IVideoRepository>(
        () => _i550.VideoRepositoryImpl(gh<_i408.IVideoRemoteDataSource>()));
    gh.factory<_i1010.GetVideoFeedUseCase>(
        () => _i1010.GetVideoFeedUseCase(gh<_i831.IVideoRepository>()));
    gh.factory<_i583.VideoFeedBloc>(
        () => _i583.VideoFeedBloc(gh<_i1010.GetVideoFeedUseCase>()));
    return this;
  }
}
