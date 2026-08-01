import 'package:flutter/material.dart';
import 'package:tiktok/core/resources/app_colors.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/resources/app_fonts.dart';

class VideoDescription extends StatelessWidget {
  final String username;
  final String caption;

  const VideoDescription({
    super.key,
    required this.username,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppPaddingWidth.p15,
      bottom: AppHeight.h100,
      right: AppWidth.w100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppHeight.h7, // استخدام ميزة الـ spacing المحدثة بدلاً من SizedBox اليدوية
        children: [
          Row(
            spacing: AppWidth.w7,
            children: [
              Text(
                "@$username",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.s15,
                  shadows: const [Shadow(color: AppColors.black, blurRadius: 4)],
                ),
              ),
              const Icon(
                Icons.verified,
                color: AppColors.primary,
                size: 16,
              ),
            ],
          ),
          if (caption.isNotEmpty)
            Text(
              caption,
              style: TextStyle(
                color: AppColors.white,
                fontSize: AppFontSize.s13,
                shadows: [Shadow(color: AppColors.black, blurRadius: 4)],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }
}