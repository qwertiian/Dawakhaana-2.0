import 'package:flutter/material.dart';
import '/models/article.dart';
import '/models/condition.dart';
import '/models/symptom.dart';
import '/services/api_service.dart';
import '/utils/constants.dart';
import '/utils/styles.dart';
import '/widgets/custom_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Symptom>> _symptomsFuture;
  late Future<List<Condition>> _conditionsFuture;
  late Future<List<Article>> _articlesFuture;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _symptomsFuture = _apiService.getSymptoms();
    _conditionsFuture = _apiService.getConditions();
    _articlesFuture = _apiService.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Search',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    labelColor: AppConstants.primaryColor,
                    unselectedLabelColor: AppConstants.darkGray,
                    indicatorColor: AppConstants.primaryColor,
                    tabs: [
                      Tab(text: 'Symptoms'),
                      Tab(text: 'Conditions'),
                      Tab(text: 'Articles'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildSymptomsTab(),
                        _buildConditionsTab(),
                        _buildArticlesTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsTab() {
    return FutureBuilder<List<Symptom>>(
      future: _symptomsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No symptoms found'));
        } else {
          final filteredSymptoms = snapshot.data!
              .where((symptom) =>
          symptom.name.toLowerCase().contains(_searchQuery) ||
              symptom.category.toLowerCase().contains(_searchQuery))
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredSymptoms.length,
            itemBuilder: (context, index) {
              final symptom = filteredSymptoms[index];
              return ListTile(
                title: Text(symptom.name),
                subtitle: Text(symptom.category),
                trailing: Chip(
                  label: Text(
                    symptom.severity,
                    style: Styles.captionStyle.copyWith(color: Colors.white),
                  ),
                  backgroundColor: _getSeverityColor(symptom.severity),
                ),
                onTap: () {
                  // Navigate to symptom detail
                },
              );
            },
          );
        }
      },
    );
  }

  Widget _buildConditionsTab() {
    return FutureBuilder<List<Condition>>(
      future: _conditionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No conditions found'));
        } else {
          final filteredConditions = snapshot.data!
              .where((condition) =>
          condition.name.toLowerCase().contains(_searchQuery) ||
              condition.category.toLowerCase().contains(_searchQuery))
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredConditions.length,
            itemBuilder: (context, index) {
              final condition = filteredConditions[index];
              return ListTile(
                title: Text(condition.name),
                subtitle: Text(condition.category),
                trailing: Chip(
                  label: Text(
                    condition.prevalence,
                    style: Styles.captionStyle.copyWith(color: Colors.white),
                  ),
                  backgroundColor: AppConstants.accentColor,
                ),
                onTap: () {
                  // Navigate to condition detail
                },
              );
            },
          );
        }
      },
    );
  }

  Widget _buildArticlesTab() {
    return FutureBuilder<List<Article>>(
      future: _articlesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No articles found'));
        } else {
          final filteredArticles = snapshot.data!
              .where((article) =>
          article.title.toLowerCase().contains(_searchQuery) ||
              article.author.toLowerCase().contains(_searchQuery) ||
              article.tags.any((tag) => tag.toLowerCase().contains(_searchQuery)))
              .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredArticles.length,
            itemBuilder: (context, index) {
              final article = filteredArticles[index];
              return ListTile(
                title: Text(article.title),
                subtitle: Text('By ${article.author} • ${article.date}'),
                onTap: () {
                  // Navigate to article detail
                },
              );
            },
          );
        }
      },
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return AppConstants.darkGray;
    }
  }
}