import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isFreshStartMode = false;
  bool _aiSuggestionsEnabled = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _isFreshStartMode = prefs.getBool('isFreshStartMode') ?? false;
        _aiSuggestionsEnabled = prefs.getBool('aiSuggestionsEnabled') ?? false;
        _loading = false;
      });
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  Future<void> _toggleFreshStartMode(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFreshStartMode', value);
      setState(() => _isFreshStartMode = value);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save setting.')),
        );
      }
    }
  }

  Future<void> _toggleAISuggestions(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('aiSuggestionsEnabled', value);
      setState(() => _aiSuggestionsEnabled = value);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not save setting.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.page,
                AppSpacing.md,
                AppSpacing.page,
                AppSpacing.xs,
              ),
              child: Row(
                children: [
                  Semantics(
                    label: 'Back',
                    button: true,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textMuted,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  const Text('Settings', style: AppTextStyles.screenTitle),
                ],
              ),
            ),
            if (_loading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.textMuted,
                  ),
                ),
              )
            else
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.page,
                    vertical: AppSpacing.sm,
                  ),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Fresh Start mode',
                                  style: AppTextStyles.cardAction,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Start each day with a blank deck. Yesterday\'s cards move to Past Days.',
                                  style: AppTextStyles.bodyMuted.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Semantics(
                            label: 'Fresh Start mode toggle',
                            child: Switch(
                              value: _isFreshStartMode,
                              onChanged: _toggleFreshStartMode,
                              activeColor: AppColors.textPrimary,
                              activeTrackColor:
                                  AppColors.textPrimary.withAlpha(102),
                              inactiveThumbColor: AppColors.textMuted,
                              inactiveTrackColor:
                                  AppColors.surfaceHigh,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Divider(color: AppColors.border),
                    const SizedBox(height: AppSpacing.md),
                    const Text('AI Assistance', style: AppTextStyles.label),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'AI Suggestions',
                                  style: AppTextStyles.cardAction,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Get ideas when you\'re stuck creating tasks. Sends text to OpenAI.',
                                  style: AppTextStyles.bodyMuted.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Semantics(
                            label: 'AI Suggestions toggle',
                            child: Switch(
                              value: _aiSuggestionsEnabled,
                              onChanged: _toggleAISuggestions,
                              activeColor: AppColors.textPrimary,
                              activeTrackColor:
                                  AppColors.textPrimary.withAlpha(102),
                              inactiveThumbColor: AppColors.textMuted,
                              inactiveTrackColor:
                                  AppColors.surfaceHigh,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
