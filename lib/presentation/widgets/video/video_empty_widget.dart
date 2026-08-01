import 'package:flutter/material.dart';
import 'package:tiktok/core/resources/app_colors.dart';
import 'package:tiktok/core/resources/app_fonts.dart';
import 'package:tiktok/core/resources/app_values.dart';

class VideoEmptyWidget extends StatelessWidget {
  final VoidCallback onRefresh;

  const VideoEmptyWidget({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          _buildMockTikTokBackground(),
          Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: AppPaddingWidth.p24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildClapperboardIcon(),
                   SizedBox(height: AppHeight.h24),
                   Text(
                    "No Videos Available",
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontSize: AppFontSize.s22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 SizedBox(height: AppHeight.h8),
                  Text(
                    "There are no videos to show you\nright now. Check back later!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: AppFontSize.s14,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: AppHeight.h32),
                  SizedBox(
                    width: AppWidth.w180,
                    height: AppHeight.h48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: onRefresh,
                      child:  Text(
                        "Refresh",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: AppFontSize.s16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClapperboardIcon() {
    return SizedBox(
      width: 130,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                color: Color(0xFFE2F9F5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            child: Container(
              width: 70,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF2DD4BF), width: 2),
              ),
              child: const Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Color(0xFF2DD4BF),
                  size: 32,
                ),
              ),
            ),
          ),
          Positioned(
            top: 25,
            left: 20,
            child: Transform.rotate(
              angle: -0.2,
              child: Container(
                width: 70,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFF2DD4BF), width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (_) => Container(
                      width: 6,
                      height: 12,
                      color: const Color(0xFF2DD4BF),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockTikTokBackground() {
    return Positioned(
      right: 12,
      bottom: 100,
      child: Opacity(
        opacity: 0.15,
        child: Column(
          spacing: AppHeight.h16,
          children: [
            Container(width: AppWidth.w50, height: AppHeight.h50, decoration: const BoxDecoration(color: AppColors.grey, shape: BoxShape.circle)),
             SizedBox(height: AppHeight.h4),
             Icon(Icons.favorite, size: AppSize.s38),
            
             Icon(Icons.chat_bubble, size: AppSize.s38),
            
             Icon(Icons.share, size: AppSize.s38),
          ],
        ),
      ),
    );
  }
}