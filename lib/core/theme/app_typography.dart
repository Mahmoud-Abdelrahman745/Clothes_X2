import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Font families used across the app.
abstract final class AppFonts {
  /// High contrast serif used for every headline and the wordmark.
  static const String serif = 'PlayfairDisplay';

  /// Neutral sans used for body copy, labels and controls.
  static const String sans = 'Inter';
}

/// Builds a [TextStyle] that drives the `wght` axis of a variable font.
TextStyle _var(
  String family,
  double size,
  double weight, {
  double? height,
  double? letterSpacing,
  Color? color,
  FontStyle? fontStyle,
}) {
  return TextStyle(
    fontFamily: family,
    fontSize: size,
    height: height,
    letterSpacing: letterSpacing,
    color: color ?? AppColors.textPrimary,
    fontStyle: fontStyle,
    fontWeight: _nearestWeight(weight),
    fontVariations: [FontVariation('wght', weight)],
  );
}

FontWeight _nearestWeight(double w) {
  if (w <= 400) return FontWeight.w400;
  if (w <= 500) return FontWeight.w500;
  if (w <= 600) return FontWeight.w600;
  if (w <= 700) return FontWeight.w700;
  return FontWeight.w800;
}

/// Type scale lifted from the Figma text styles.
abstract final class AppText {
  // ---- Serif (display) -----------------------------------------------------

  /// Splash wordmark - "SmartWardrobe".
  static TextStyle get wordmark =>
      _var(AppFonts.serif, 30, 700, height: 1.1, letterSpacing: -0.4);

  /// Screen titles - "My Wardrobe", "Outfit Planner".
  static TextStyle get h1 =>
      _var(AppFonts.serif, 28, 700, height: 1.15, letterSpacing: -0.3);

  /// Onboarding slide headline.
  static TextStyle get h2 =>
      _var(AppFonts.serif, 24, 700, height: 1.2, letterSpacing: -0.2);

  /// Auth screen headline - "Welcome Back".
  static TextStyle get h3 =>
      _var(AppFonts.serif, 22, 700, height: 1.2, letterSpacing: -0.2);

  /// Product / outfit names.
  static TextStyle get h4 =>
      _var(AppFonts.serif, 18, 700, height: 1.25, letterSpacing: -0.1);

  /// Large numeric readouts such as the donut centre value.
  static TextStyle get numeric =>
      _var(AppFonts.serif, 32, 700, height: 1.1, letterSpacing: -0.5);

  // ---- Sans (interface) ---------------------------------------------------

  /// Primary button label.
  static TextStyle get button =>
      _var(AppFonts.sans, 15, 600, height: 1.2, letterSpacing: 0.1);

  /// Card title.
  static TextStyle get cardTitle =>
      _var(AppFonts.sans, 15, 600, height: 1.3, letterSpacing: -0.1);

  /// Default body copy.
  static TextStyle get body => _var(
    AppFonts.sans,
    14,
    400,
    height: 1.45,
    letterSpacing: 0,
    color: AppColors.textSecondary,
  );

  /// Emphasised body copy.
  static TextStyle get bodyStrong =>
      _var(AppFonts.sans, 14, 600, height: 1.4, letterSpacing: -0.1);

  /// Supporting meta line under a card title.
  static TextStyle get caption => _var(
    AppFonts.sans,
    12,
    400,
    height: 1.35,
    letterSpacing: 0,
    color: AppColors.textSecondary,
  );

  /// Small caps-ish eyebrow label above a value.
  static TextStyle get overline => _var(
    AppFonts.sans,
    10,
    500,
    height: 1.2,
    letterSpacing: 0.9,
    color: AppColors.textTertiary,
  );

  /// Pill, chip and tab label.
  static TextStyle get label =>
      _var(AppFonts.sans, 12, 500, height: 1.2, letterSpacing: 0.1);

  /// Bold pill / badge label.
  static TextStyle get labelStrong =>
      _var(AppFonts.sans, 12, 700, height: 1.2, letterSpacing: 0.1);

  /// Form field text.
  static TextStyle get field => _var(
    AppFonts.sans,
    14,
    400,
    height: 1.3,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// Form field placeholder.
  static TextStyle get fieldHint => _var(
    AppFonts.sans,
    14,
    400,
    height: 1.3,
    letterSpacing: 0,
    color: AppColors.textTertiary,
  );

  /// Wide tracked uppercase tagline under the wordmark.
  static TextStyle get tagline => _var(
    AppFonts.sans,
    11,
    500,
    height: 1.3,
    letterSpacing: 1.4,
    color: AppColors.textSecondary,
  );

  /// Bottom navigation label.
  static TextStyle get navLabel => _var(
    AppFonts.sans,
    10,
    500,
    height: 1.2,
    letterSpacing: 0.1,
    color: AppColors.textTertiary,
  );

  /// Bottom navigation label, active.
  static TextStyle get navLabelActive => _var(
    AppFonts.sans,
    10,
    700,
    height: 1.2,
    letterSpacing: 0.1,
    color: AppColors.primary,
  );

  /// Stat numbers in the insights header.
  static TextStyle get statValue =>
      _var(AppFonts.sans, 16, 700, height: 1.2, letterSpacing: -0.2);

  /// Stat captions in the insights header.
  static TextStyle get statLabel => _var(
    AppFonts.sans,
    9,
    400,
    height: 1.2,
    letterSpacing: 0.2,
    color: AppColors.textTertiary,
  );
}
