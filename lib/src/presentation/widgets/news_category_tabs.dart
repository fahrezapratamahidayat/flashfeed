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

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: searchcategory.map((category) {
          final bool isSelected = category['value'] == _selectedCategoryValue;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.onSecondaryContainer
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                  border: isSelected
                      ? Border.all(
                          color: colorScheme.onSecondaryContainer.withValues(
                            alpha: 0.1,
                          ),
                          width: 1,
                        )
                      : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCategoryValue = category['value'];
                      });
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      child: Text(
                        category['label']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: isSelected
                              ? colorScheme.surface
                              : colorScheme.onPrimary,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(), // <-- Jangan lupa .toList()
      ),
    );
  }
}
