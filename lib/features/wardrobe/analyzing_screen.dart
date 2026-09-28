import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/icons/sw_icon.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../data/mock_data.dart';
import 'item_detail_screen.dart';

/// Frame 10 - full screen progress state while the model tags the garment.
class AnalyzingScreen extends StatefulWidget {
  const AnalyzingScreen({super.key, this.result});

  /// Optional garment to open once analysis finishes.
  final dynamic result;

  @override
  State<AnalyzingScreen> createState() => _AnalyzingScreenState();
}

class _AnalyzingScreenState extends State<AnalyzingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2600), _finish);
  }

  void _finish() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ItemDetailScreen(item: MockData.wardrobe.first),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SwScreen(
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) => CustomPaint(
                      size: const Size.square(110),
                      painter: _SpinnerPainter(_controller.value),
                    ),
                  ),
                  const SizedBox(height: Insets.xxxl),
                  Text(
                    'AI is analyzing\nyour clothing...',
                    textAlign: TextAlign.center,
                    style: AppText.h2,
                  ),
                  const SizedBox(height: Insets.md),
                  Text(
                    'Detecting category, color, style, and more',
                    textAlign: TextAlign.center,
                    style: AppText.body,
                  ),
                  const SizedBox(height: Insets.xxl),
                  _StepDots(progress: _controller),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 28,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SwIconView(
                    SwIcon.shirt,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: Insets.sm),
                  Text(
                    'SmartWardrobe',
                    style: AppText.caption.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Rotating arc used while the model is working.
class _SpinnerPainter extends CustomPainter {
  const _SpinnerPainter(this.t);

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect.deflate(3),
      0,
      6.28318,
      false,
      stroke..color = AppColors.border,
    );
    canvas.drawArc(
      rect.deflate(3),
      -1.5708 + t * 6.28318,
      1.9,
      false,
      stroke..color = AppColors.primary,
    );
  }

  @override
  bool shouldRepaint(_SpinnerPainter old) => old.t != t;
}

/// Three dots that light up in sequence.
class _StepDots extends StatelessWidget {
  const _StepDots({required this.progress});

  final Animation<double> progress;

  static const _steps = ['Analyze', 'Tag', 'Match'];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, _) {
        final active = (progress.value * 3).floor().clamp(0, 2);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < _steps.length; i++) ...[
              if (i > 0) const SizedBox(width: Insets.md),
              Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == active ? AppColors.primary : AppColors.border,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _steps[i],
                    style: AppText.overline.copyWith(fontSize: 9),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
