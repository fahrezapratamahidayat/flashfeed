import 'package:flashfeed/src/presentation/widgets/news_category_tabs.dart';
import 'package:flashfeed/src/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearchChanged(String query) {}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? colorScheme.surfaceContainerHighest.withValues(
                              alpha: 0.5,
                            )
                          : colorScheme.surfaceContainerHighest.withValues(
                              alpha: 0.3,
                            ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: colorScheme.onSurfaceVariant,
                        size: 22,
                      ),
                      tooltip: 'Kembali',
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? colorScheme.surfaceContainerHighest.withValues(
                                alpha: 0.3,
                              )
                            : colorScheme.surfaceContainerHighest.withValues(
                                alpha: 0.2,
                              ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorScheme.outline.withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: AppTextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        placeholder: "Cari Artikel",
                        variant: TextFieldVariant.filled,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 4),
                          child: Icon(
                            Icons.search_rounded,
                            size: 20,
                            color: colorScheme.onSurfaceVariant.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  _onSearchChanged('');
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.7),
                                  size: 18,
                                ),
                                splashRadius: 16,
                                tooltip: 'Hapus',
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12, left: 4),
                child: Text(
                  'Kategori',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              const NewsCategoryTabs(),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16, left: 4),
                child: Text(
                  'Hasil Pencarian',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 64,
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Masukkan kata kunci untuk mencari artikel',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.7,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
