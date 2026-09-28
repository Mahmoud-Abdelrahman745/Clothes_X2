import '../core/theme/app_colors.dart';
import 'assets.dart';
import 'models.dart';

/// Static content backing every screen, mirroring the Figma copy exactly.
abstract final class MockData {
  static const String userName = 'Karim';
  static const String userFullName = 'Karim Hassan';
  static const String userEmail = 'karim@wardrobe.ai';
  static const String appVersion = 'v2.0 • Premium Fashion Intelligence';

  // ---------------------------------------------------------------- Wardrobe

  static const List<ClothingItem> wardrobe = [
    ClothingItem(
      id: 'w1',
      name: 'Oxford Cotton Shirt',
      image: Img.shirtWhiteSoft,
      category: 'Tops',
      color: 'White',
      style: 'Casual',
      material: '100% Cotton',
      season: 'Spring / Summer',
      formality: 'Casual / Semi-Formal',
      timesWorn: 19,
      lastWornLabel: 'Worn 4 days ago',
    ),
    ClothingItem(
      id: 'w2',
      name: 'Raw Denim Jeans',
      image: Img.jeansRawDenim,
      category: 'Bottoms',
      color: 'Indigo',
      style: 'Raw Indigo',
      material: '100% Cotton',
      season: 'All Season',
      formality: 'Casual',
      timesWorn: 12,
      lastWornLabel: 'Worn 1 week ago',
    ),
    ClothingItem(
      id: 'w3',
      name: 'Beige Knit Sweater',
      image: Img.sweaterCable,
      category: 'Tops',
      color: 'Beige',
      style: 'Smart Casual',
      material: 'Merino Wool',
      season: 'Autumn / Winter',
      formality: 'Smart Casual',
      timesWorn: 14,
      lastWornLabel: 'Worn 6 days ago',
    ),
    ClothingItem(
      id: 'w4',
      name: 'Minimalist Sneakers',
      image: Img.sneakersMinimal,
      category: 'Shoes',
      color: 'White',
      style: 'Minimal',
      material: 'Leather',
      season: 'All Season',
      formality: 'Casual',
      timesWorn: 17,
      lastWornLabel: 'Worn 2 days ago',
    ),
    ClothingItem(
      id: 'w5',
      name: 'Linen Summer Blazer',
      image: Img.blazerBeige,
      category: 'Outerwear',
      color: 'Beige',
      style: 'Smart Casual',
      material: 'Linen Blend',
      season: 'Spring / Summer',
      formality: 'Smart Casual',
      timesWorn: 9,
      lastWornLabel: 'Worn 3 days ago',
    ),
    ClothingItem(
      id: 'w6',
      name: 'Minimalist Leather Belt',
      image: Img.beltTan,
      category: 'Accessories',
      color: 'Tan',
      style: 'Minimal',
      material: 'Full Grain Leather',
      season: 'All Season',
      formality: 'Casual / Formal',
      timesWorn: 21,
      lastWornLabel: 'Worn yesterday',
    ),
    ClothingItem(
      id: 'w7',
      name: 'Suede Jacket',
      image: Img.jacketSuede,
      category: 'Outerwear',
      color: 'Dark Brown',
      style: 'Vintage',
      material: 'Suede',
      season: 'Autumn / Winter',
      formality: 'Casual',
      timesWorn: 24,
      lastWornLabel: 'Worn 2 days ago',
    ),
    ClothingItem(
      id: 'w8',
      name: 'Leather Loafers',
      image: Img.loafersBrown,
      category: 'Shoes',
      color: 'Brown',
      style: 'Classic',
      material: 'Leather',
      season: 'Spring / Summer',
      formality: 'Formal',
      timesWorn: 11,
      lastWornLabel: 'Worn 5 days ago',
    ),
    ClothingItem(
      id: 'w9',
      name: 'Tailored Trousers',
      image: Img.trousersGrey,
      category: 'Bottoms',
      color: 'Charcoal',
      style: 'Modern',
      material: 'Wool Blend',
      season: 'Autumn / Winter',
      formality: 'Formal',
      timesWorn: 8,
      lastWornLabel: 'Worn 1 week ago',
    ),
    ClothingItem(
      id: 'w10',
      name: 'Silk Scarf',
      image: Img.scarfSilk,
      category: 'Accessories',
      color: 'Multicolor',
      style: 'Elegant',
      material: 'Silk',
      season: 'All Season',
      formality: 'Elegant',
      timesWorn: 0,
      lastWornLabel: 'Unworn for 60+ days',
    ),
    ClothingItem(
      id: 'w11',
      name: 'Beige Chinos',
      image: Img.chinosBeige,
      category: 'Bottoms',
      color: 'Beige',
      style: 'Smart Casual',
      material: 'Cotton Twill',
      season: 'Spring / Summer',
      formality: 'Smart Casual',
      timesWorn: 15,
      lastWornLabel: 'Worn 3 days ago',
    ),
    ClothingItem(
      id: 'w12',
      name: 'Navy Wool Blazer',
      image: Img.blazerNavy,
      category: 'Outerwear',
      color: 'Navy',
      style: 'Formal',
      material: 'Wool',
      season: 'Autumn / Winter',
      formality: 'Formal',
      timesWorn: 6,
      lastWornLabel: 'Worn 2 weeks ago',
    ),
  ];

  static const List<String> wardrobeFilters = [
    'All',
    'Tops',
    'Bottoms',
    'Shoes',
    'Outerwear',
    'Accessories',
  ];

  /// The four items shown in the Home "Recently Added" rail.
  static const List<ClothingItem> recentlyAdded = [
    ClothingItem(
      id: 'r1',
      name: 'Suede Jacket',
      image: Img.jacketSuede,
      category: 'Outerwear',
      color: 'Dark Brown',
      style: 'Vintage',
      material: 'Suede',
      season: 'Autumn / Winter',
      formality: 'Casual',
    ),
    ClothingItem(
      id: 'r2',
      name: 'Leather Loafers',
      image: Img.loafersBrown,
      category: 'Shoes',
      color: 'Brown',
      style: 'Classic',
      material: 'Leather',
      season: 'Spring / Summer',
      formality: 'Formal',
    ),
    ClothingItem(
      id: 'r3',
      name: 'Tailored Trousers',
      image: Img.trousersGrey,
      category: 'Bottoms',
      color: 'Charcoal',
      style: 'Modern',
      material: 'Wool Blend',
      season: 'Autumn / Winter',
      formality: 'Formal',
    ),
    ClothingItem(
      id: 'r4',
      name: 'Silk Scarf',
      image: Img.scarfSilk,
      category: 'Accessories',
      color: 'Multicolor',
      style: 'Elegant',
      material: 'Silk',
      season: 'All Season',
      formality: 'Elegant',
    ),
  ];

  /// Hero card on Home.
  static const Outfit todaySelection = Outfit(
    id: 'o-today',
    name: 'Classic Minimalist Outfit',
    image: Img.outfitClassicMinimalist,
    occasion: 'Daily',
    match: 92,
    pieces: ['Beige Blazer', 'White Tee', 'Chinos'],
    summary: 'Beige Blazer + White Tee + Chinos',
  );

  // ----------------------------------------------------------------- Outfits

  static const List<Outfit> savedOutfits = [
    Outfit(
      id: 'o1',
      name: 'University Casual',
      image: Img.outfitUniversity,
      occasion: 'Academics',
      match: 92,
      pieces: ['White Tee', 'Raw Denim', 'Sneakers'],
    ),
    Outfit(
      id: 'o2',
      name: 'Formal Dinner',
      image: Img.outfitFormalDinner,
      occasion: 'Formal',
      match: 89,
      pieces: ['Navy Suit', 'White Shirt', 'Oxfords'],
    ),
    Outfit(
      id: 'o3',
      name: 'Weekend Chillout',
      image: Img.flatlayDenimKnit,
      occasion: 'Leisure',
      match: 95,
      pieces: ['Denim', 'Knit', 'Loafers'],
    ),
    Outfit(
      id: 'o4',
      name: 'Date Night Elite',
      image: Img.outfitDateNight,
      occasion: 'Elegant',
      match: 88,
      pieces: ['Black Shirt', 'Tailored Trousers'],
    ),
  ];

  static const Outfit favoriteOutfit = Outfit(
    id: 'o-fav',
    name: 'Autumn Layers',
    image: Img.outfitSmartMeeting,
    occasion: 'Smart Casual',
    match: 90,
    pieces: ['Suede Jacket', 'Knit Sweater', 'Chinos'],
  );

  /// Extra looks referenced by the outfit history list.
  static const String outfitUniversity2 = Img.outfitUniversity;
  static const String outfitBrunch = Img.outfitTravel;
  static const String outfitMeeting = Img.outfitSmartMeeting;

  /// Items composing the "Perfect Match" breakdown grid.
  static const List<ClothingItem> perfectMatchPieces = [
    ClothingItem(
      id: 'p1',
      name: 'Beige Blazer',
      image: Img.perfectMatchFlatlay,
      category: 'Tops',
      color: 'Beige',
      style: 'Smart Casual',
      material: 'Linen',
      season: 'Spring',
      formality: 'Smart Casual',
    ),
    ClothingItem(
      id: 'p2',
      name: 'Denim Skirt',
      image: Img.skirtDenim,
      category: 'Bottoms',
      color: 'Indigo',
      style: 'Casual',
      material: 'Denim',
      season: 'All Season',
      formality: 'Casual',
    ),
    ClothingItem(
      id: 'p3',
      name: 'Minimalist Sneakers',
      image: Img.sneakersWhiteTop,
      category: 'Shoes',
      color: 'White',
      style: 'Minimal',
      material: 'Leather',
      season: 'All Season',
      formality: 'Casual',
    ),
    ClothingItem(
      id: 'p4',
      name: 'Minimalist Leather Belt',
      image: Img.beltBlackCloseup,
      category: 'Accessories',
      color: 'Black',
      style: 'Minimal',
      material: 'Leather',
      season: 'All Season',
      formality: 'Formal',
    ),
  ];

  static const List<({String label, int value})> matchBreakdown = [
    (label: 'Color Harmony', value: 95),
    (label: 'Style Compatibility', value: 90),
    (label: 'Occasion Fit', value: 94),
    (label: 'Weather Match', value: 91),
    (label: 'Personal Taste', value: 89),
  ];

  // ------------------------------------------------------------ AI Stylist

  static const List<ChatMessage> stylistIntro = [
    ChatMessage(fromUser: false, text: 'Hi Karim! How can I help you today?'),
    ChatMessage(
      fromUser: true,
      text: 'I need an outfit for university tomorrow.',
    ),
    ChatMessage(
      fromUser: false,
      text:
          "Based on your wardrobe and tomorrow's weather (24°C, partly cloudy), "
          'I recommend this casual outfit:',
      outfit: Outfit(
        id: 'o-chat',
        name: 'Casual Prep Combo',
        image: Img.outfitCasualPrep,
        occasion: 'University',
        match: 92,
        pieces: ['Oxford Shirt', 'Chinos', 'Sneakers'],
        summary: 'Oxford Shirt + Chinos + Sneakers',
      ),
    ),
  ];

  static const List<String> stylistSuggestions = [
    'Outfit for University',
    'Date Outfit',
    'Formal Option',
  ];

  /// Canned replies keyed by a substring of the user's question.
  static const Map<String, String> stylistReplies = {
    'date':
        "Date night calls for something sharper. Try the Navy Blazer with "
        'your White Oxford Shirt and Leather Loafers - 89% match for an elegant '
        'evening look.',
    'formal':
        'For formal events I would suggest the Navy Wool Blazer with the '
        'White Oxford Shirt, Raw Denim replaced by Tailored Trousers. That reads '
        'polished without feeling stiff.',
    'weather':
        'Tomorrow looks like 24°C with partial cloud, so lightweight '
        'layers are ideal. The Oxford Cotton Shirt with Beige Chinos and '
        'Minimalist Sneakers will stay comfortable all day.',
    'travel':
        'For a capsule trip, pack the White Oxford Shirt, Beige Knit '
        'Sweater, Raw Denim Jeans, Beige Chinos, Minimalist Sneakers and the '
        'Silk Scarf. That gives you seven distinct outfits.',
  };

  static const String stylistFallback =
      'I have rebuilt that from your wardrobe. The Beige Blazer with the Oxford '
      'Cotton Shirt and Minimalist Leather Belt is a reliable 92% match - neutral '
      'colours keep it easy to dress up or down.';

  // --------------------------------------------------------- Style avatar

  static const List<ClothingItem> avatarTops = [
    ClothingItem(
      id: 'a1',
      name: 'Beige Blazer',
      image: Img.blazerBeigeHanger,
      category: 'Tops',
      color: 'Beige',
      style: 'Smart Casual',
      material: 'Linen',
      season: 'Spring',
      formality: 'Smart Casual',
    ),
    ClothingItem(
      id: 'a2',
      name: 'White Shirt',
      image: Img.shirtWhiteSoft,
      category: 'Tops',
      color: 'White',
      style: 'Classic',
      material: 'Cotton',
      season: 'All Season',
      formality: 'Semi-Formal',
    ),
    ClothingItem(
      id: 'a3',
      name: 'Blue Shirt',
      image: Img.shirtBlue,
      category: 'Tops',
      color: 'Blue',
      style: 'Modern',
      material: 'Cotton',
      season: 'Spring',
      formality: 'Casual',
    ),
  ];

  static const List<ClothingItem> avatarBottoms = [
    ClothingItem(
      id: 'b1',
      name: 'Raw Denim',
      image: Img.jeansBlue,
      category: 'Bottoms',
      color: 'Indigo',
      style: 'Casual',
      material: 'Denim',
      season: 'All Season',
      formality: 'Casual',
    ),
    ClothingItem(
      id: 'b2',
      name: 'Tailored Trousers',
      image: Img.trousersGrey,
      category: 'Bottoms',
      color: 'Charcoal',
      style: 'Modern',
      material: 'Wool',
      season: 'Winter',
      formality: 'Formal',
    ),
    ClothingItem(
      id: 'b3',
      name: 'Beige Chinos',
      image: Img.chinosBeige,
      category: 'Bottoms',
      color: 'Beige',
      style: 'Smart Casual',
      material: 'Cotton',
      season: 'Spring',
      formality: 'Smart Casual',
    ),
  ];

  // -------------------------------------------------------------- Planner

  static const List<PlanDay> planWeek = [
    PlanDay(
      weekday: 'Mon',
      date: '25',
      occasion: 'University Lectures',
      outfitName: 'Classic Oxford Style',
      image: Img.outfitFlatlayBeige,
    ),
    PlanDay(
      weekday: 'Tue',
      date: '26',
      occasion: 'Coffee with Mia',
      outfitName: 'Soft Weekend Layers',
      image: Img.outfitUniversity,
    ),
    PlanDay(
      weekday: 'Wed',
      date: '27',
      occasion: 'Team Project Presentation',
      outfitName: 'Modern Business Casual',
      image: Img.outfitModernBusiness,
      isToday: true,
    ),
    PlanDay(
      weekday: 'Thu',
      date: '28',
      occasion: 'Group Study',
      outfitName: 'Easy Campus Casual',
      image: Img.outfitUniversity,
    ),
    PlanDay(
      weekday: 'Fri',
      date: '29',
      occasion: 'Dinner with Friends',
      outfitName: 'Elevated Evening Minimal',
      image: Img.outfitDateNight,
    ),
    PlanDay(
      weekday: 'Sat',
      date: '30',
      occasion: 'Farmers Market',
      outfitName: 'Relaxed Weekend',
      image: Img.outfitTravel,
    ),
    PlanDay(
      weekday: 'Sun',
      date: '1',
      occasion: 'Rest Day',
      outfitName: 'Lounge Comfort',
      image: Img.flatlayDenimKnit,
    ),
  ];

  // --------------------------------------------------------------- Travel

  static const List<PackingEntry> packingGroups = [
    PackingEntry(name: 'Oxford White Shirt', image: Img.shirtWhiteSoft),
    PackingEntry(name: 'Beige Knit Sweater', image: Img.sweaterCable),
    PackingEntry(name: 'Raw Denim Jeans', image: Img.jeansRawDenim),
    PackingEntry(name: 'Beige Chinos', image: Img.chinosBeige),
    PackingEntry(name: 'Minimalist Sneakers', image: Img.sneakersMinimal),
    PackingEntry(name: 'Leather Loafers', image: Img.loafersBrown),
    PackingEntry(name: 'Silk Scarf', image: Img.scarfSilk),
    PackingEntry(name: 'Minimalist Leather Belt', image: Img.beltTan),
  ];

  // -------------------------------------------------------------- Insights

  static const List<StyleSegment> styleSegments = [
    StyleSegment(label: 'Casual', share: 45, color: AppColors.primary),
    StyleSegment(label: 'Smart Casual', share: 30, color: AppColors.primaryMid),
    StyleSegment(label: 'Formal', share: 15, color: AppColors.primaryLight),
    StyleSegment(label: 'Sporty', share: 10, color: AppColors.neutral),
  ];

  static const List<StyleColor> favoriteColors = [
    StyleColor(name: 'Black', value: 0xFF1E1C1A, count: 38),
    StyleColor(name: 'White', value: 0xFFFFFFFF, count: 31),
    StyleColor(name: 'Blue', value: 0xFF3D5A80, count: 22),
    StyleColor(name: 'Beige', value: 0xFFE0CDAF, count: 19),
  ];

  static const List<({String name, String icon, int count})>
  favoriteCategories = [
    (name: 'T-Shirts', icon: 'shirt', count: 18),
    (name: 'Jeans', icon: 'circleX', count: 12),
    (name: 'Sneakers', icon: 'circleX', count: 8),
  ];

  /// Six month style trend, plotted on the DNA screen.
  static const List<double> styleEvolution = [
    0.18,
    0.52,
    0.38,
    0.86,
    0.55,
    0.68,
  ];

  static const List<String> evolutionMonths = [
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
  ];

  static const List<({String label, String value})> wardrobeStats = [
    (label: 'Items', value: '124'),
    (label: 'Tops', value: '38'),
    (label: 'Bottoms', value: '24'),
    (label: 'Shoes', value: '18'),
    (label: 'Acc.', value: '44'),
  ];

  static const List<ClothingItem> mostWorn = [
    ClothingItem(
      id: 'm1',
      name: 'Suede Jacket',
      image: Img.jacketSuede,
      category: 'Outerwear',
      color: 'Dark Brown',
      style: 'Vintage',
      material: 'Suede',
      season: 'Autumn / Winter',
      formality: 'Casual',
      timesWorn: 24,
    ),
    ClothingItem(
      id: 'm2',
      name: 'Oxford Shirt',
      image: Img.shirtWhiteSoft,
      category: 'Tops',
      color: 'White',
      style: 'Soft White',
      material: 'Cotton',
      season: 'Spring / Summer',
      formality: 'Semi-Formal',
      timesWorn: 19,
    ),
    ClothingItem(
      id: 'm3',
      name: 'Minimal Sneakers',
      image: Img.sneakersMinimal,
      category: 'Shoes',
      color: 'White',
      style: 'Minimal',
      material: 'Leather',
      season: 'All Season',
      formality: 'Casual',
      timesWorn: 17,
    ),
  ];

  // -------------------------------------------------------------- Shopping

  static const List<ShoppingPick> shoppingPicks = [
    ShoppingPick(
      name: 'White Formal Shirt',
      price: r'$65.00',
      image: Img.shirtWhiteCream,
      reason:
          'You own 4 casual jackets but no formal white shirt to pair them '
          'with for events.',
    ),
    ShoppingPick(
      name: 'Black Oxford Shoes',
      price: r'$120.00',
      image: Img.loafersBlack,
      reason:
          'Your wardrobe lacks formal footwear. These complete 6 smart outfit '
          'gaps.',
    ),
    ShoppingPick(
      name: 'Navy Blazer',
      price: r'$180.00',
      image: Img.blazerNavy,
      reason:
          'Highly versatile. Can layer with all your existing white t-shirts '
          'and trousers.',
    ),
  ];

  // -------------------------------------------------------------- Discover

  static const List<({String name, String tag, String image})> trendingStyles =
      [
        (
          name: 'Minimal Summer',
          tag: 'Monochrome & light fabrics',
          image: Img.trendMinimalSummer,
        ),
        (
          name: 'Smart Casual',
          tag: 'Blazers paired with denim',
          image: Img.trendSmartCasual,
        ),
      ];

  static const List<({String name, int likes, String image})> communityLooks = [
    (name: 'Urban Explorer', likes: 1200, image: Img.communityUrban),
    (name: 'Classic Minimal', likes: 920, image: Img.communityClassic),
    (name: 'Earth Tone Layers', likes: 1840, image: Img.communityGreen),
    (name: 'Soft Neutrals', likes: 760, image: Img.communityCream),
  ];

  // -------------------------------------------------------------- Profile

  static const List<String> preferredStyles = [
    'Casual',
    'Smart Casual',
    'Minimalist',
  ];

  static const List<String> profileColors = ['Black', 'White', 'Blue'];
}
