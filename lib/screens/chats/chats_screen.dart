import 'package:flutter/material.dart';
import 'package:formative_1/theme/app_colors.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {
        "name": "Entrepreneurship Club",
        "message": "Meeting starts at 6 PM",
        "time": "10:30 AM"
      },
      {
        "name": "Tech Community",
        "message": "Hackathon registration is open",
        "time": "09:15 AM"
      },
      {
        "name": "Women in Leadership",
        "message": "New event posted",
        "time": "Yesterday"
      },
      {
        "name": "Startup Founders",
        "message": "Pitch practice tomorrow",
        "time": "Yesterday"
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,

        title: const Text(
          "Chats",
          style: TextStyle(
            color: AppColors.textPrimary,
          ),
        ),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search chats...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(vertical: 10),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.group),
            ),

            title: Text(
              chats[index]["name"]!,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),

            subtitle: Text(
              chats[index]["message"]!,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            trailing: Text(
              chats[index]["time"]!,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}