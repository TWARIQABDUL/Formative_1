import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Chats Screen',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 24),
        ),
      ),
    );
  }
}
