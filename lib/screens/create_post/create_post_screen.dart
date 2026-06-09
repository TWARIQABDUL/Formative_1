import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import 'widgets/custom_text_field.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // State variables to capture form data
  String _postType = 'Event'; // 'Event' or 'Opportunity'
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedLocation;
  String? _selectedCategory;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _onPublish() {
    // Collect data to simulate form submission
    final postData = {
      'type': _postType,
      'title': _titleController.text,
      'description': _descriptionController.text,
      'date': _dateController.text,
      'location': _selectedLocation,
      'category': _selectedCategory,
    };
    print('Publishing Post Data: $postData');
    // Optionally pop the screen or show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post Published!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Create Post',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event vs Opportunity Toggle
              Container(
                decoration: BoxDecoration(
                  color: AppColors.searchBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _postType = 'Event'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _postType == 'Event'
                                ? AppColors.primaryAccent
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Event',
                            style: TextStyle(
                              color: _postType == 'Event'
                                  ? Colors.black
                                  : AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _postType = 'Opportunity'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: _postType == 'Opportunity'
                                ? AppColors.primaryAccent
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Opportunity',
                            style: TextStyle(
                              color: _postType == 'Opportunity'
                                  ? Colors.black
                                  : AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Image Upload Area (Solid Border)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  color: AppColors.searchBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.textSecondary.withValues(alpha: 0.3),
                    width: 1, // Solid border as agreed
                  ),
                ),
                child: Column(
                  children: const [
                    Icon(
                      Icons.image_outlined,
                      color: AppColors.primaryAccent,
                      size: 40,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Add cover image',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form Fields
              CustomTextField(
                label: 'Title',
                hintText: 'e.g. Leadership Workshop',
                controller: _titleController,
              ),
              CustomTextField(
                label: 'Description',
                hintText: 'Tell people more about this event...',
                maxLines: 4,
                controller: _descriptionController,
              ),
              CustomTextField(
                label: 'Date & Time',
                hintText: '',
                readOnly: true,
                controller: _dateController,
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    // Logic to show date picker could go here
                  },
                ),
              ),
              
              // Location Dropdown
              const Text(
                'Location',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.searchBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLocation,
                    hint: const Text(
                      'Kigali Campus',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                    ),
                    dropdownColor: AppColors.cardBackground,
                    style: const TextStyle(color: AppColors.textPrimary),
                    items: ['Kigali Campus', 'Mauritius Campus', 'Online']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Category Dropdown
              const Text(
                'Category',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.searchBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    hint: const Text(
                      'Select category',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                    ),
                    dropdownColor: AppColors.cardBackground,
                    style: const TextStyle(color: AppColors.textPrimary),
                    items: ['Event', 'Opportunity', 'Club', 'Academics']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Publish Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onPublish,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Publish',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

