import 'package:flashfeed/src/presentation/widgets/news_category_slider.dart';
import 'package:flashfeed/src/presentation/widgets/news_list_view.dart';
import 'package:flutter/material.dart';

class HomeTabContent extends StatefulWidget {
  const HomeTabContent({super.key});

  @override
  State<HomeTabContent> createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<HomeTabContent> {
  String _selectedApiUrl = '';

  final List<Map<String, String>> newsCategories = [
    {
      'label': 'Terkini',
      'value': 'terkini',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/terkini',
    },
    {
      'label': 'Top News',
      'value': 'top-news',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/top-news',
    },
    {
      'label': 'Politik',
      'value': 'politik',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/politik',
    },
    {
      'label': 'Hukum',
      'value': 'hukum',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/hukum',
    },
    {
      'label': 'Ekonomi',
      'value': 'ekonomi',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/ekonomi',
    },
    {
      'label': 'Metro',
      'value': 'metro',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/metro',
    },
    {
      'label': 'Sepak Bola',
      'value': 'sepakbola',
      'url':
          'https://berita-indo-api-next.vercel.app/api/antara-news/sepakbola',
    },
    {
      'label': 'Olahraga',
      'value': 'olahraga',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/olahraga',
    },
    {
      'label': 'Hiburan',
      'value': 'hiburan',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/hiburan',
    },
    {
      'label': 'Teknologi',
      'value': 'teknologi',
      'url':
          'https://berita-indo-api-next.vercel.app/api/antara-news/teknologi',
    },
    {
      'label': 'Gaya Hidup',
      'value': 'lifestyle',
      'url':
          'https://berita-indo-api-next.vercel.app/api/antara-news/lifestyle',
    },
  ];

  @override
  void initState() {
    super.initState();
    if (newsCategories.isNotEmpty) {
      _selectedApiUrl = newsCategories.first['url']!;
    }
  }

  void _onCategoryChanged(String categoryLabel, String apiUrl) {
    setState(() {
      _selectedApiUrl = apiUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            NewsCategorySlider(
              initialSelectedValue: newsCategories.isNotEmpty
                  ? newsCategories.first['value']
                  : null,
              onCategorySelected: _onCategoryChanged,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: NewsListView(apiUrl: _selectedApiUrl),
            ),
          ],
        ),
      ),
    );
  }
}
