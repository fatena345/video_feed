
import 'package:flutter/material.dart';
import 'package:tiktok/core/resources/app_colors.dart';
import 'package:video_player/video_player.dart';
import '../../../core/helper/video_playback_manager.dart';
import '../../../core/resources/app_values.dart';

class VideoPlayerItem extends StatefulWidget {
  final int index;
  final String videoUrl;
  final String thumbnailUrl;

  const VideoPlayerItem({
    super.key,
    required this.index,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  @override
  void initState() {
    super.initState();
    _checkPlayback();
  }

  void _checkPlayback() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        final player = VideoPlaybackManager.instance.getPlayer(widget.index);
        if (player != null && player.controller.value.isInitialized) {
          setState(() {});
        } else {
          _checkPlayback();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final player = VideoPlaybackManager.instance.getPlayer(widget.index);
    final bool isInitialized = player != null && player.controller.value.isInitialized;

    return GestureDetector(
      onTap: () {
        if (player == null || !isInitialized) return;
        if (player.controller.value.isPlaying) {
          player.controller.pause();
        } else {
          player.controller.play();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!isInitialized)
            Image.network(
              widget.thumbnailUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, __, ___) => Container(color: AppColors.black),
            ),
          if (isInitialized && player != null)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  width: player.controller.value.size.width,
                  height: player.controller.value.size.height,
                  child: VideoPlayer(player.controller),
                ),
              ),
            ),
          if (!isInitialized)
            _buildLoadingOverlay(context),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay(BuildContext context) {
    return Container(
      width: AppWidth.w240.isFinite ? AppWidth.w240 : 240,
      padding: EdgeInsets.symmetric(
        vertical: AppPaddingHeight.p24,
        horizontal: AppPaddingWidth.p16,
      ),
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(AppRadius.r16),
        border: Border.all(color: AppColors.white.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppHeight.h15,
        children: [
          const CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 3,
          ),
          Text(
            "Loading videos...",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            "Please wait a moment",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:  AppColors.white70,
                ),
          ),
        ],
      ),
    );
  }
}