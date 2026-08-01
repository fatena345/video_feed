import 'package:flutter/material.dart';
import 'package:tiktok/core/resources/app_colors.dart';
import 'package:tiktok/core/resources/app_fonts.dart';
import 'package:tiktok/core/resources/app_values.dart';

class VideoFailedWidget extends StatelessWidget {
  final VoidCallback onTryAgain;

  const VideoFailedWidget({super.key, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          _buildMockTikTokBackground(),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSadCloudIcon(),
                  SizedBox(height: AppHeight.h24),
                  Text(
                    "Failed to Load Videos",
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontSize: AppFontSize.s22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 SizedBox(height: AppHeight.h8),
                 Text(
                    "Something went wrong.\nPlease check your connection\nand try again.",
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
                        backgroundColor:  AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.r12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: onTryAgain,
                      child:  Text(
                        "Try Again",
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

  Widget _buildSadCloudIcon() {
    return SizedBox(
      width: AppWidth.w130,
      height: AppHeight.h130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 20,
            bottom: 30,
            child: Container(
              width: AppWidth.w60,
              height: AppHeight.h60,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 30,
            child: Container(
              width: AppWidth.w70,
              height: AppHeight.h70,
              decoration: const BoxDecoration(
                color: AppColors.lightBlue2,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 15,
            child: Container(
              width: AppWidth.w80,
              height: AppHeight.h80,
              decoration:  BoxDecoration(
                color: AppColors.lightBlue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 45,
            child: Column(
              spacing: AppHeight.h4,
              children: [
                Row(
                  spacing: AppWidth.w12,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: AppWidth.w6, height: AppHeight.h6, decoration:  BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                    
                    Container(width: AppWidth.w6, height: AppHeight.h6, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                  ],
                ),
                 
                CustomPaint(
                  size: Size(AppWidth.w12, AppHeight.h6),
                  painter: _FrownPainter(),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: AppHeight.h10,
            child:  Icon(
              Icons.flash_on,
              color: AppColors.primary,
              size: AppSize.s55,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockTikTokBackground() {
    return Positioned(
      right: AppWidth.w12,
      bottom: AppHeight.h100,
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

class _FrownPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =  AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(size.width / 2, 0, size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}