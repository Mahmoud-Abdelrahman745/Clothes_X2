import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/icons/sw_icon.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';

/// Frame 20 - the analytics view of the user's style over time.
class StyleDnaScreen extends StatelessWidget {
  const StyleDnaScreen({super.key});

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
                      Text('Your Style DNA', style: AppText.h1),
                      const SizedBox(height: 2),
                      Text(
                        'AI analytics of your personal style',
                        style: AppText.caption,
                      ),
                    ],
                  ),
                ),
                const SwIconButton(icon: SwIconButtonKind.plus),
              ],
            ),
          ),
          const SizedBox(height: Insets.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _DonutChart(),
                const SizedBox(height: Insets.xl),
                const _Legend(),
                const SizedBox(height: Insets.sectionGap),
                Text('Favorite Colors', style: AppText.h4),
                const SizedBox(height: Insets.md),
                const _ColorRow(),
                const SizedBox(height: Insets.sectionGap),
                Text('Favorite Categories', style: AppText.h4),
                const SizedBox(height: Insets.md),
                const _CategoryList(),
                const SizedBox(height: Insets.sectionGap),
                Text('Your Style Evolution', style: AppText.h4),
                const SizedBox(height: Insets.md),
                const _TrendCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Donut showing the dominant style, with the share printed in the centre.
class _DonutChart extends StatelessWidget {
  const _DonutChart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size.square(200),
              painter: _DonutPainter(MockData.styleSegments),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('45%', style: AppText.numeric),
                const SizedBox(height: 2),
                Text('Casual', style: AppText.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter(this.segments);

  final List<StyleSegment> segments;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 34.0;
    final rect = Offset.zero & size;

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = AppColors.border;
    canvas.drawArc(rect.deflate(stroke / 2), 0, 6.28318, false, track);

    const gap = 0.035;
    var start = -math.pi / 2;

    for (final segment in segments) {
      final sweep = (segment.share / 100) * 6.28318;
      canvas.drawArc(
        rect.deflate(stroke / 2),
        start + gap / 2,
        math.max(0, sweep - gap),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke
          ..color = segment.color,
      );
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(_DonutPainter old) => old.segments != segments;
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Insets.xl,
      runSpacing: Insets.md,
      children: [
        for (final segment in MockData.styleSegments)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: segment.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: Insets.sm),
              Text(
                '${segment.label} (${segment.share}%)',
                style: AppText.body.copyWith(fontSize: 13),
              ),
            ],
          ),
      ],
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final color in MockData.favoriteColors)
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(color.value),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                ),
                const SizedBox(height: Insets.sm),
                Text(
                  color.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.caption.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final row in MockData.favoriteCategories) ...[
          SwCard(
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.lg,
              vertical: Insets.md,
            ),
            child: Row(
              children: [
                SwIconView(
                  row.icon == 'shirt' ? SwIcon.shirt : SwIcon.circleX,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: Insets.md),
                Expanded(child: Text(row.name, style: AppText.bodyStrong)),
                SwChip(
                  label: '${row.count} items',
                  dense: true,
                  tone: SwChipTone.tinted,
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.sm),
        ],
      ],
    );
  }
}

/// Six month line chart of the style shift.
class _TrendCard extends StatelessWidget {
  const _TrendCard();

  @override
  Widget build(BuildContext context) {
    return SwCard(
      padding: const EdgeInsets.all(Insets.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Casual wear decreasing to Smart Casual over 6 months',
            style: AppText.caption,
          ),
          const SizedBox(height: Insets.lg),
          SizedBox(
            height: 110,
            width: double.infinity,
            child: CustomPaint(painter: _TrendPainter(MockData.styleEvolution)),
          ),
          const SizedBox(height: Insets.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final month in MockData.evolutionMonths)
                Text(
                  month,
                  style: AppText.overline.copyWith(
                    fontSize: 9,
                    letterSpacing: 0,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  const _TrendPainter(this.values);

  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;

    const top = 12.0;
    final usable = size.height - top;

    final points = <Offset>[
      for (var i = 0; i < values.length; i++)
        Offset(
          size.width * (i / (values.length - 1)),
          top + usable * (1 - values[i].clamp(0.0, 1.0)),
        ),
    ];

    final line = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      line.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(
      line,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = AppColors.primary,
    );
  }

  @override
  bool shouldRepaint(_TrendPainter old) => old.values != values;
}
