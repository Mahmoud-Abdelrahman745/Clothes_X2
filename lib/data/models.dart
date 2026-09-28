import 'package:flutter/widgets.dart';

/// A single garment in the user's wardrobe.
@immutable
class ClothingItem {
  const ClothingItem({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.color,
    required this.style,
    required this.material,
    required this.season,
    required this.formality,
    this.timesWorn = 0,
    this.lastWornLabel,
  });

  final String id;
  final String name;
  final String image;
  final String category;
  final String color;
  final String style;
  final String material;
  final String season;
  final String formality;
  final int timesWorn;
  final String? lastWornLabel;

  /// Compact "Tops • White" style summary used under the product name.
  String get meta => '$category • $color';
}

/// A saved or AI generated outfit.
@immutable
class Outfit {
  const Outfit({
    required this.id,
    required this.name,
    required this.image,
    required this.occasion,
    required this.match,
    required this.pieces,
    this.summary,
  });

  final String id;
  final String name;
  final String image;
  final String occasion;
  final int match;

  /// Names of the garments combined into this outfit.
  final List<String> pieces;
  final String? summary;
}

/// A single row in the AI stylist conversation.
@immutable
class ChatMessage {
  const ChatMessage({required this.fromUser, required this.text, this.outfit});

  final bool fromUser;
  final String text;
  final Outfit? outfit;
}

/// A garment recommendation produced by the shopping assistant.
@immutable
class ShoppingPick {
  const ShoppingPick({
    required this.name,
    required this.price,
    required this.image,
    required this.reason,
    this.wishlisted = false,
  });

  final String name;
  final String price;
  final String image;
  final String reason;
  final bool wishlisted;
}

/// A packed item in the travel planner.
@immutable
class PackingEntry {
  const PackingEntry({
    required this.name,
    required this.image,
    this.packed = true,
  });

  final String name;
  final String image;
  final bool packed;
}

/// One day of the outfit planner.
@immutable
class PlanDay {
  const PlanDay({
    required this.weekday,
    required this.date,
    required this.occasion,
    required this.outfitName,
    required this.image,
    this.isToday = false,
  });

  final String weekday;
  final String date;
  final String occasion;
  final String outfitName;
  final String image;
  final bool isToday;
}

/// A single style-DNA segment.
@immutable
class StyleSegment {
  const StyleSegment({
    required this.label,
    required this.share,
    required this.color,
  });

  final String label;
  final int share;
  final Color color;
}

/// A named colour with a swatch and an item count.
@immutable
class StyleColor {
  const StyleColor({required this.name, required this.value, this.count});

  final String name;
  final int value;
  final int? count;
}
