import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Service for AI-powered task breakdown suggestions using OpenAI.
///
/// Provides two main features:
/// 1. Generate first step suggestions from a goal
/// 2. Break down an action into a smaller step
///
/// Requires user consent before making API calls, managed via SharedPreferences.
class AIService {
  static const _apiKey = String.fromEnvironment('OPENAI_API_KEY');
  static const _baseUrl = 'https://api.openai.com/v1/chat/completions';

  /// Check if user has consented to AI suggestions.
  static Future<bool> hasConsent() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('aiSuggestionsEnabled') ?? false;
  }

  /// Request consent from user (first-time only).
  ///
  /// Shows a dialog explaining what data will be sent to OpenAI.
  /// Returns true if user consents, false otherwise.
  static Future<bool> requestConsent(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final hasAsked = prefs.getBool('hasAskedAIConsent') ?? false;

    if (hasAsked) {
      return await hasConsent();
    }

    // Show consent dialog
    if (!context.mounted) return false;

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Enable AI Suggestions?'),
        content: const Text(
          'AI suggestions will send your text to OpenAI to generate ideas. '
          'Your data is not stored or used for training.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Don't allow"),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    await prefs.setBool('hasAskedAIConsent', true);
    if (result == true) {
      await prefs.setBool('aiSuggestionsEnabled', true);
    } else {
      await prefs.setBool('aiSuggestionsEnabled', false);
    }

    return result ?? false;
  }

  /// Generate 2-3 tiny first step suggestions from a goal.
  ///
  /// Example: "Write my 15-page research paper" might return:
  /// - "Open the document"
  /// - "Set a 2-minute timer"
  /// - "Write one sentence"
  ///
  /// Throws an exception if the API call fails.
  static Future<List<String>> generateFirstSteps(String goal) async {
    if (_apiKey.isEmpty) {
      throw Exception(
        'No API key found. Run the app with --dart-define-from-file=.env.json',
      );
    }

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': [
          {
            'role': 'system',
            'content':
                'You help people break down overwhelming tasks into tiny first steps. Always respond with a raw JSON array of strings — no markdown, no code fences.',
          },
          {
            'role': 'user',
            'content': '''A user wants to work on: "$goal"

Generate 3 tiny first steps they could take to start this task. Each step should:
- Take 2 minutes or less
- Be concrete and specific
- Start with a verb
- Feel doable even when overwhelmed

Respond with ONLY a JSON array of strings. Example: ["Open the document", "Set a 2-minute timer", "Write one sentence"]''',
          },
        ],
        'max_tokens': 100,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('AI service error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    final raw = (data['choices'][0]['message']['content'] as String).trim();

    // Strip markdown code fences that the model sometimes adds
    final cleaned = raw
        .replaceAll(RegExp(r'^```[a-z]*\s*', multiLine: true), '')
        .replaceAll(RegExp(r'\s*```$', multiLine: true), '')
        .trim();

    final suggestions = (jsonDecode(cleaned) as List).cast<String>();
    return suggestions.take(3).toList();
  }

  /// Extract up to 3 actionable task titles from a voice transcription.
  ///
  /// Returns an empty list on API errors, timeouts (>8 s), empty/no-key input,
  /// or when the transcription contains no clear tasks. Callers should fall
  /// through to the manual `CreateCardGoalScreen` path on an empty result.
  static Future<List<String>> suggestTasksFromTranscription(
    String transcription,
  ) async {
    if (_apiKey.isEmpty || transcription.trim().isEmpty) return [];

    try {
      final response = await http
          .post(
            Uri.parse(_baseUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_apiKey',
            },
            body: jsonEncode({
              'model': 'gpt-4o-mini',
              'messages': [
                {
                  'role': 'system',
                  'content':
                      'You extract short, actionable task titles from voice notes. '
                      'Always respond with a raw JSON array of strings — no markdown, no code fences.',
                },
                {
                  'role': 'user',
                  'content':
                      'Extract up to 3 distinct tasks from this voice note. '
                      'Return ONLY a JSON array of short, actionable task titles '
                      '(under 10 words each). If fewer than 3 tasks are present, '
                      'return only what is there. Do not invent tasks. If no clear '
                      'tasks are found, return an empty array.\n\n'
                      'Voice note: "$transcription"',
                },
              ],
              'max_tokens': 120,
              'temperature': 0.3,
            }),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode != 200) return [];

      final data = jsonDecode(response.body);
      final raw = (data['choices'][0]['message']['content'] as String).trim();

      final cleaned = raw
          .replaceAll(RegExp(r'^```[a-z]*\s*', multiLine: true), '')
          .replaceAll(RegExp(r'\s*```$', multiLine: true), '')
          .trim();

      final parsed = jsonDecode(cleaned);
      if (parsed is! List) return [];

      return parsed
          .cast<String>()
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .take(3)
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Break down an action into a smaller, more concrete step.
  ///
  /// Example: "Clean my kitchen" might return "Put one dish in the dishwasher"
  ///
  /// Throws an exception if the API call fails.
  static Future<String> makeSmaller(String action) async {
    if (_apiKey.isEmpty) {
      throw Exception(
        'No API key found. Run the app with --dart-define-from-file=.env.json',
      );
    }

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': [
          {
            'role': 'system',
            'content':
                'You help people break down tasks into smaller, more manageable steps.',
          },
          {
            'role': 'user',
            'content': '''A user wrote this first step: "$action"

This feels too big for them. Suggest ONE smaller, more concrete first step that takes 2 minutes or less and requires minimal decision-making.

Format as a single string, not a list. Start with a verb. Be specific.''',
          },
        ],
        'max_tokens': 50,
        'temperature': 0.5,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('AI service error: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'].trim();
  }
}
