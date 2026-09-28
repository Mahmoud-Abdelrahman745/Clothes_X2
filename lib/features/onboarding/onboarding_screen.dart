import 'package:flutter/material.dart';

import '../../app.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import '../../data/assets.dart';

/// Frames 2-4 - the three slide intro carousel.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  static const _slides = [
    _Slide(
      title: 'Your Wardrobe, Digitized',
      body:
          'Scan and organize your clothes in minutes. Upload photos of your '
          'wardrobe and let AI categorize and tag them for you.',
      image: Img.onboardingWardrobe,
    ),
    _Slide(
      title: 'AI That Understands Your Style',
      body:
          'Get bespoke styling advice. Receive daily outfit recommendations '
          'crafted by advanced AI matching weather, schedule, and personal '
          'tastes.',
      image: Img.onboardingAiStyle,
    ),
    _Slide(
      title: 'Plan Every Outfit',
      body:
          "Coordinate upcoming events, weekly outfits, and travel packing "
          "lists. Say goodbye to the morning 'what to wear' panic forever.",
      image: Img.onboardingPlan,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_index == _slides.length - 1) {
      Navigator.of(context).pushReplacementNamed(Routes.login);
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _slides.length - 1;

    return SwScreen(
      child: Column(
        children: [
          SizedBox(height: swTopAnchor(context, 86)),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: Insets.lg),
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(Routes.login),
                child: Text('Skip', style: AppText.label),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (i) => setState(() => _index = i),
              itemCount: _slides.length,
              itemBuilder: (context, i) =>
                  _SlideView(slide: _slides[i], isActive: i == _index),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Insets.lg,
              0,
              Insets.lg,
              Insets.sm,
            ),
            child: Column(
              children: [
                _Dots(count: _slides.length, index: _index),
                const SizedBox(height: Insets.lg),
                SwButton(label: isLast ? 'Get Started' : 'Next', onTap: _next),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide {
  const _Slide({required this.title, required this.body, required this.image});

  final String title;
  final String body;
  final String image;
}

class _SlideView extends StatelessWidget {
  const _SlideView({required this.slide, required this.isActive});

  final _Slide slide;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.lg),
              child: Column(
                // The design leaves a large flexible gap above the artwork and a
                // smaller one below the copy, so the block sits just above centre.
                children: [
                  const Spacer(flex: 5),
                  _SlideImage(image: slide.image, animate: isActive),
                  const SizedBox(height: Insets.xl),
                  Text(
                    slide.title,
                    textAlign: TextAlign.center,
                    style: AppText.h2,
                  ),
                  const SizedBox(height: Insets.md),
                  Text(
                    slide.body,
                    textAlign: TextAlign.center,
                    style: AppText.body,
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Rounded photo panel that fades in as its slide becomes active.
class _SlideImage extends StatelessWidget {
  const _SlideImage({required this.image, required this.animate});

  final String image;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 420),
      opacity: animate ? 1 : 0.35,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Radii.xl),
        child: AspectRatio(
          aspectRatio: 16 / 11,
          child: Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 20 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : AppColors.border,
            borderRadius: Radii.pillRadius,
          ),
        );
      }),
    );
  }
}
