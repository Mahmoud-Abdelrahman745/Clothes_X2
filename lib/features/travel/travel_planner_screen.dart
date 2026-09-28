import 'package:flutter/material.dart';

import '../../core/icons/sw_icon.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';

/// Frame 19 - capsule wardrobe builder for a trip.
class TravelPlannerScreen extends StatefulWidget {
  const TravelPlannerScreen({super.key});

  @override
  State<TravelPlannerScreen> createState() => _TravelPlannerScreenState();
}

class _TravelPlannerScreenState extends State<TravelPlannerScreen> {
  final Set<int> _packed = {for (var i = 0; i < 8; i++) i};

  static const _groups = <(String, List<int>)>[
    ('Tops', [0, 1]),
    ('Bottoms', [2, 3]),
    ('Shoes', [4, 5]),
    ('Accessories', [6, 7]),
  ];

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
                      Text('Travel Planner', style: AppText.h1),
                      const SizedBox(height: 2),
                      Text(
                        'A capsule wardrobe curated for your trip',
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
                const Row(
                  children: [
                    Expanded(
                      child: _TripField(
                        label: 'DESTINATION',
                        value: 'Istanbul, TR',
                      ),
                    ),
                    SizedBox(width: Insets.md),
                    Expanded(
                      child: _TripField(label: 'DATES', value: 'Oct 5 - 12'),
                    ),
                  ],
                ),
                const SizedBox(height: Insets.md),
                const _ForecastStrip(),
                const SizedBox(height: Insets.lg),
                SwButton(
                  label: 'Generate Packing List',
                  onTap: () =>
                      setState(() => _packed.addAll({0, 1, 2, 3, 4, 5, 6, 7})),
                ),
                const SizedBox(height: Insets.md),
                const SwBanner(
                  icon: SwIcon.sparkle,
                  message:
                      '7 distinct outfits can be created from these items.',
                ),
                const SizedBox(height: Insets.lg),
                for (final (group, indices) in _groups) ...[
                  Text('$group (${indices.length})', style: AppText.h4),
                  const SizedBox(height: Insets.md),
                  _PackingRow(
                    entries: [
                      for (final i in indices)
                        PackingEntry(
                          name: MockData.packingGroups[i].name,
                          image: MockData.packingGroups[i].image,
                          packed: _packed.contains(i),
                        ),
                    ],
                  ),
                  const SizedBox(height: Insets.lg),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TripField extends StatelessWidget {
  const _TripField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: Radii.tileRadius,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.overline.copyWith(fontSize: 9)),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.bodyStrong.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

/// Warm forecast banner inside the travel flow.
class _ForecastStrip extends StatelessWidget {
  const _ForecastStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: AppColors.travelTint,
        borderRadius: Radii.tileRadius,
      ),
      child: Row(
        children: [
          const SwIconView(
            SwIcon.sun,
            size: 16,
            color: AppColors.sun,
            strokeWidth: 1.8,
          ),
          const SizedBox(width: Insets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sunny • 24°C - 28°C', style: AppText.bodyStrong),
                Text('Perfect lightweight weather', style: AppText.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Two column list of packed garments with a checkmark toggle.
class _PackingRow extends StatelessWidget {
  const _PackingRow({required this.entries});

  final List<PackingEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < entries.length; i++) ...[
          if (i > 0) const SizedBox(width: Insets.md),
          Expanded(child: _PackingCell(entry: entries[i])),
        ],
      ],
    );
  }
}

class _PackingCell extends StatelessWidget {
  const _PackingCell({required this.entry});

  final PackingEntry entry;

  @override
  Widget build(BuildContext context) {
    return SwCard(
      padding: const EdgeInsets.all(Insets.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 52,
            width: double.infinity,
            child: SwProductImage(image: entry.image, radius: Radii.sm),
          ),
          const SizedBox(height: Insets.sm),
          Text(
            entry.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.labelStrong.copyWith(fontSize: 11),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const SwIconView(
                SwIcon.check,
                size: 11,
                color: AppColors.success,
                strokeWidth: 2.4,
              ),
              const SizedBox(width: 3),
              Text(
                'Packed',
                style: AppText.caption.copyWith(
                  fontSize: 10,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
