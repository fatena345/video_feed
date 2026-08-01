import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppVideoCacheManager {
  static const String _key = 'pexelsVideoCacheKey';

  static final CacheManager _manager = CacheManager(
    Config(
      _key,
      stalePeriod: const Duration(days: 4),
      maxNrOfCacheObjects: 50,
      repo: JsonCacheInfoRepository(databaseName: _key),
      fileService: HttpFileService(),
    ),
  );

  static Future<File> getCacheOrDownload(String url) async {
    final fileInfo = await _manager.getFileFromCache(url);
    if (fileInfo != null && fileInfo.file.existsSync()) {
      return fileInfo.file;
    }
    return await _manager.getSingleFile(url);
  }
}