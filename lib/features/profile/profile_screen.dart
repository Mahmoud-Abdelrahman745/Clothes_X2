import 'package:flutter/material.dart';

import '../../core/icons/sw_icon.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/sw_screen.dart';
import '../../core/widgets/sw_widgets.dart';
import '../../data/assets.dart';
import '../../data/mock_data.dart';
import '../insights/style_dna_screen.dart';
import '../insights/wardrobe_insights_screen.dart';
import '../shop/smart_shopping_screen.dart';

/// Frame 24 - account, style blueprint and app settings.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                      Text('My Profile', style: AppText.h1),
                      const SizedBox(height: 2),
                      Text(
                        'Manage your style blueprint',
                        style: AppText.caption,
                      ),
                    ],
                  ),
                ),
                const SwIconButton(icon: SwIconButtonKind.more),
              ],
            ),
          ),
          const SizedBox(height: Insets.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _IdentityCard(),
                const SizedBox(height: Insets.lg),
                _StyleBlueprintCard(
                  onEdit: () => _toast(context, 'Style profile editor opened.'),
                  onDna: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const StyleDnaScreen()),
                  ),
                ),
                const SizedBox(height: Insets.xl),
                Text('ACCOUNT', style: AppText.overline),
                const SizedBox(height: Insets.md),
                _SettingsGroup(
                  rows: [
                    _SettingRow(
                      icon: SwIcon.user,
                      title: 'My Style Profile',
                      subtitle: 'Body details, preferences',
                    ),
                    _SettingRow(
                      icon: SwIcon.sparkle,
                      title: 'AI Stylist Settings',
                      subtitle: 'Modify tone and response type',
                    ),
                  ],
                ),
                const SizedBox(height: Insets.xl),
                Text('INSIGHTS', style: AppText.overline),
                const SizedBox(height: Insets.md),
                _SettingsGroup(
                  rows: [
                    _SettingRow(
                      icon: SwIcon.chart,
                      title: 'Wardrobe Insights',
                      subtitle: 'What you wear and what you skip',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const WardrobeInsightsScreen(),
                        ),
                      ),
                    ),
                    _SettingRow(
                      icon: SwIcon.bag,
                      title: 'Smart Shopping',
                      subtitle: 'Fill your wardrobe gaps',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SmartShoppingScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Insets.xl),
                Text('APP SETTINGS', style: AppText.overline),
                const SizedBox(height: Insets.md),
                _SettingsGroup(
                  rows: [
                    _SettingRow(
                      icon: SwIcon.circleInfo,
                      title: 'Notifications',
                      subtitle: 'Reminders and tips',
                    ),
                    _SettingRow(
                      icon: SwIcon.box,
                      title: 'Privacy',
                      subtitle: 'Data storage & model training options',
                    ),
                  ],
                ),
                const SizedBox(height: Insets.lg),
                SwOutlineButton(
                  label: 'Logout',
                  foreground: AppColors.danger,
                  onTap: () => _toast(context, 'Signed out.'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard();

  @override
  Widget build(BuildContext context) {
    return SwCard(
      padding: const EdgeInsets.all(Insets.lg),
      child: Row(
        children: [
          SwAvatar(image: Img.avatarKarim, size: 56, name: MockData.userName),
          const SizedBox(width: Insets.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(MockData.userFullName, style: AppText.h4),
                const SizedBox(height: 2),
                Text(MockData.userEmail, style: AppText.caption),
                Text('Member since Aug 2024', style: AppText.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Colours, preferred styles and body measurements.
class _StyleBlueprintCard extends StatelessWidget {
  const _StyleBlueprintCard({required this.onEdit, required this.onDna});

  final VoidCallback onEdit;
  final VoidCallback onDna;

  @override
  Widget build(BuildContext context) {
    return SwCard(
      padding: const EdgeInsets.all(Insets.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Favorite Styling Colors',
                  style: AppText.cardTitle.copyWith(fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: onDna,
                child: Text(
                  'View DNA',
                  style: AppText.labelStrong.copyWith(color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.md),
          Row(
            children: [
              for (var i = 0; i < MockData.profileColors.length; i++) ...[
                if (i > 0) const SizedBox(width: Insets.md),
                _ColorDot(index: i),
              ],
            ],
          ),
          const SizedBox(height: Insets.lg),
          Text(
            'Styles Preferred',
            style: AppText.cardTitle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: Insets.md),
          Wrap(
            spacing: Insets.sm,
            runSpacing: Insets.sm,
            children: [
              for (final style in MockData.preferredStyles)
                SwChip(label: style, dense: true, tone: SwChipTone.tinted),
            ],
          ),
          const SizedBox(height: Insets.lg),
          Text(
            'Body & Fit Specs',
            style: AppText.cardTitle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: Insets.md),
          const Row(
            children: [
              Expanded(
                child: _SpecTile(label: 'Size', value: 'Medium (M)'),
              ),
              SizedBox(width: Insets.md),
              Expanded(
                child: _SpecTile(label: 'Height', value: '178 cm'),
              ),
            ],
          ),
          const SizedBox(height: Insets.lg),
          FilledButton(
            onPressed: onEdit,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(46),
              textStyle: AppText.button,
              shape: const RoundedRectangleBorder(
                borderRadius: Radii.pillRadius,
              ),
            ),
            child: const Text('Edit Style Profile'),
          ),
        ],
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({required this.index});

  final int index;

  static const _values = [0xFF1E1C1A, 0xFFFFFFFF, 0xFF3D5A80];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Color(_values[index]),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
    );
  }
}

class _SpecTile extends StatelessWidget {
  const _SpecTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: Radii.tileRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.caption.copyWith(fontSize: 10)),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppText.bodyStrong.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

/// Grouped list of tappable settings rows.
class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.rows});

  final List<_SettingRow> rows;

  @override
  Widget build(BuildContext context) {
    return SwCard(
      padding: EdgeInsets.zero,
      clip: true,
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            rows[i],
            if (i != rows.length - 1)
              const Padding(
                padding: EdgeInsets.only(left: 52),
                child: Divider(height: 1),
              ),
          ],
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final SwIcon icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Row(
          children: [
            SwIconView(icon, size: 18, color: AppColors.primary),
            const SizedBox(width: Insets.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppText.bodyStrong.copyWith(fontSize: 14)),
                  const SizedBox(height: 1),
                  Text(subtitle, style: AppText.caption),
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
      ),
    );
  }
}

void _toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
