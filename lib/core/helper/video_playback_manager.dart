import 'dart:developer';
import 'dart:io';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:tiktok/core/helper/app_video_cache_manager.dart';


class VideoPlaybackManager {
  VideoPlaybackManager._();
  static final VideoPlaybackManager instance = VideoPlaybackManager._();

  final Map<int, CachedVideoPlayerPlus> _players = {};
  final Map<int, bool> _initializing = {};
  int _currentIndex = 0;
  List<String> _urls = [];

  void initializeFeed(List<String> urls) {
    _urls = urls;
    _clearAll();
    if (_urls.isNotEmpty) {
      _preload(0);
    }
  }

  CachedVideoPlayerPlus? getPlayer(int index) {
    return _players[index];
  }

  Future<void> onPageChanged(int newIndex) async {
    _currentIndex = newIndex;

    // إيقاف جميع الفيديوهات الأخرى فوراً لضمان عدم تشغيل أكثر من فيديو
    _players.forEach((index, player) {
      if (index != _currentIndex) {
        player.controller.pause();
      }
    });

    await _playCurrent();

    // تشغيل نظام الـ Preloading للفيديو التالي مسبقاً في الكاش محلياً
    if (_currentIndex + 1 < _urls.length) {
      _preload(_currentIndex + 1);
    }

    _cleanupPlayers();
  }

  Future<void> _preload(int index) async {
    if (_players.containsKey(index) || (_initializing[index] ?? false)) return;
    _initializing[index] = true;

    try {
      final url = _urls[index];
      final File cachedFile = await AppVideoCacheManager.getCacheOrDownload(url);
      final player = CachedVideoPlayerPlus.file(cachedFile);
      await player.initialize();
      await player.controller.setLooping(true);
      _players[index] = player;
    } catch (_) {
      try {
        final url = _urls[index];
        final player = CachedVideoPlayerPlus.networkUrl(Uri.parse(url));
        await player.initialize();
        await player.controller.setLooping(true);
        _players[index] = player;
      } catch (e) {
        log('Error initializing video at index $index: $e');
      }
    } finally {
      _initializing[index] = false;
    }
  }

  Future<void> _playCurrent() async {
    final index = _currentIndex;
    if (_players.containsKey(index)) {
      await _players[index]!.controller.play();
      return;
    }

    await _preload(index);
    if (_players.containsKey(index)) {
      await _players[index]!.controller.play();
    }
  }

  void _cleanupPlayers() {
    final keysToKeys = List<int>.from(_players.keys);
    for (final index in keysToKeys) {
      // إبقاء الكاش للمشغل الحالي والتالي والسابق فقط للتخلص الذكي من الذاكرة الزائدة
      if ((index - _currentIndex).abs() > 1) {
        final player = _players.remove(index);
        player?.controller.pause();
        player?.dispose();
      }
    }
  }

  void _clearAll() {
    _players.forEach((_, player) {
      player.controller.pause();
      player.dispose();
    });
    _players.clear();
    _initializing.clear();
    _currentIndex = 0;
  }

  void dispose() {
    _clearAll();
  }
}