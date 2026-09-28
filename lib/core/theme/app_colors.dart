import 'package:flutter/widgets.dart';

/// Colour tokens extracted directly from the Figma design.
abstract final class AppColors {
  /// Page / scaffold background - warm off white.
  static const Color background = Color(0xFFFAF9F5);

  /// Card and sheet surface.
  static const Color surface = Color(0xFFFFFFFF);

  /// Brand purple - primary actions, active states.
  static const Color primary = Color(0xFF5E4B8B);

  /// Mid purple used in charts and gradients.
  static const Color primaryMid = Color(0xFF7B62B3);

  /// Light purple used for the lightest chart segments.
  static const Color primaryLight = Color(0xFF9D82D2);

  /// Warm neutral grey used for the "Sporty" data segment.
  static const Color neutral = Color(0xFF99928C);

  /// Headline and title copy.
  static const Color textPrimary = Color(0xFF1E1C1A);

  /// Supporting copy, labels, subtitles.
  static const Color textSecondary = Color(0xFF6B6560);

  /// Faint copy: placeholders, captions, disabled labels.
  static const Color textTertiary = Color(0xFF99928C);

  /// Hairline borders around cards and fields.
  static const Color border = Color(0xFFE3E0DB);

  /// Tinted purple panel used for hints and "why recommended" blocks.
  static const Color tint = Color(0xFFEAE6F4);

  /// Pressed / hover state for primary surfaces.
  static const Color primaryPressed = Color(0xFF524080);

  /// Soft purple wash behind small icons.
  static const Color iconTint = Color(0xFFF1EEF7);

  /// Warm accent used by the weather pill on Home.
  static const Color sun = Color(0xFFF5A623);

  /// Warm accent used by the travel forecast banner.
  static const Color travelTint = Color(0xFFFBF1E3);

  /// Destructive / warning surface.
  static const Color dangerSurface = Color(0xFFFFF4F4);

  /// Destructive / warning border.
  static const Color dangerBorder = Color(0xFFFFD9D9);

  /// Destructive / warning text.
  static const Color danger = Color(0xFFE5484D);

  /// Muted green used by "packed" checkmarks.
  static const Color success = Color(0xFF2E9E5B);

  /// Translucent white used for scrims over imagery.
  static const Color scrim = Color(0x66000000);
}
