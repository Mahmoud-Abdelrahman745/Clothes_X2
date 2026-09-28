import 'package:flutter/material.dart';

import '../../core/icons/sw_icon.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import '../../data/mock_data.dart';
import 'perfect_match_screen.dart';

/// Frame 17 - what has already been worn, with thumbs up / down feedback.
class OutfitHistoryScreen extends StatelessWidget {
  const OutfitHistoryScreen({super.key, this.embedded = false});

  /// True when hosted inside the Outfits tab, which already draws the header.
  final bool embedded;

  static const _entries = <(String, String, String, String)>[
    (
      'TODAY',
      'University Casual',
      'Daily Lectures',
      MockData.outfitUniversity2,
    ),
    ('YESTERDAY', 'Weekend Brunch', 'Social Gathering', MockData.outfitBrunch),
    ('SEP 22', 'Smart Meeting', 'Presentation', MockData.outfitMeeting),
  ];

  @override
  Widget build(BuildContext context) {
    final body = ListView(
      padding: EdgeInsets.fromLTRB(
        Insets.gutter,
        embedded ? Insets.lg : Insets.md,
        Insets.gutter,
        Insets.xxl,
      ),
      physics: const BouncingScrollPhysics(),
      children: [
        for (final (day, title, occasion, image) in _entries) ...[
          _HistoryRow(
            when: day,
            title: title,
            occasion: occasion,
            image: image,
            onOpen: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const PerfectMatchScreen()),
            ),
          ),
          const SizedBox(height: Insets.md),
        ],
        const SwBanner(
          icon: SwIcon.circleInfo,
          message:
              'Your feedback helps AI learn your personal style and wardrobe '
              'preferences over time.',
        ),
      ],
    );

    if (embedded) return body;

    return SwScreen(
      child: Column(
        children: [
          const SwAppBar(
            title: 'Outfit History',
            subtitle: 'Your recently styled and worn looks',
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({
    required this.when,
    required this.title,
    required this.occasion,
    required this.image,
    required this.onOpen,
  });

  final String when;
  final String title;
  final String occasion;
  final String image;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return SwCard(
      onTap: onOpen,
      padding: const EdgeInsets.all(Insets.md),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            height: 52,
            child: SwProductImage(image: image, radius: Radii.sm),
          ),
          const SizedBox(width: Insets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  when,
                  style: AppText.overline.copyWith(
                    fontSize: 9,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.cardTitle.copyWith(fontSize: 14),
                ),
                Text(
                  occasion,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.caption,
                ),
              ],
            ),
          ),
          _FeedbackButton(
            icon: SwIcon.thumbUp,
            onTap: () => _toast(context, 'Thanks for the feedback!'),
          ),
          const SizedBox(width: Insets.sm),
          _FeedbackButton(
            icon: SwIcon.thumbDown,
            onTap: () => _toast(context, 'Noted - we will tune future picks.'),
          ),
        ],
      ),
    );
  }
}

class _FeedbackButton extends StatelessWidget {
  const _FeedbackButton({required this.icon, required this.onTap});

  final SwIcon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
        ),
        child: SwIconView(
          icon,
          size: 14,
          color: AppColors.textSecondary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

void _toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
