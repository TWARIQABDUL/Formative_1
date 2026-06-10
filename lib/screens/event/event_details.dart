import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class EventDetailsScreen extends StatefulWidget {
  final String title;
  final String description;
  final String date;
  final String location;
  final String? image;
  final IconData? icon;
  final Color? iconBg;
  final bool initialJoined;
  final bool initialInterested;

  const EventDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    this.image,
    this.icon,
    this.iconBg,
    this.initialJoined = false,
    this.initialInterested = false,
  });

  @override
  State<EventDetailsScreen> createState() =>
      _EventDetailsScreenState();
}

class _EventDetailsScreenState
    extends State<EventDetailsScreen> {
  late bool joined;
  late bool interested;

  @override
  void initState() {
    super.initState();
    joined = widget.initialJoined;
    interested = widget.initialInterested;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: widget.image != null
                      ? Colors.transparent
                      : (widget.iconBg ?? Colors.blueGrey),
                ),
                child: Stack(
                  children: [
                    if (widget.image != null)
                      Positioned.fill(
                        child: Image.asset(
                          widget.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: widget.iconBg ?? Colors.blueGrey,
                              child: Center(
                                child: Icon(
                                  widget.icon ?? Icons.groups,
                                  size: 100,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    if (widget.image == null)
                      Center(
                        child: Icon(
                          widget.icon ?? Icons.groups,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Event Metadata: Date & Location
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.primaryAccent,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.date,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.primaryAccent,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.location,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(
                      color: AppColors.searchBackground,
                      thickness: 1,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            joined = !joined;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: joined
                              ? AppColors.iconGreen
                              : AppColors.primaryAccent,
                          foregroundColor: joined ? Colors.white : Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          joined ? "RSVP Confirmed ✓" : "RSVP",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            interested = !interested;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: interested
                              ? AppColors.primaryAccent
                              : AppColors.textSecondary,
                          side: BorderSide(
                            color: interested
                                ? AppColors.primaryAccent
                                : AppColors.textSecondary.withValues(alpha: 0.5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          interested ? "Interested ✓" : "Interested",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}