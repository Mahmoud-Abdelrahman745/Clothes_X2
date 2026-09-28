import 'package:flutter/material.dart';

import '../../core/icons/sw_icon.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';
import '../stylist/style_avatar_screen.dart';

/// Frame 13 - detailed breakdown of the recommended combination.
class PerfectMatchScreen extends StatelessWidget {
  const PerfectMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SwScreen(
      scroll: true,
      padding: const EdgeInsets.only(bottom: Insets.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SwAppBar(title: 'Perfect Match'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwCard(
                  padding: const EdgeInsets.all(Insets.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TODAY'S FLATLAY SUGGESTION",
                        style: AppText.overline,
                      ),
                      const SizedBox(height: Insets.md),
                      const _PieceGrid(),
                    ],
                  ),
                ),
                const SizedBox(height: Insets.lg),
                const _ScoreCard(),
                const SizedBox(height: Insets.xl),
                Text('AI Breakdown Analysis', style: AppText.h4),
                const SizedBox(height: Insets.md),
                SwCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Insets.lg,
                    vertical: Insets.lg,
                  ),
                  child: Column(
                    children: [
                      for (final row in MockData.matchBreakdown) ...[
                        _ScoreBar(label: row.label, value: row.value),
                        if (row != MockData.matchBreakdown.last)
                          const SizedBox(height: Insets.lg),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: Insets.lg),
                SwBanner(
                  icon: SwIcon.sparkle,
                  title: 'WHY THIS OUTFIT?',
                  message:
                      'These pieces work well together because the neutral '
                      'colors create a balanced look and the casual style '
                      "matches your university occasion.",
                ),
                const SizedBox(height: Insets.xl),
                SwButton(
                  label: 'Save Outfit',
                  onTap: () => ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('Outfit saved.')),
                    ),
                ),
                const SizedBox(height: Insets.md),
                SwOutlineButton(
                  label: 'Preview on Avatar',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const StyleAvatarScreen(),
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

/// Two by two grid of the garments in the recommendation.
class _PieceGrid extends StatelessWidget {
  const _PieceGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: MockData.perfectMatchPieces.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Insets.md,
        crossAxisSpacing: Insets.md,
        childAspectRatio: 1.05,
      ),
      itemBuilder: (context, i) {
        final ClothingItem item = MockData.perfectMatchPieces[i];
        return SwProductImage(image: item.image, radius: Radii.md);
      },
    );
  }
}

/// Ring gauge plus the confidence copy.
class _ScoreCard extends StatelessWidget {
  const _ScoreCard();

  @override
  Widget build(BuildContext context) {
    return SwCard(
      padding: const EdgeInsets.all(Insets.lg),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 72,
            child: CustomPaint(
              painter: _RingPainter(0.92),
              child: Center(
                child: Text(
                  '92%',
                  style: AppText.numeric.copyWith(fontSize: 18),
                ),
              ),
            ),
          ),
          const SizedBox(width: Insets.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Compatibility Score', style: AppText.cardTitle),
                const SizedBox(height: 4),
                Text(
                  "This combo is tailored optimally for tomorrow's weather "
                  '& university event.',
                  style: AppText.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Circular progress ring used for the compatibility score.
class _RingPainter extends CustomPainter {
  const _RingPainter(this.value);

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 6.0;
    final rect = Offset.zero & size;

    canvas.drawArc(
      rect.deflate(stroke / 2),
      0,
      6.28318,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = AppColors.border,
    );
    canvas.drawArc(
      rect.deflate(stroke / 2),
      -1.5708,
      6.28318 * value,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..color = AppColors.primary,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.value != value;
}

class _ScoreBar extends StatelessWidget {
  const _ScoreBar({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: AppText.body)),
            Text('$value%', style: AppText.bodyStrong.copyWith(fontSize: 13)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: Radii.pillRadius,
          child: LinearProgressIndicator(
            value: value / 100,
            minHeight: 5,
            backgroundColor: AppColors.border,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
      ],
    );
  }
}
