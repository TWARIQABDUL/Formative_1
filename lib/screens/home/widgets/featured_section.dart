import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../../Event/event_details.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

          children: [

            const Text(
              'Featured',

              style: TextStyle(
                fontSize: 18,
                fontWeight:
                FontWeight.bold,

                color:
                AppColors.textPrimary,
              ),
            ),

            TextButton(

              onPressed: () {},

              child: const Text(

                'See all',

                style: TextStyle(

                  color:
                  AppColors.primaryAccent,

                  fontWeight:
                  FontWeight.bold,

                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Container(

          width: double.infinity,

          decoration: BoxDecoration(

            borderRadius:
            BorderRadius.circular(20),

            gradient:
            LinearGradient(

              begin:
              Alignment.topCenter,

              end:
              Alignment.bottomCenter,

              colors: [

                const Color(
                    0xFF2C3E50)
                    .withValues(alpha: 0.8),

                const Color(
                    0xFF0F2027)
                    .withValues(alpha: 0.9),
              ],
            ),
          ),

          child: Padding(

            padding:
            const EdgeInsets.all(
                20),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const Text(

                  'ALU Entrepreneurship',

                  style: TextStyle(

                    color:
                    AppColors.textSecondary,

                    fontSize: 14,
                  ),
                ),

                const SizedBox(
                    height: 4),

                const Text(

                  'Pitch Night',

                  style: TextStyle(

                    color:
                    AppColors.textPrimary,

                    fontSize: 24,

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 12),

                const Text(

                  'May 24, 2026 • Kigali Campus',

                  style: TextStyle(

                    color:
                    AppColors.textSecondary,

                    fontSize: 14,
                  ),
                ),

                const SizedBox(
                    height: 8),

                const Text(

                  'Showcase your idea, get feedback,\nand connect with mentors.',

                  style: TextStyle(

                    color:
                    AppColors.textPrimary,

                    fontSize: 14,
                  ),
                ),

                const SizedBox(
                    height: 20),

                ElevatedButton(

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_)

                        =>
                        const EventDetailsScreen(),

                      ),

                    );

                  },

                  style:

                  ElevatedButton.styleFrom(

                    backgroundColor:
                    AppColors.primaryAccent,

                    foregroundColor:
                    Colors.black,

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(
                          24),
                    ),

                    padding:
                    const EdgeInsets.symmetric(

                      horizontal: 24,

                      vertical: 12,
                    ),
                  ),

                  child: const Text(

                    'View details',

                    style: TextStyle(

                      fontWeight:
                      FontWeight.bold,

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}