import 'package:flutter/material.dart';
import 'package:tiktok/core/resources/app_colors.dart';
import 'package:tiktok/core/resources/app_values.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, "Home", true),
          _buildNavItem(Icons.search, "Discover", false),
          _buildAddButton(),
          _buildNavItem(Icons.message_outlined, "Inbox", false),
          _buildNavItem(Icons.person_outline, "Profile", false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppHeight.h2,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.white : Colors.grey[600],
          size: 24,
        ),
        
        Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.white : AppColors.greyDivider,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: 45,
      height: 30,
      decoration: BoxDecoration(
        color:AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.add,
        color: AppColors.white,
        size: 20,
      ),
    );
  }
}