import 'package:flutter/material.dart';

import '../../core/icons/sw_icon.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import 'analyzing_screen.dart';

/// Frame 9 - three capture options above the AI generated attribute tags.
class AddClothingScreen extends StatelessWidget {
  const AddClothingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void goToAnalyzing() {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const AnalyzingScreen()));
    }

    return SwScreen(
      scroll: true,
      padding: const EdgeInsets.only(bottom: Insets.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SwAppBar(title: 'Add New Clothing'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
            child: Column(
              children: [
                _SourceTile(
                  icon: SwIcon.camera,
                  title: 'Take Photo',
                  subtitle: 'Instantly capture and auto-tag a piece',
                  onTap: goToAnalyzing,
                ),
                const SizedBox(height: Insets.md),
                _SourceTile(
                  icon: SwIcon.image,
                  title: 'Choose from Gallery',
                  subtitle: 'Select existing clothing images',
                  onTap: goToAnalyzing,
                ),
                const SizedBox(height: Insets.md),
                _SourceTile(
                  icon: SwIcon.upload,
                  title: 'Upload Multiple',
                  subtitle: 'Bulk import your wardrobe catalog',
                  onTap: goToAnalyzing,
                ),
                const SizedBox(height: Insets.xl),
                const Divider(height: 1),
                const SizedBox(height: Insets.lg),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(
                          AppColors.primaryLight,
                        ),
                      ),
                    ),
                    const SizedBox(width: Insets.md),
                    Expanded(
                      child: Text(
                        'AI is analyzing your clothing...',
                        style: AppText.bodyStrong.copyWith(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Insets.lg),
                const _TagGrid(),
                const SizedBox(height: Insets.xxl),
                SwButton(
                  label: 'Save to Wardrobe',
                  onTap: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Saved to your wardrobe.'),
                        ),
                      );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Tappable capture method row.
class _SourceTile extends StatelessWidget {
  const _SourceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final SwIcon icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SwCard(
      onTap: onTap,
      padding: const EdgeInsets.all(Insets.lg),
      child: Row(
        children: [
          SwIconBadge(icon: icon, size: 44, iconSize: 20),
          const SizedBox(width: Insets.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.cardTitle),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.caption,
                ),
              ],
            ),
          ),
          const SwIconView(
            SwIcon.chevronRight,
            size: 16,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}

/// The editable AI attribute grid: two columns of label / value / pencil.
class _TagGrid extends StatelessWidget {
  const _TagGrid();

  static const _tags = <(String, String)>[
    ('CATEGORY', 'Shirt'),
    ('COLOR', 'White'),
    ('STYLE', 'Casual'),
    ('PATTERN', 'Plain'),
    ('MATERIAL', 'Cotton'),
    ('SEASON', 'Spring/Summer'),
    ('FORMALITY', 'Casual'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = Insets.md;
        final width = (constraints.maxWidth - gap) / 2;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final (label, value) in _tags)
              SizedBox(
                width: width,
                child: _TagCell(label: label, value: value),
              ),
          ],
        );
      },
    );
  }
}

class _TagCell extends StatelessWidget {
  const _TagCell({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SwCard(
      padding: const EdgeInsets.all(Insets.md),
      onTap: () => _editTag(context, label, value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppText.overline.copyWith(fontSize: 9)),
                const SizedBox(height: 3),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bodyStrong.copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
          const SwIconView(
            SwIcon.edit,
            size: 14,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }

  void _editTag(BuildContext context, String label, String value) {
    final controller = TextEditingController(text: value);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          left: Insets.xl,
          right: Insets.xl,
          top: Insets.xl,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + Insets.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(label, style: AppText.h4),
            const SizedBox(height: Insets.lg),
            SwField(label: 'Value', controller: controller),
            const SizedBox(height: Insets.xl),
            SwButton(
              label: 'Save',
              onTap: () => Navigator.of(sheetContext).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
