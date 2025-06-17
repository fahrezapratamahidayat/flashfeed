import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArticleDetailPage extends StatefulWidget {
  final String articleId;

  const ArticleDetailPage({super.key, required this.articleId});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  bool _isBookmarked = false;
  bool _isLiked = false;
  bool _showComments = false;

  final Map<String, dynamic> _articleData = {
    'id': 'artikel-123',
    'title': 'Pecco Bagnaia Berhasil Pertahankan Gelar Juara Dunia MotoGP 2023',
    'category': 'MotoGP',
    'publishedAt': '27 Nov 2023',
    'readTime': '6 menit',
    'author': {
      'name': 'Budi Santoso',
      'title': 'Jurnalis Olahraga',
      'avatar': 'https://randomuser.me/api/portraits/men/32.jpg',
      'followers': 5243,
    },
    'imageUrl':
        'https://images.unsplash.com/photo-1562402082-05a4e888ca96?q=80&w=1121&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'isTrending': true,
    'views': 24580,
    'likes': 2568,
    'commentsCount': 128,
    'tags': ['MotoGP', 'Bagnaia', 'Ducati'],
    'content': '''
Pembalap Ducati, Francesco Bagnaia, berhasil mempertahankan gelar juara dunia MotoGP setelah finis di posisi kelima pada balapan pamungkas musim 2023 di Sirkuit Ricardo Tormo, Valencia, Minggu (26/11/2023). Bagnaia mengamankan gelar juara dunia keduanya secara beruntun setelah rival terdekatnya, Jorge Martin, terjatuh pada lap ketujuh.

Bagnaia menjadi pembalap Italia pertama yang berhasil memenangkan dua gelar juara dunia MotoGP secara beruntun setelah Valentino Rossi. Pencapaian ini semakin istimewa karena diraih di tengah persaingan yang sangat ketat sepanjang musim dengan Jorge Martin dari tim Pramac Racing.

"Ini adalah perasaan yang luar biasa. Musim ini sangat sulit, saya dan tim bekerja sangat keras. Saya ingin berterima kasih kepada semua orang yang mendukung saya," kata Bagnaia usai balapan.

Balapan di Valencia sendiri diwarnai dengan insiden dramatis saat Jorge Martin terjatuh di Tikungan 4 pada lap ketujuh. Martin, yang memulai balapan dengan keunggulan 14 poin di belakang Bagnaia dalam klasemen, terpaksa merelakan peluangnya untuk menjadi juara dunia setelah insiden tersebut.

"Saya mencoba memberikan yang terbaik, tapi mungkin saya terlalu memaksakan diri. Ini adalah pelajaran berharga untuk karier saya," ujar Martin dengan kecewa.

Sementara itu, balapan di Valencia dimenangkan oleh pembalap Gresini Racing, Alex Marquez, diikuti oleh Johann Zarco (LCR Honda) di posisi kedua dan Brad Binder (KTM Factory Racing) di posisi ketiga.

Kemenangan Bagnaia musim ini semakin memperkuat dominasi Ducati dalam kejuaraan MotoGP. Pabrikan Italia tersebut juga telah mengamankan gelar juara konstruktor dan tim, menjadikan 2023 sebagai tahun yang sempurna bagi mereka.

Dengan dua gelar juara dunia di usianya yang masih 26 tahun, Bagnaia kini masuk dalam jajaran pembalap elit dalam sejarah MotoGP. Banyak pengamat memprediksi bahwa pembalap Italia ini akan menjadi kekuatan dominan dalam beberapa tahun ke depan.

Musim MotoGP 2024 akan dimulai pada Maret tahun depan dengan balapan pembuka di Qatar. Bagnaia akan kembali membela Ducati dan bertekad untuk meraih gelar juara dunia ketiga secara beruntun.
''',
    'comments': [
      {
        'id': 'comment-1',
        'user': {
          'name': 'Ahmad Ridwan',
          'avatar': 'https://randomuser.me/api/portraits/men/42.jpg',
        },
        'content':
            'Bagnaia memang pantas jadi juara! Konsistensinya sepanjang musim luar biasa.',
        'timestamp': '2 jam yang lalu',
        'likes': 24,
      },
      {
        'id': 'comment-2',
        'user': {
          'name': 'Siti Aminah',
          'avatar': 'https://randomuser.me/api/portraits/women/56.jpg',
        },
        'content':
            'Kasihan Martin, padahal tinggal selangkah lagi menuju gelar juara dunia pertamanya.',
        'timestamp': '4 jam yang lalu',
        'likes': 18,
      },
      {
        'id': 'comment-3',
        'user': {
          'name': 'Rudi Hermawan',
          'avatar': 'https://randomuser.me/api/portraits/men/61.jpg',
        },
        'content':
            'Ducati mendominasi musim ini, tapi tahun depan Honda dan Yamaha pasti akan comeback!',
        'timestamp': '6 jam yang lalu',
        'likes': 12,
      },
      {
        'id': 'comment-4',
        'user': {
          'name': 'Dewi Lestari',
          'avatar': 'https://randomuser.me/api/portraits/women/22.jpg',
        },
        'content':
            'Balapan terakhir musim ini sangat dramatis! Tidak sabar menunggu musim depan.',
        'timestamp': '8 jam yang lalu',
        'likes': 9,
      },
      {
        'id': 'comment-5',
        'user': {
          'name': 'Bima Sakti',
          'avatar': 'https://randomuser.me/api/portraits/men/79.jpg',
        },
        'content':
            'Saya sudah mendukung Bagnaia sejak di Moto2. Senang melihat perkembangannya sampai bisa menjadi juara dunia MotoGP dua kali berturut-turut.',
        'timestamp': '10 jam yang lalu',
        'likes': 32,
      },
    ],
    'relatedArticles': [
      {
        'id': 'artikel-124',
        'title':
            'Marc Marquez Resmi Bergabung dengan Ducati Gresini untuk Musim 2024',
        'imageUrl':
            'https://images.unsplash.com/photo-1542281286-9e0a16bb7366?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'category': 'MotoGP',
        'date': '2 hari yang lalu',
      },
      {
        'id': 'artikel-125',
        'title':
            'Jadwal Lengkap MotoGP 2024: Indonesia Kembali Masuk Kalender Balapan',
        'imageUrl':
            'https://images.unsplash.com/photo-1720958357699-df1a05ebe009?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'category': 'MotoGP',
        'date': '3 hari yang lalu',
      },
    ],
  };

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked ? 'Artikel disimpan' : 'Artikel dihapus dari simpanan',
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _articleData['likes']++;
      } else {
        _articleData['likes']--;
      }
    });
  }

  void _shareArticle() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Berbagi artikel...'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _toggleComments() {
    setState(() {
      _showComments = !_showComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: colorScheme.surface,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            elevation: 0,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'article-image-${widget.articleId}',
                    child: Image.network(
                      _articleData['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          size: 64,
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: colorScheme.surfaceContainerHighest,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                              color: colorScheme.primary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.5),
                          Colors.black.withValues(alpha: 0.8),
                        ],
                        stops: const [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _articleData['category'],
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _articleData['title'],
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                            letterSpacing: -0.5,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 12),
                        Row(
                          children: [
                            if (_articleData['isTrending']) ...[
                              const Icon(
                                Icons.trending_up_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Trending',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              _buildDot(),
                            ],
                            Text(
                              _articleData['publishedAt'],
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            _buildDot(),
                            Text(
                              '${_articleData['readTime']} baca',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _buildBlurredIconButton(
                icon: Icons.arrow_back_rounded,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _buildBlurredIconButton(
                  icon: _isBookmarked
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  onPressed: _toggleBookmark,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _buildBlurredIconButton(
                  icon: Icons.share_rounded,
                  onPressed: _shareArticle,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: colorScheme.primary,
                        backgroundImage: NetworkImage(
                          _articleData['author']['avatar'],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _articleData['author']['name'],
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              _articleData['author']['title'],
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: colorScheme.primaryContainer,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Ikuti',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List<Widget>.from(
                      _articleData['tags'].map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            tag,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _articleData['content'].split('\n').first,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _articleData['content'],
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.7,
                      color: colorScheme.onSurface.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _buildInteractionButton(
                            icon: _isLiked
                                ? Icons.thumb_up_alt
                                : Icons.thumb_up_alt_outlined,
                            label: _formatNumber(_articleData['likes']),
                            onPressed: _toggleLike,
                            isActive: _isLiked,
                          ),
                          const SizedBox(width: 16),
                          _buildInteractionButton(
                            icon: Icons.comment_outlined,
                            label: _formatNumber(_articleData['commentsCount']),
                            onPressed: _toggleComments,
                            isActive: _showComments,
                          ),
                        ],
                      ),
                      _buildInteractionButton(
                        icon: Icons.share_outlined,
                        label: 'Bagikan',
                        onPressed: _shareArticle,
                      ),
                    ],
                  ),
                  if (_showComments) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.3,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Komentar (${_articleData['commentsCount']})',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: const NetworkImage(
                                  'https://randomuser.me/api/portraits/men/55.jpg',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Tambahkan komentar...',
                                    hintStyle: TextStyle(
                                      color: colorScheme.onSurfaceVariant
                                          .withValues(alpha: 0.7),
                                    ),
                                    filled: true,
                                    fillColor: colorScheme.surface,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(24),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.send_rounded,
                                        color: colorScheme.primary,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  minLines: 1,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ...List.generate(
                            _articleData['comments'].length,
                            (index) => _buildCommentItem(
                              context,
                              _articleData['comments'][index],
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (_articleData['commentsCount'] >
                              _articleData['comments'].length)
                            Center(
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.comment_outlined,
                                  size: 16,
                                  color: colorScheme.primary,
                                ),
                                label: Text(
                                  'Lihat semua komentar',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 24),
                  Text(
                    'Artikel Terkait',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(
                    _articleData['relatedArticles'].length,
                    (index) => Column(
                      children: [
                        _buildRelatedArticleItem(
                          context,
                          title:
                              _articleData['relatedArticles'][index]['title'],
                          imageUrl:
                              _articleData['relatedArticles'][index]['imageUrl'],
                          category:
                              _articleData['relatedArticles'][index]['category'],
                          date: _articleData['relatedArticles'][index]['date'],
                        ),
                        if (index < _articleData['relatedArticles'].length - 1)
                          const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  Widget _buildBlurredIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDarkMode = brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.3),
            shape: BoxShape.circle,
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.1),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              icon,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 20,
            ),
            onPressed: onPressed,
            tooltip: icon == Icons.arrow_back_rounded
                ? 'Kembali'
                : icon == Icons.bookmark_rounded ||
                      icon == Icons.bookmark_border_rounded
                ? 'Simpan'
                : 'Bagikan',
          ),
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 4,
        height: 4,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedArticleItem(
    BuildContext context, {
    required String title,
    required String imageUrl,
    required String category,
    required String date,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.image_not_supported_rounded,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kategori
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        category,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentItem(BuildContext context, Map<String, dynamic> comment) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(comment['user']['avatar']),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment['user']['name'],
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      comment['timestamp'],
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment['content'],
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.thumb_up_outlined,
                              size: 14,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              comment['likes'].toString(),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        child: Text(
                          'Balas',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
