import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCategoryItem(Icons.grid_view_rounded, 'All', AppColors.iconYellow),
        _buildCategoryItem(Icons.calendar_month_outlined, 'Events', AppColors.iconPurple),
        _buildCategoryItem(Icons.workspace_premium_outlined, 'Opportunities', AppColors.iconBlue),
        _buildCategoryItem(Icons.diamond_outlined, 'Clubs', AppColors.iconGreen),
        _buildCategoryItem(Icons.school_outlined, 'Academics', AppColors.iconLightBlue),
      ],
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
