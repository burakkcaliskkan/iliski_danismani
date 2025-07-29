import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../localization/localization_helper.dart';

/// AI Advisor chat screen
/// Provides a chat interface for relationship advice
/// Features complete multi-language support
class AiDanismanScreen extends StatefulWidget {
  const AiDanismanScreen({super.key});

  @override
  State<AiDanismanScreen> createState() => _AiDanismanScreenState();
}

class _AiDanismanScreenState extends State<AiDanismanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationHelper.translate('ai_advisor_title')),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Messages display area
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // AI Advisor's message (left side) - AUTO LOCALIZED 🌍
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16, right: 50),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      LocalizationHelper.translate('ai_greeting'),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                // User's message (right side) - AUTO LOCALIZED 🌍
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16, left: 50),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPink,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      LocalizationHelper.translate('ai_user_message'),
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                // AI Advisor's second message - AUTO LOCALIZED 🌍
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16, right: 50),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      LocalizationHelper.translate('ai_response'),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Quick Questions Section - AUTO LOCALIZED 🌍
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocalizationHelper.translate('quick_questions'),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildQuickQuestion(
                      LocalizationHelper.translate('gift_suggestion'),
                    ),
                    _buildQuickQuestion(
                      LocalizationHelper.translate('place_to_go'),
                    ),
                    _buildQuickQuestion(
                      LocalizationHelper.translate('what_to_say'),
                    ),
                    _buildQuickQuestion(
                      LocalizationHelper.translate('strengthen_relationship'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Bottom section: Message input area - AUTO LOCALIZED 🌍
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: LocalizationHelper.translate('message_hint'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Send button
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // Empty for now - message sending will be added later
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build a quick question button - AUTO LOCALIZED 🌍
  /// Creates a tappable question chip with custom styling
  Widget _buildQuickQuestion(String question) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${LocalizationHelper.translate('selected')}: $question',
            ),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.purple[200]!),
        ),
        child: Text(
          question,
          style: const TextStyle(fontSize: 14, color: Colors.purple),
        ),
      ),
    );
  }
}
