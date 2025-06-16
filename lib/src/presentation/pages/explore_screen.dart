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
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: theme.cardColor.withValues(
                            alpha: isDarkMode ? 0.1 : 0.05,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.dividerColor.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: AppTextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          placeholder: "Search Articless",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 0),
                            child: Icon(
                              Icons.search,
                              size: 20,
                              color: theme.iconTheme.color
                                ?..withValues(alpha: 0.6),
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
                                    Icons.clear,
                                    color: theme.iconTheme.color
                                      ?..withValues(alpha: 0.6),
                                    size: 18,
                                  ),
                                  splashRadius: 16,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              NewsCategoryTabs(),
            ],
          ),
        ),
      ),
    );
  }
}
