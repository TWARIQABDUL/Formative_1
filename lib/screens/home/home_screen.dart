import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'widgets/header_section.dart';
import 'widgets/custom_search_bar.dart';
import 'widgets/category_list.dart';
import 'widgets/featured_section.dart';
import 'widgets/latest_opportunities_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeaderSection(name: 'Aline'),
              SizedBox(height: 24),
              CustomSearchBar(),
              SizedBox(height: 24),
              CategoryList(),
              SizedBox(height: 32),
              FeaturedSection(),
              SizedBox(height: 32),
              LatestOpportunitiesSection(),
              SizedBox(height: 40), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
