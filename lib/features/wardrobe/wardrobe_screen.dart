import 'package:flutter/material.dart';

import '../../core/icons/sw_icon.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';
import 'add_clothing_screen.dart';
import 'item_detail_screen.dart';

/// Frame 8 - searchable, filterable grid of every catalogued garment.
class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({super.key});

  @override
  State<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  final _search = TextEditingController();
  String _filter = MockData.wardrobeFilters.first;

  @override
  void initState() {
    super.initState();
    _search.addListener(_onSearch);
  }

  @override
  void dispose() {
    _search
      ..removeListener(_onSearch)
      ..dispose();
    super.dispose();
  }

  void _onSearch() => setState(() {});

  List<ClothingItem> get _visible {
    final query = _search.text.trim().toLowerCase();
    return MockData.wardrobe.where((item) {
      final matchesFilter = _filter == 'All' || item.category == _filter;
      final matchesQuery =
          query.isEmpty ||
          item.name.toLowerCase().contains(query) ||
          item.color.toLowerCase().contains(query) ||
          item.style.toLowerCase().contains(query);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _visible;

    return SwScreen(
      bottomBar: _AddClothesBar(
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const AddClothingScreen())),
      ),
      child: Column(
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
                Expanded(child: Text('My Wardrobe', style: AppText.h1)),
                SwIconButton(
                  icon: SwIconButtonKind.filter,
                  onTap: () => _toast(context, 'Advanced filters coming soon.'),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
            child: _SearchField(controller: _search),
          ),
          const SizedBox(height: Insets.md),
          _FilterBar(
            selected: _filter,
            onSelect: (v) => setState(() => _filter = v),
          ),
          const SizedBox(height: Insets.lg),
          Expanded(
            child: items.isEmpty
                ? _EmptyWardrobe(query: _search.text)
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      Insets.gutter,
                      0,
                      Insets.gutter,
                      96,
                    ),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: Insets.lg,
                          crossAxisSpacing: Insets.md,
                          childAspectRatio: 0.72,
                        ),
                    itemCount: items.length,
                    itemBuilder: (context, i) => _GridCell(item: items[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppText.field,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: 'Search in your wardrobe...',
        hintStyle: AppText.fieldHint,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: Insets.lg, right: Insets.md),
          child: SwIconView(
            SwIcon.search,
            size: 18,
            color: AppColors.textTertiary,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Insets.lg,
          vertical: Insets.lg,
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.selected, required this.onSelect});

  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
        physics: const BouncingScrollPhysics(),
        itemCount: MockData.wardrobeFilters.length,
        separatorBuilder: (_, _) => const SizedBox(width: Insets.sm),
        itemBuilder: (context, i) {
          final label = MockData.wardrobeFilters[i];
          return SwChip(
            label: label,
            selected: label == selected,
            onTap: () => onSelect(label),
          );
        },
      ),
    );
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({required this.item});

  final ClothingItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => ItemDetailScreen(item: item))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SwProductImage(image: item.image, radius: Radii.lg),
            ),
          ),
          const SizedBox(height: Insets.sm),
          Text(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.labelStrong.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 1),
          Text(
            item.meta,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.caption.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _EmptyWardrobe extends StatelessWidget {
  const _EmptyWardrobe({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Insets.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SwIconBadge(
              icon: SwIcon.shirt,
              size: 64,
              iconSize: 28,
              circle: true,
            ),
            const SizedBox(height: Insets.lg),
            Text(
              query.isEmpty ? 'Nothing here yet' : 'No matches',
              style: AppText.h4,
            ),
            const SizedBox(height: Insets.sm),
            Text(
              query.isEmpty
                  ? 'Add clothing to fill this category.'
                  : 'Try a different search or filter.',
              textAlign: TextAlign.center,
              style: AppText.body,
            ),
          ],
        ),
      ),
    );
  }
}

/// Persistent primary action pinned above the tab bar.
class _AddClothesBar extends StatelessWidget {
  const _AddClothesBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(
        Insets.lg,
        Insets.md,
        Insets.lg,
        Insets.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton.icon(
            onPressed: onTap,
            icon: const SwIconView(SwIcon.plus, size: 16, color: Colors.white),
            label: const Text('Add Clothes'),
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, 48),
              padding: const EdgeInsets.symmetric(horizontal: Insets.xl),
              textStyle: AppText.button,
              shape: const RoundedRectangleBorder(
                borderRadius: Radii.pillRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
