import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import '../../data/assets.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';

/// Frame 14 - try a combination on the fitting room mannequin.
class StyleAvatarScreen extends StatefulWidget {
  const StyleAvatarScreen({super.key});

  @override
  State<StyleAvatarScreen> createState() => _StyleAvatarScreenState();
}

class _StyleAvatarScreenState extends State<StyleAvatarScreen> {
  int _topIndex = 0;
  int _bottomIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SwScreen(
      scroll: true,
      padding: const EdgeInsets.only(bottom: Insets.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SwAppBar(title: 'Style Avatar'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FittingRoom(top: MockData.avatarTops[_topIndex]),
                const SizedBox(height: Insets.xl),
                Text(
                  'CHOOSE TOP',
                  style: AppText.overline.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: Insets.md),
                _SwatchRow(
                  items: MockData.avatarTops,
                  selected: _topIndex,
                  onSelect: (i) => setState(() => _topIndex = i),
                ),
                const SizedBox(height: Insets.xl),
                Text(
                  'CHOOSE BOTTOM',
                  style: AppText.overline.copyWith(
                    color: AppColors.primary,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: Insets.md),
                _SwatchRow(
                  items: MockData.avatarBottoms,
                  selected: _bottomIndex,
                  onSelect: (i) => setState(() => _bottomIndex = i),
                ),
                const SizedBox(height: Insets.xxxl),
                SwButton(
                  label: 'Save Look',
                  onTap: () => ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('Look saved to outfits.')),
                    ),
                ),
                const SizedBox(height: Insets.md),
                SwOutlineButton(
                  label: 'Get AI Suggestions',
                  onTap: () => ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('Three new combinations generated.'),
                      ),
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

/// Mannequin panel with the current top overlaid and a "Fitting Room" chip.
class _FittingRoom extends StatelessWidget {
  const _FittingRoom({required this.top});

  final ClothingItem top;

  @override
  Widget build(BuildContext context) {
    return SwCard(
      padding: EdgeInsets.zero,
      clip: true,
      child: AspectRatio(
        aspectRatio: 1.05,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(
              color: AppColors.background,
              child: Padding(
                padding: const EdgeInsets.all(Insets.xl),
                child: Image.asset(
                  Img.avatarFittingRoom,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(Insets.md),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.md,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: Radii.pillRadius,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text('Fitting Room', style: AppText.label),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal row of selectable garment thumbnails.
class _SwatchRow extends StatelessWidget {
  const _SwatchRow({
    required this.items,
    required this.selected,
    required this.onSelect,
  });

  final List<ClothingItem> items;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: Insets.md),
          Expanded(
            child: GestureDetector(
              onTap: () => onSelect(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 86,
                decoration: BoxDecoration(
                  borderRadius: Radii.tileRadius,
                  border: Border.all(
                    color: i == selected ? AppColors.primary : AppColors.border,
                    width: i == selected ? 2 : 1,
                  ),
                ),
                padding: const EdgeInsets.all(3),
                child: SwProductImage(image: items[i].image, radius: Radii.sm),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
