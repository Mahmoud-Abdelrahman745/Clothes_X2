import 'package:flutter/material.dart';

import '../../core/icons/sw_icon.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import '../../data/assets.dart';
import '../../data/mock_data.dart';
import '../stylist/stylist_screen.dart';

/// Frame 21 - data driven overview of the closet.
class WardrobeInsightsScreen extends StatelessWidget {
  const WardrobeInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SwScreen(
      scroll: true,
      padding: const EdgeInsets.only(bottom: Insets.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Insets.gutter,
              Insets.sm,
              Insets.gutter,
              0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Wardrobe Insights', style: AppText.h1),
                      const SizedBox(height: 2),
                      Text(
                        'Data driven analysis of your closet',
                        style: AppText.caption,
                      ),
                    ],
                  ),
                ),
                const SwIconButton(icon: SwIconButtonKind.bag),
              ],
            ),
          ),
          const SizedBox(height: Insets.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _StatStrip(),
                const SizedBox(height: Insets.sectionGap),
                Text('Most Worn Items', style: AppText.h4),
                const SizedBox(height: Insets.md),
                const _MostWornRow(),
                const SizedBox(height: Insets.lg),
                const SwBanner(
                  tone: SwBannerTone.warning,
                  icon: SwIcon.alert,
                  message:
                      'You own 4 casual jackets but very few formal pieces. '
                      'Try adding structured items for formal occasions.',
                ),
                const SizedBox(height: Insets.sectionGap),
                Text('Never Worn', style: AppText.h4),
                const SizedBox(height: Insets.md),
                _NeverWornCard(
                  onAsk: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const StylistScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Five count tiles across the top of the insights screen.
class _StatStrip extends StatelessWidget {
  const _StatStrip();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < MockData.wardrobeStats.length; i++) ...[
          if (i > 0) const SizedBox(width: Insets.sm),
          Expanded(
            child: SwCard(
              padding: const EdgeInsets.symmetric(vertical: Insets.md),
              child: Column(
                children: [
                  Text(
                    MockData.wardrobeStats[i].value,
                    style: AppText.statValue,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    MockData.wardrobeStats[i].label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.statLabel,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _MostWornRow extends StatelessWidget {
  const _MostWornRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < MockData.mostWorn.length; i++) ...[
          if (i > 0) const SizedBox(width: Insets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: SwProductImage(
                    image: MockData.mostWorn[i].image,
                    radius: Radii.md,
                  ),
                ),
                const SizedBox(height: Insets.sm),
                Text(
                  MockData.mostWorn[i].name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.labelStrong.copyWith(fontSize: 11),
                ),
                Text(
                  '${MockData.mostWorn[i].timesWorn} wears',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.caption.copyWith(
                    fontSize: 10,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _NeverWornCard extends StatelessWidget {
  const _NeverWornCard({required this.onAsk});

  final VoidCallback onAsk;

  @override
  Widget build(BuildContext context) {
    return SwCard(
      padding: const EdgeInsets.all(Insets.md),
      child: Row(
        children: [
          const SizedBox(
            width: 44,
            height: 44,
            child: SwProductImage(image: Img.scarfSilk, radius: Radii.sm),
          ),
          const SizedBox(width: Insets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Silk Scarf', style: AppText.cardTitle),
                Text(
                  'Unworn for 60+ days',
                  style: AppText.caption.copyWith(color: AppColors.danger),
                ),
              ],
            ),
          ),
          SwChip(
            label: 'Ask Stylist',
            dense: true,
            tone: SwChipTone.tinted,
            onTap: onAsk,
          ),
        ],
      ),
    );
  }
}
