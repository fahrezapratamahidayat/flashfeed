import 'package:flutter/material.dart';
import 'package:flashfeed/src/widgets/app_text.dart';
import 'package:flashfeed/src/widgets/spacing.dart';
import 'package:flashfeed/src/core/services/news_service.dart';
import 'package:flashfeed/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class CreateNewsScreen extends StatefulWidget {
  const CreateNewsScreen({super.key});

  @override
  State<CreateNewsScreen> createState() => _CreateNewsScreenState();
}

class _CreateNewsScreenState extends State<CreateNewsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController(
    text:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
  );
  final _readTimeController = TextEditingController(text: '5 menit');
  final _imageUrlController = TextEditingController(
    text:
        "https://plus.unsplash.com/premium_photo-1749735100764-c6d8aab144af?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  );
  String _selectedCategory = 'Teknologi';
  final List<String> _selectedTags = [];
  final _tagController = TextEditingController();
  bool _isTrending = false;
  bool _isLoading = false;
  bool _isImageUrlValid = false;

  final NewsService _newsService = NewsService();

  final List<String> _categories = [
    'Teknologi',
    'Bisnis',
    'Kesehatan',
    'Olahraga',
    'Hiburan',
    'Politik',
    'MotoGP',
    'Lingkungan',
    'Kuliner',
    'Fashion',
    'Sains',
    'Pendidikan',
    'Gaming',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _readTimeController.dispose();
    _imageUrlController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  void _checkImageUrl(String url) {
    if (url.isEmpty) {
      setState(() {
        _isImageUrlValid = false;
      });
      return;
    }

    setState(() {
      _isImageUrlValid = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: Text(
          'Buat Artikel Baru',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close, color: colorScheme.onSurface),
          onPressed: () => _showExitConfirmation(),
          tooltip: 'Tutup',
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _submitForm,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Publikasikan'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul Artikel
                    AppText(
                      text: 'Judul Artikel',
                      variant: AppTextVariant.titleSmall,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacing.vertical(Spacing.sm),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan judul artikel',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerLow,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Judul artikel tidak boleh kosong';
                        }
                        return null;
                      },
                      maxLength: 100,
                      maxLines: 2,
                    ),
                    Spacing.vertical(Spacing.md),
                    AppText(
                      text: 'URL Gambar',
                      variant: AppTextVariant.titleSmall,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacing.vertical(Spacing.sm),
                    TextFormField(
                      controller: _imageUrlController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan URL gambar',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerLow,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.check_circle_outline),
                          onPressed: () =>
                              _checkImageUrl(_imageUrlController.text),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'URL gambar tidak boleh kosong';
                        }
                        if (!Uri.tryParse(value)!.hasAbsolutePath) {
                          return 'URL gambar tidak valid';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _checkImageUrl(value);
                        }
                      },
                    ),
                    Spacing.vertical(Spacing.sm),
                    if (_imageUrlController.text.isNotEmpty && _isImageUrlValid)
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorScheme.outlineVariant,
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.broken_image_outlined,
                                      size: 48,
                                      color: colorScheme.error,
                                    ),
                                    Spacing.vertical(Spacing.sm),
                                    Text(
                                      'Gambar tidak dapat dimuat',
                                      style: TextStyle(
                                        color: colorScheme.error,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    Spacing.vertical(Spacing.md),
                    AppText(
                      text: 'Kategori',
                      variant: AppTextVariant.titleSmall,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacing.vertical(Spacing.sm),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerLow,
                      ),
                      items: _categories
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                    Spacing.vertical(Spacing.md),
                    AppText(
                      text: 'Waktu Baca',
                      variant: AppTextVariant.titleSmall,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacing.vertical(Spacing.sm),
                    TextFormField(
                      controller: _readTimeController,
                      decoration: InputDecoration(
                        hintText: 'Contoh: 5 menit',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerLow,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Waktu baca tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    Spacing.vertical(Spacing.md),
                    AppText(
                      text: 'Tags',
                      variant: AppTextVariant.titleSmall,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacing.vertical(Spacing.sm),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedTags
                          .map(
                            (tag) => Chip(
                              label: Text(tag),
                              deleteIcon: const Icon(Icons.close, size: 16),
                              onDeleted: () {
                                setState(() {
                                  _selectedTags.remove(tag);
                                });
                              },
                              backgroundColor: colorScheme.primaryContainer,
                              labelStyle: TextStyle(
                                color: colorScheme.onPrimaryContainer,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Spacing.vertical(Spacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _tagController,
                            decoration: InputDecoration(
                              hintText: 'Tambahkan tag',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: colorScheme.surfaceContainerLow,
                            ),
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty &&
                                  !_selectedTags.contains(value)) {
                                setState(() {
                                  _selectedTags.add(value);
                                  _tagController.clear();
                                });
                              }
                            },
                          ),
                        ),
                        Spacing.horizontal(Spacing.sm),
                        IconButton(
                          onPressed: () {
                            if (_tagController.text.isNotEmpty &&
                                !_selectedTags.contains(_tagController.text)) {
                              setState(() {
                                _selectedTags.add(_tagController.text);
                                _tagController.clear();
                              });
                            }
                          },
                          icon: Icon(
                            Icons.add_circle,
                            color: colorScheme.primary,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: colorScheme.primaryContainer,
                          ),
                        ),
                      ],
                    ),
                    Spacing.vertical(Spacing.md),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorScheme.outlineVariant,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Switch(
                            value: _isTrending,
                            onChanged: (value) {
                              setState(() {
                                _isTrending = value;
                              });
                            },
                            activeColor: colorScheme.primary,
                          ),
                          Spacing.horizontal(Spacing.sm),
                          const Expanded(
                            child: AppText(
                              text: 'Jadikan artikel trending',
                              variant: AppTextVariant.bodyLarge,
                            ),
                          ),
                          if (_isTrending)
                            Icon(Icons.trending_up, color: colorScheme.primary),
                        ],
                      ),
                    ),
                    Spacing.vertical(Spacing.md),
                    AppText(
                      text: 'Konten Artikel',
                      variant: AppTextVariant.titleSmall,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacing.vertical(Spacing.sm),
                    TextFormField(
                      controller: _contentController,
                      decoration: InputDecoration(
                        hintText: 'Tulis konten artikel disini...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerLow,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konten artikel tidak boleh kosong';
                        }
                        return null;
                      },
                      maxLines: 10,
                      minLines: 5,
                    ),
                    Spacing.vertical(Spacing.lg),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.publish),
                        label: const Text(
                          'Publikasikan Artikel',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Spacing.vertical(Spacing.lg),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedTags.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap tambahkan minimal 1 tag'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (!authProvider.isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda harus login untuk membuat artikel'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final articleData = {
        'title': _titleController.text,
        'category': _selectedCategory,
        'readTime': _readTimeController.text,
        'imageUrl': _imageUrlController.text,
        'isTrending': _isTrending,
        'tags': _selectedTags,
        'content': _contentController.text,
      };

      final success = await _newsService.createArticle(articleData);

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Artikel berhasil dipublikasikan'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal mempublikasikan artikel'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst("Exception: ", "")),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showExitConfirmation() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Batalkan Pembuatan Artikel?'),
        content: const Text(
          'Semua perubahan yang belum disimpan akan hilang. Apakah Anda yakin?',
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Lanjutkan Edit',
              style: TextStyle(color: colorScheme.primary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
            ),
            child: const Text('Batalkan'),
          ),
        ],
      ),
    );
  }
}
