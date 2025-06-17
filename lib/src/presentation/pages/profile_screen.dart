import 'package:flutter/material.dart';
import 'package:flashfeed/src/presentation/widgets/app_text.dart';
import 'package:flashfeed/src/presentation/widgets/spacing.dart';
import 'package:flashfeed/src/presentation/widgets/theme_switcher.dart';

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

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Kembali',
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Edit profil'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit Profil',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          backgroundImage: const NetworkImage(
                            'https://randomuser.me/api/portraits/men/42.jpg',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_a_photo,
                          size: 20,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                  Spacing.vertical(Spacing.md),
                  AppText(
                    text: 'Fahreza Pratama Hidayat',
                    variant: AppTextVariant.headingSmall,
                    textAlign: TextAlign.center,
                  ),
                  Spacing.vertical(Spacing.xs),
                  AppText(
                    text: 'fahrezapratamah.dev@gmail.com',
                    variant: AppTextVariant.bodyLarge,
                    textAlign: TextAlign.center,
                    muted: true,
                  ),
                  Spacing.vertical(Spacing.sm),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Pengaturan Akun',
                    variant: AppTextVariant.titleMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacing.vertical(Spacing.md),
                  _buildSettingItem(
                    colorBackgroundIcon: Colors.deepPurpleAccent,
                    icon: Icons.person_outline,
                    title: 'Profil Anda',
                    subtitle: 'Ubah informasi profil Anda',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profil'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  _buildSettingItem(
                    colorBackgroundIcon: Colors.red,
                    icon: Icons.lock_outline,
                    title: 'Keamanan',
                    subtitle: 'Ubah kata sandi dan pengaturan keamanan',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Keamanan'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  _buildSettingItem(
                    colorBackgroundIcon: Colors.orangeAccent,
                    icon: Icons.notifications_none_rounded,
                    title: 'Notifikasi',
                    subtitle: 'Kelola preferensi notifikasi',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Notifikasi'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Pengaturan Aplikasi',
                    variant: AppTextVariant.titleMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacing.vertical(Spacing.md),
                  _buildSettingItem(
                    colorBackgroundIcon: Colors.blue,
                    icon: Icons.language_outlined,
                    title: 'Bahasa',
                    subtitle: 'Ubah bahasa aplikasi',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Bahasa'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  _buildSettingItem(
                    colorBackgroundIcon: Colors.green,
                    icon: Icons.palette_outlined,
                    title: 'Tampilan',
                    subtitle: 'Ubah tema aplikasi',
                    trailing: const ThemeSwitcher(),
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    colorBackgroundIcon: Colors.pink,
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privasi',
                    subtitle: 'Kelola pengaturan privasi',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Privasi'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'Bantuan & Informasi',
                    variant: AppTextVariant.titleMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  Spacing.vertical(Spacing.md),
                  _buildSettingItem(
                    colorBackgroundIcon: Colors.teal,
                    icon: Icons.help_outline_rounded,
                    title: 'Pusat Bantuan',
                    subtitle:
                        'Dapatkan bantuan dan jawaban atas pertanyaan Anda',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pusat Bantuan'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  _buildSettingItem(
                    colorBackgroundIcon: Colors.grey,
                    icon: Icons.info_outline_rounded,
                    title: 'Tentang Aplikasi',
                    subtitle: 'Informasi versi dan lisensi',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tentang Aplikasi'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
              child: OutlinedButton.icon(
                onPressed: () {
                  _showLogoutConfirmation();
                },
                icon: Icon(
                  Icons.logout_rounded,
                  size: 18,
                  color: colorScheme.error,
                ),
                label: Text(
                  'Keluar',
                  style: TextStyle(color: colorScheme.error),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: BorderSide(color: colorScheme.error),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color colorBackgroundIcon,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorBackgroundIcon,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: colorScheme.surface, size: 20),
            ),
            Spacing.horizontal(Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: title, variant: AppTextVariant.titleSmall),
                  Spacing.vertical(4),
                  AppText(
                    text: subtitle,
                    variant: AppTextVariant.bodySmall,
                    muted: true,
                  ),
                ],
              ),
            ),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar dari Akun'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: TextStyle(color: colorScheme.primary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implementasi logout
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Berhasil keluar'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}
