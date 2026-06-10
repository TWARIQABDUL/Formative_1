import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../home/widgets/custom_search_bar.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Events', 'Opportunities', 'Clubs'];

  // Mock list of recommended items matching the design
  final List<Map<String, dynamic>> _allRecommendations = [
    {
      'title': 'Campus Ambassador Program',
      'subtitle': 'Apply by May 22, 2026',
      'type': 'Opportunity',
      'category': 'Opportunities',
      'icon': Icons.explore_outlined,
      'iconBg': const Color(0xFF6C5CE7),
      'badgeColor': const Color(0xFF9E8CF4),
      'actionIcon': Icons.open_in_full,
    },
    {
      'title': 'ALU Climate Action Week',
      'subtitle': 'May 26 - May 30, 2026',
      'type': 'Event',
      'category': 'Events',
      'icon': Icons.calendar_today_outlined,
      'iconBg': const Color(0xFF0984E3),
      'badgeColor': const Color(0xFF74B9FF),
      'actionIcon': Icons.chevron_right,
    },
    {
      'title': 'Build Your First MVP Workshop',
      'subtitle': 'June 2, 2026',
      'type': 'Event',
      'category': 'Events',
      'icon': Icons.groups_outlined,
      'iconBg': const Color(0xFFD63031),
      'badgeColor': const Color(0xFF74B9FF),
      'actionIcon': Icons.open_in_full,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter items based on active category
    final filteredRecommendations = _allRecommendations.where((item) {
      if (_selectedCategory == 'All') return true;
      return item['category'] == _selectedCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                          color: AppColors.textPrimary,
                          size: 28,
                        ),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      Positioned(
                        right: 12,
                        top: 10,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFB703), // Orange/yellow dot
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search Bar
              const CustomSearchBar(hintText: 'Search...'),
              const SizedBox(height: 20),

              // Category Tabs (Horizontal list of pills)
              SizedBox(
                height: 38,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final isSelected = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.searchBackground
                                : AppColors.cardBackground.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.textSecondary.withValues(alpha: 0.3)
                                  : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),

              // Section Heading
              const Text(
                'Recommended for you',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // List of cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredRecommendations.length,
                itemBuilder: (context, index) {
                  final item = filteredRecommendations[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left graphic icon
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: item['iconBg'],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            item['icon'],
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Middle details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item['subtitle'],
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Tag badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: item['badgeColor'].withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: item['badgeColor'].withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  item['type'],
                                  style: TextStyle(
                                    color: item['badgeColor'],
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Right action icon
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Icon(
                              item['actionIcon'],
                              color: AppColors.textSecondary,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
