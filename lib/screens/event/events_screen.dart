import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  // State for the active RSVP filter tab: 'Going' or 'Interested'
  String _activeTab = 'Going';

  // Mock list of RSVPs matching the design screenshots
  final List<Map<String, dynamic>> _events = [
    {
      'title': 'AI for Social Impact Workshop',
      'date': 'Jun 5, 2026',
      'location': 'Mauritius',
      'image': 'assets/images/ai_workshop.png',
      'isGoing': true,
    },
    {
      'title': 'Pitch Night',
      'date': 'May 24, 2026',
      'location': 'Kigali',
      'image': 'assets/images/pitch_night.png',
      'isGoing': true,
    },
    {
      'title': 'Design Thinking Bootcamp',
      'date': 'May 30, 2026',
      'location': 'Kigali',
      'image': 'assets/images/design_thinking.png',
      'isGoing': false, // Interested
    },
    {
      'title': 'Community Clean Up',
      'date': 'May 18, 2026',
      'location': 'Mauritius',
      'image': 'assets/images/clean_up.png',
      'isGoing': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter RSVPs based on the selected tab
    final filteredEvents = _events.where((item) {
      if (_activeTab == 'Going') {
        return item['isGoing'] == true;
      } else {
        return item['isGoing'] == false;
      }
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textPrimary,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My RSVPs',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              // Custom Toggle Tab Bar
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // 'Going' Tab Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _activeTab = 'Going';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: _activeTab == 'Going'
                                  ? AppColors.primaryAccent
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Going',
                              style: TextStyle(
                                color: _activeTab == 'Going'
                                    ? AppColors.primaryAccent
                                    : AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // 'Interested' Tab Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _activeTab = 'Interested';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: _activeTab == 'Interested'
                                  ? AppColors.primaryAccent
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Interested',
                              style: TextStyle(
                                color: _activeTab == 'Interested'
                                    ? AppColors.primaryAccent
                                    : AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Scrollable List of RSVP cards
              Expanded(
                child: filteredEvents.isEmpty
                    ? Center(
                        child: Text(
                          'No events in this category',
                          style: TextStyle(
                            color: AppColors.textSecondary.withValues(alpha: 0.6),
                            fontSize: 15,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredEvents.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = filteredEvents[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                // Left Image container with overlay badge
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Stack(
                                    children: [
                                      // Image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(
                                          item['image'],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            // Fallback if image asset loading fails
                                            return Container(
                                              width: 100,
                                              height: 100,
                                              color: AppColors.searchBackground,
                                              child: const Icon(
                                                Icons.image_not_supported_outlined,
                                                color: AppColors.textSecondary,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      // Bottom gradient status badge
                                      Positioned(
                                        bottom: 6,
                                        left: 6,
                                        right: 6,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: item['isGoing']
                                                  ? [
                                                      const Color(0xFF00B894),
                                                      const Color(0xFF009470)
                                                    ]
                                                  : [
                                                      const Color(0xFFFFB703),
                                                      const Color(0xFFE2A300)
                                                    ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              item['isGoing']
                                                  ? 'Going'
                                                  : 'Interested',
                                              style: TextStyle(
                                                color: item['isGoing']
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Right Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item['title'],
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "${item['date']} • ${item['location']}",
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
