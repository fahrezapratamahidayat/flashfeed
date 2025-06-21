import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flashfeed/src/widgets/app_text.dart';
import 'package:flashfeed/src/widgets/spacing.dart';
import 'package:flashfeed/src/widgets/theme_switcher.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            floating: false,
            pinned: true,
            backgroundColor: colorScheme.surface,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurface),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Edit profil'),
                      backgroundColor: colorScheme.inverseSurface,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: Icon(Icons.edit, color: colorScheme.onSurface),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildProfileHeader(colorScheme, user),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildMyArticlesCard(colorScheme, context),
                Spacing.vertical(Spacing.xl),
                _buildSettingsSection(colorScheme),
                Spacing.vertical(Spacing.xl),
                _buildLogoutButton(colorScheme),
                Spacing.vertical(Spacing.lg),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ColorScheme colorScheme, user) {
    return Container(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 38,
              backgroundColor: colorScheme.surfaceContainer,
              backgroundImage: user?.avatar != null && user!.avatar.isNotEmpty
                  ? NetworkImage(user.avatar)
                  : const NetworkImage(
                      'https://randomuser.me/api/portraits/men/42.jpg',
                    ),
            ),
          ),
          Spacing.vertical(Spacing.md),
          AppText(
            text: user?.name ?? "Nama Pengguna",
            variant: AppTextVariant.headingSmall,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
          Spacing.vertical(4),
          AppText(
            text: user?.email ?? "email@example.com",
            variant: AppTextVariant.bodyMedium,
            textAlign: TextAlign.center,
            color: colorScheme.onSurfaceVariant,
          ),
          if (user?.title != null && user!.title.isNotEmpty) ...[
            Spacing.vertical(4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: AppText(
                text: user.title,
                variant: AppTextVariant.bodySmall,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMyArticlesCard(ColorScheme colorScheme, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.article,
                  color: colorScheme.onPrimary,
                  size: 20,
                ),
              ),
              Spacing.horizontal(Spacing.md),
              AppText(
                text: 'Berita Saya',
                variant: AppTextVariant.titleMedium,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          Spacing.vertical(Spacing.md),
          AppText(
            text: 'Lihat dan kelola daftar berita yang telah Anda buat',
            variant: AppTextVariant.bodyMedium,
            color: colorScheme.onSurfaceVariant,
          ),
          Spacing.vertical(Spacing.lg),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.myArticles);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: AppText(
                text: 'Lihat Berita Saya',
                variant: AppTextVariant.bodyMedium,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Pengaturan',
          variant: AppTextVariant.titleMedium,
          fontWeight: FontWeight.w600,
        ),
        Spacing.vertical(Spacing.lg),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _buildSettingItem(
                icon: Icons.person,
                iconColor: Colors.blue,
                title: 'Profil Anda',
                subtitle: 'Ubah informasi profil',
                onTap: () => _showSnackBar('Profil'),
              ),
              _buildDivider(),
              _buildSettingItem(
                icon: Icons.lock,
                iconColor: Colors.orange,
                title: 'Keamanan',
                subtitle: 'Kata sandi dan keamanan',
                onTap: () => _showSnackBar('Keamanan'),
              ),
              _buildDivider(),
              _buildSettingItem(
                icon: Icons.notifications,
                iconColor: Colors.green,
                title: 'Notifikasi',
                subtitle: 'Preferensi notifikasi',
                onTap: () => _showSnackBar('Notifikasi'),
              ),
              _buildDivider(),
              _buildSettingItem(
                icon: Icons.language,
                iconColor: Colors.purple,
                title: 'Bahasa',
                subtitle: 'Ubah bahasa aplikasi',
                onTap: () => _showSnackBar('Bahasa'),
              ),
              _buildDivider(),
              _buildSettingItem(
                icon: Icons.palette,
                iconColor: Colors.teal,
                title: 'Tampilan',
                subtitle: 'Ubah tema aplikasi',
                trailing: const ThemeSwitcher(),
                onTap: () {},
              ),
              _buildDivider(),
              _buildSettingItem(
                icon: Icons.privacy_tip,
                iconColor: Colors.red,
                title: 'Privasi',
                subtitle: 'Pengaturan privasi',
                onTap: () => _showSnackBar('Privasi'),
              ),
              _buildDivider(),
              _buildSettingItem(
                icon: Icons.help,
                iconColor: Colors.indigo,
                title: 'Bantuan',
                subtitle: 'Pusat bantuan dan FAQ',
                onTap: () => _showSnackBar('Bantuan'),
              ),
              _buildDivider(),
              _buildSettingItem(
                icon: Icons.info,
                iconColor: Colors.grey,
                title: 'Tentang',
                subtitle: 'Informasi aplikasi',
                onTap: () => _showSnackBar('Tentang'),
                showArrow: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
    bool showArrow = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            Spacing.horizontal(Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: title,
                    variant: AppTextVariant.bodyMedium,
                    fontWeight: FontWeight.w500,
                  ),
                  Spacing.vertical(2),
                  AppText(
                    text: subtitle,
                    variant: AppTextVariant.bodySmall,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
            if (trailing != null)
              trailing
            else if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildLogoutButton(ColorScheme colorScheme) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        onPressed: _showLogoutConfirmation,
        icon: Icon(Icons.logout, size: 18, color: colorScheme.error),
        label: AppText(
          text: 'Keluar',
          variant: AppTextVariant.bodyMedium,
          color: colorScheme.error,
          fontWeight: FontWeight.w500,
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colorScheme.error.withValues(alpha: 0.3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showLogoutConfirmation() {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Keluar dari Akun'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: colorScheme.primary)),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout().then((
                _,
              ) {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              elevation: 0,
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}
