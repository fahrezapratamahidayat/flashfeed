import 'package:flashfeed/src/data/search_category.dart';
import 'package:flutter/material.dart';

class NewsCategoryTabs extends StatefulWidget {
  const NewsCategoryTabs({super.key});

  @override
  State<NewsCategoryTabs> createState() => _NewsCategoryTabsState();
}

class _NewsCategoryTabsState extends State<NewsCategoryTabs> {
  String? _selectedCategoryValue;

  @override
  void initState() {
    super.initState();
    if (searchcategory.isNotEmpty) {
      _selectedCategoryValue = searchcategory[0]['value'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: isDarkMode
            ? colorScheme.surface.withValues(alpha: 0.5)
            : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: searchcategory.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;
          final bool isSelected = category['value'] == _selectedCategoryValue;
          final bool isFirst = index == 0;
          final bool isLast = index == searchcategory.length - 1;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: isFirst ? 0 : 2,
                right: isLast ? 0 : 2,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOutCubic,
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: colorScheme.primary.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: isDarkMode ? 0.1 : 0.05,
                            ),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (!isSelected) {
                        setState(() {
                          _selectedCategoryValue = category['value'];
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(8),
                    splashColor: isSelected
                        ? colorScheme.onPrimary.withValues(alpha: 0.1)
                        : colorScheme.primary.withValues(alpha: 0.1),
                    highlightColor: isSelected
                        ? colorScheme.onPrimary.withValues(alpha: 0.05)
                        : colorScheme.primary.withValues(alpha: 0.05),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style:
                            theme.textTheme.labelMedium?.copyWith(
                              color: isSelected
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface.withValues(
                                      alpha: 0.7,
                                    ),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              fontSize: 13,
                              letterSpacing: 0.1,
                            ) ??
                            const TextStyle(),
                        child: Text(
                          category['label']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
