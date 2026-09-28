import 'package:flutter/material.dart';

import '../../core/icons/sw_icon.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import '../../data/assets.dart';
import '../../data/mock_data.dart';

/// Frame 23 - trending styles, seasonal spotlight and community looks.
class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

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
                      Text('Discover', style: AppText.h1),
                      const SizedBox(height: 2),
                      Text(
                        'Browse global trends & daily inspiration',
                        style: AppText.caption,
                      ),
                    ],
                  ),
                ),
                const SwIconButton(icon: SwIconButtonKind.search),
              ],
            ),
          ),
          const SizedBox(height: Insets.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Trending Styles', style: AppText.h4),
                const SizedBox(height: Insets.md),
              ],
            ),
          ),
          const _TrendingRail(),
          const SizedBox(height: Insets.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Seasonal Spotlight', style: AppText.h4),
                const SizedBox(height: Insets.md),
                const _SpotlightBanner(),
                const SizedBox(height: Insets.sectionGap),
                Text('Community Looks', style: AppText.h4),
                const SizedBox(height: Insets.md),
              ],
            ),
          ),
          const _CommunityGrid(),
        ],
      ),
    );
  }
}

/// Horizontal rail of the two trending styles.
class _TrendingRail extends StatelessWidget {
  const _TrendingRail();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
        physics: const BouncingScrollPhysics(),
        itemCount: MockData.trendingStyles.length,
        separatorBuilder: (_, _) => const SizedBox(width: Insets.md),
        itemBuilder: (context, i) {
          final trend = MockData.trendingStyles[i];
          return GestureDetector(
            onTap: () => _toast(context, trend.name),
            child: SizedBox(
              width: 210,
              child: ClipRRect(
                borderRadius: Radii.cardRadius,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(trend.image, fit: BoxFit.cover),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Color(0xB3000000)],
                          stops: [0.45, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      left: Insets.md,
                      right: Insets.md,
                      bottom: Insets.md,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trend.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.h4.copyWith(color: Colors.white),
                          ),
                          Text(
                            trend.tag,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.caption.copyWith(
                              color: Colors.white70,
                              fontSize: 11,
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
        },
      ),
    );
  }
}

/// Full width seasonal feature card.
class _SpotlightBanner extends StatelessWidget {
  const _SpotlightBanner();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toast(context, 'Fall 2024 Essentials'),
      child: ClipRRect(
        borderRadius: Radii.cardRadius,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(Img.seasonalBanner, fit: BoxFit.cover),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x66000000), Color(0xCC000000)],
                  ),
                ),
              ),
              Positioned(
                left: Insets.lg,
                top: Insets.lg,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.md,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: Radii.pillRadius,
                  ),
                  child: Text(
                    'FEATURED COLLECTION',
                    style: AppText.overline.copyWith(
                      color: Colors.white,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: Insets.lg,
                right: Insets.lg,
                bottom: Insets.lg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fall 2024 Essentials',
                      style: AppText.h2.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Layering is an art. Explore structured wool coats, heavy '
                      'knits, and premium earth tones tailored for your closet.',
                      style: AppText.body.copyWith(
                        color: Colors.white70,
                        fontSize: 12,
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

/// Two column grid of community outfits with like counts.
class _CommunityGrid extends StatelessWidget {
  const _CommunityGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Insets.md,
        crossAxisSpacing: Insets.md,
        childAspectRatio: 0.82,
      ),
      itemCount: MockData.communityLooks.length,
      itemBuilder: (context, i) {
        final look = MockData.communityLooks[i];
        return GestureDetector(
          onTap: () => _toast(context, look.name),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: SwProductImage(image: look.image, radius: Radii.md),
                ),
              ),
              const SizedBox(height: Insets.sm),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      look.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.labelStrong.copyWith(fontSize: 11),
                    ),
                  ),
                  const SwIconView(
                    SwIcon.heart,
                    size: 11,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    _compact(look.likes),
                    style: AppText.caption.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static String _compact(int value) =>
      value >= 1000 ? '${(value / 1000).toStringAsFixed(1)}k' : '$value';
}

void _toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
