import 'package:flutter/material.dart';
import 'package:tiktok/core/resources/app_colors.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/resources/app_fonts.dart';

class VideoActionBar extends StatelessWidget {
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final VoidCallback onLike;

  const VideoActionBar({
    super.key,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.isLiked,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: AppPaddingWidth.p12,
      bottom: AppHeight.h100,
      child: Column(
        spacing: AppHeight.h15, // استخدام نظام الـ spacing المعتمد في المشروع
        children: [
          _buildUserAvatar(),
          _buildActionItem(
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : Colors.white,
            count: _formatCount(likes),
            onTap: onLike,
          ),
          _buildActionItem(
            icon: Icons.chat_bubble_outline,
            color: AppColors.white,
            count: _formatCount(comments),
            onTap: () {},
          ),
          _buildActionItem(
            icon: Icons.share,
            color: AppColors.white,
            count: _formatCount(shares),
            onTap: () {},
          ),
          _buildSpinningDisc(),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: AppWidth.w50,
          height: AppHeight.h50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: AppWidth.w2),
            image: const DecorationImage(
              image: NetworkImage('https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=100'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: -AppHeight.h7,
          child: Container(
            width: AppWidth.w20,
            height: AppHeight.h20,
            decoration: const BoxDecoration(
              color: Color(0xFFFE2C55),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 14,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required Color color,
    required String count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        spacing: AppHeight.h5,
        children: [
          Icon(icon, color: color, size: AppSize.s40),
          Text(
            count,
            style: TextStyle(
              color: AppColors.white,
              fontSize: AppFontSize.s12,
              fontWeight: AppFontWeight.bold,
              shadows: const [
                Shadow(color: AppColors.black, blurRadius: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpinningDisc() {
    return const SpinningDiscWidget();
  }

  String _formatCount(int number) {
    if (number >= 1000) {
      return "${(number / 1000).toStringAsFixed(1)}K";
    }
    return number.toString();
  }
}

class SpinningDiscWidget extends StatefulWidget {
  const SpinningDiscWidget({super.key});

  @override
  State<SpinningDiscWidget> createState() => _SpinningDiscWidgetState();
}

class _SpinningDiscWidgetState extends State<SpinningDiscWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        width: AppWidth.w45,
        height: AppHeight.h45,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [AppColors.lightBlack, AppColors.black],
            stops: [0.6, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPaddingWidth.p8, vertical: AppPaddingWidth.p8),
          child: ClipOval(
            child: Image.network(
              'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=100',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}