import 'package:flutter/material.dart';
import '/models/article.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';
import '/widgets/custom_app_bar.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;
  const main;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Health Article',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: Styles.headingStyle,
            ),
            const SizedBox(height: 8),
            Text(
              'By ${article.author} • ${article.date}',
              style: Styles.captionStyle,
            ),
            const SizedBox(height: 16),
            Text(
              article.content,
              style: Styles.bodyStyle,
            ),
            const SizedBox(height: 16),
            if (article.tags.isNotEmpty) ...[
              Text(
                'Tags',
                style: Styles.subheadingStyle,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: article.tags
                    .map((tag) => Chip(
                  label: Text(
                    tag,
                    style: Styles.captionStyle,
                  ),
                  backgroundColor: AppConstants.lightGray,
                ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}