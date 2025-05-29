import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/data/models/article.dart';
import 'package:flashfeed/src/presentation/widgets/app_text.dart';
import 'package:flashfeed/src/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsListItem extends StatelessWidget {
  final NewsArticle article;

  const NewsListItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    const double imageHeight = 150.0;
    const double imageWidth = 150.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.articleDetail,
            arguments: article.title,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: imageWidth,
                height: imageHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(
                    article.image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, exception, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.broken_image_outlined,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Spacing.horizontal(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppText(text: 'Sports', color: Colors.grey),
                    Spacing.vertical(Spacing.sm),
                    AppText(
                      text: article.title,
                      variant: AppTextVariant.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacing.vertical(Spacing.sm),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?semt=ais_hybrid&w=740',
                          ),
                        ),
                        Spacing.horizontal(10),
                        AppText(text: 'Fahreza', variant: AppTextVariant.small),
                        Spacing.horizontal(10),
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Spacing.horizontal(10),
                        AppText(
                          text: DateFormat(
                            'dd MMM yyyy',
                            'id_ID',
                          ).format(article.isoDate),
                          variant: AppTextVariant.small,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example NewsArticle model (ensure your actual model matches)
// class NewsArticle {
//   final String? title;
//   final String? description;
//   final String image; // Assuming image is non-nullable based on original code
//   final String? url;
//   final String? sourceName;

//   NewsArticle({
//     required this.title,
//     this.description,
//     required this.image,
//     required this.url,
//     this.sourceName,
//   });
// }
