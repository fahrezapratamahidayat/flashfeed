import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pusat Bantuan"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Bagaimana kami dapat membantu?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          _helpTile(
            icon: Icons.account_circle_outlined,
            title: 'Masalah Akun',
            subtitle: 'Reset password, edit profil, dll.',
            onTap: () {},
          ),
          _helpTile(
            icon: Icons.notifications_none,
            title: 'Notifikasi & Berita',
            subtitle: 'Kelola preferensi notifikasi.',
            onTap: () {},
          ),
          _helpTile(
            icon: Icons.bookmark_border,
            title: 'Berita Tersimpan',
            subtitle: 'Cara menyimpan dan menghapus berita.',
            onTap: () {},
          ),
          _helpTile(
            icon: Icons.language,
            title: 'Bahasa & Regional',
            subtitle: 'Ubah bahasa atau lokasi berita.',
            onTap: () {},
          ),
          _helpTile(
            icon: Icons.contact_support_outlined,
            title: 'Hubungi Kami',
            subtitle: 'Bantuan lebih lanjut dari tim kami.',
            onTap: () {
              // Navigasi ke halaman kontak atau kirim email
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              "Versi Aplikasi: 1.0.0",
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _helpTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Icon(icon, size: 28),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
