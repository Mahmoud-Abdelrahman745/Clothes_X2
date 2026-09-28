import 'package:flutter/material.dart';

import '../../core/icons/sw_icon.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';

/// Frame 11 - full detail view for a single garment.
class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.item});

  final ClothingItem item;

  @override
  Widget build(BuildContext context) {
    final rows = <(SwIcon, String, String)>[
      (SwIcon.circleX, 'Category', item.category),
      (SwIcon.palette, 'Color', item.color),
      (SwIcon.sparkle, 'Style', item.style),
      (SwIcon.box, 'Material', item.material),
      (SwIcon.sun, 'Season', item.season),
      (SwIcon.tag, 'Formality', item.formality),
    ];

    return SwScreen(
      scroll: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Hero(image: item.image, onBack: () => Navigator.of(context).pop()),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Insets.gutter,
              Insets.xl,
              Insets.gutter,
              Insets.xxl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppText.h1.copyWith(fontSize: 24)),
                const SizedBox(height: Insets.md),
                Wrap(
                  spacing: Insets.sm,
                  runSpacing: Insets.sm,
                  children: [
                    for (final tag in [
                      item.category,
                      item.color,
                      item.style,
                      item.material.split(' ').first,
                    ])
                      SwChip(label: tag, dense: true),
                  ],
                ),
                const SizedBox(height: Insets.lg),
                for (final (icon, label, value) in rows) ...[
                  _AttributeRow(icon: icon, label: label, value: value),
                  const SizedBox(height: Insets.sm),
                ],
                const SizedBox(height: Insets.lg),
                _UsageStats(item: item),
                const SizedBox(height: Insets.lg),
                Row(
                  children: [
                    Expanded(
                      child: SwOutlineButton(
                        label: 'Edit',
                        onTap: () => _toast(context, 'Editing ${item.name}'),
                      ),
                    ),
                    const SizedBox(width: Insets.md),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => _toast(context, 'Outfit saved.'),
                        icon: const SwIconView(
                          SwIcon.check,
                          size: 15,
                          color: Colors.white,
                        ),
                        label: const Text('Wear'),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(
                            Sizes.buttonHeight,
                          ),
                          textStyle: AppText.button,
                          shape: const RoundedRectangleBorder(
                            borderRadius: Radii.pillRadius,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Edge to edge product photo with floating back and overflow actions.
class _Hero extends StatelessWidget {
  const _Hero({required this.image, required this.onBack});

  final String image;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(image, fit: BoxFit.cover),
          Positioned(
            top: Insets.md,
            left: Insets.lg,
            child: SwIconButton(
              icon: SwIconButtonKind.back,
              onTap: onBack,
              background: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          Positioned(
            top: Insets.md,
            right: Insets.lg,
            child: SwIconButton(
              icon: SwIconButtonKind.more,
              onTap: () => _toast(context, 'More options'),
              background: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttributeRow extends StatelessWidget {
  const _AttributeRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final SwIcon icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.lg,
        vertical: Insets.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: Radii.cardRadius,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          SwIconView(icon, size: 17, color: AppColors.textSecondary),
          const SizedBox(width: Insets.md),
          Expanded(child: Text(label, style: AppText.body)),
          Text(value, style: AppText.bodyStrong),
        ],
      ),
    );
  }
}

/// Two usage statistics shown at the bottom of the detail screen.
class _UsageStats extends StatelessWidget {
  const _UsageStats({required this.item});

  final ClothingItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SwCard(
            padding: const EdgeInsets.all(Insets.md),
            child: Row(
              children: [
                const SwIconView(
                  SwIcon.layers,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: Insets.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Used in ${item.timesWorn ~/ 4} outfits',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.labelStrong.copyWith(fontSize: 11),
                      ),
                      Text('Versatile piece', style: AppText.caption),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: Insets.md),
        Expanded(
          child: SwCard(
            padding: const EdgeInsets.all(Insets.md),
            child: Row(
              children: [
                const SwIconView(
                  SwIcon.calendar,
                  size: 18,
                  color: AppColors.primary,
                ),
                const SizedBox(width: Insets.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.lastWornLabel ?? 'Recently worn',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.labelStrong.copyWith(fontSize: 11),
                      ),
                      Text('Regular rotation', style: AppText.caption),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void _toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// Convenience constructor used by lists that always show the sample shirt.
ItemDetailScreen sample() => ItemDetailScreen(item: MockData.wardrobe.first);
