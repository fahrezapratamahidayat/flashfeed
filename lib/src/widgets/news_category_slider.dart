import 'package:flashfeed/src/data/news_data.dart';
import 'package:flutter/material.dart';

class NewsCategorySlider extends StatefulWidget {
  final Function(String categoryLabel, String apiUrl) onCategorySelected;
  final String? initialSelectedValue;

  const NewsCategorySlider({
    super.key,
    required this.onCategorySelected,
    this.initialSelectedValue,
  });

  @override
  State<NewsCategorySlider> createState() => _NewsCategorySliderState();
}

class _NewsCategorySliderState extends State<NewsCategorySlider> {
  String? _selectedCategoryValue;

  @override
  void initState() {
    super.initState();
    if (newsCategories.isNotEmpty) {
      _selectedCategoryValue =
          widget.initialSelectedValue ?? newsCategories.first['value'];
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedCategoryValue != null && newsCategories.isNotEmpty) {
        if (mounted) {
          try {
            final initialCategory = newsCategories.firstWhere(
              (cat) => cat['value'] == _selectedCategoryValue,
            );
            widget.onCategorySelected(
              initialCategory['label']!,
              initialCategory['url']!,
            );
          } catch (e) {
            if (newsCategories.isNotEmpty && mounted) {
              final fallbackCategory = newsCategories.first;
              widget.onCategorySelected(
                fallbackCategory['label']!,
                fallbackCategory['url']!,
              );
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsCategories.length,
        itemBuilder: (context, index) {
          final category = newsCategories[index];
          final bool isSelected = category['value'] == _selectedCategoryValue;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).textTheme.bodyLarge?.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10.0,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedCategoryValue = category['value'];
                    });
                    widget.onCategorySelected(
                      category['label']!,
                      category['url']!,
                    );
                  },
                  child: Text(category['label']!),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  height: 3.0,
                  width: isSelected
                      ? (TextPainter(
                          text: TextSpan(
                            text: category['label']!,
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                        )..layout()).size.width
                      : 0,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                  margin: const EdgeInsets.only(top: 2.0), //
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
