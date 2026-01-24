import 'package:flutter/material.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final isTablet = screenWidth > 600 && screenWidth <= 900;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Articles',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 40 : (isTablet ? 24 : 20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Search Bar
              _buildSearchBar(),
              const SizedBox(height: 24),
              
              // Popular Articles Section
              _buildPopularArticles(isDesktop, isTablet),
              const SizedBox(height: 32),
              
              // Trending Articles Section
              _buildTrendingArticles(isDesktop, isTablet),
              const SizedBox(height: 32),
              
              // Related Articles Section
              _buildRelatedArticles(isDesktop, isTablet),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search articles, news...',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[400],
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildPopularArticles(bool isDesktop, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Articles',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildCategoryChip('Covid-19'),
            _buildCategoryChip('Diet'),
            _buildCategoryChip('Fitness'),
            _buildCategoryChip('Mental Health'),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF26B5A8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTrendingArticles(bool isDesktop, bool isTablet) {
    final articles = [
      {
        'image': 'assets/article1.png',
        'category': 'Covid-19',
        'title': 'Comparing the AstraZeneca and Pfizer COVID-19 Vaccines',
        'date': 'Jun 12, 2021',
        'readTime': '6 min read',
        'color': const Color(0xFF26B5A8),
      },
      {
        'image': 'assets/article2.png',
        'category': 'Covid-19',
        'title': 'The Horror Of The Second Wave Of COVID-19',
        'date': 'Jun 10, 2021',
        'readTime': '5 min read',
        'color': const Color(0xFFFF9966),
      },
      {
        'image': 'assets/article3.png',
        'category': 'Covid-19',
        'title': 'Covid Appropriate Behaviour',
        'date': 'Jun 8, 2021',
        'readTime': '4 min read',
        'color': const Color(0xFF26B5A8),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Trending Articles',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See all',
                style: TextStyle(
                  color: Color(0xFF26B5A8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return _buildTrendingCard(articles[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingCard(Map<String, dynamic> article) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with bookmark
          Stack(
            children: [
              Container(
                height: 140,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      article['color'] as Color,
                      (article['color'] as Color).withOpacity(0.7),
                    ],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    article['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              article['color'] as Color,
                              (article['color'] as Color).withOpacity(0.7),
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.bookmark_outline,
                    size: 16,
                    color: Color(0xFF26B5A8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Category
          Text(
            article['category'] as String,
            style: const TextStyle(
              color: Color(0xFF26B5A8),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          // Title
          Text(
            article['title'] as String,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          // Date and read time
          Text(
            '${article['date']} • ${article['readTime']}',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedArticles(bool isDesktop, bool isTablet) {
    final articles = [
      {
        'image': 'assets/R1.png',
        'title': 'The 25 Healthiest Fruits You Can Eat, According to a Nutritionist',
        'date': 'Jun 10, 2021',
        'readTime': '5min read',
        'color': const Color(0xFF9C6BD9),
      },
      {
        'image': 'assets/R2.png',
        'title': 'Traditional Herbal Medicine Treatments for COVID-19',
        'date': 'Jun 9, 2021',
        'readTime': '8 min read',
        'color': const Color(0xFF4A5568),
      },
      {
        'image': 'assets/R3.png',
        'title': 'Beauty Tips For Face: 10 Dos and Don\'ts for Naturally Beautiful Skin',
        'date': 'Jun 8, 2021',
        'readTime': '6 min read',
        'color': const Color(0xFFD97C6B),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Related Articles',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See all',
                style: TextStyle(
                  color: Color(0xFF26B5A8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return _buildRelatedArticleCard(articles[index]);
          },
        ),
      ],
    );
  }

  Widget _buildRelatedArticleCard(Map<String, dynamic> article) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Thumbnail
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  article['color'] as Color,
                  (article['color'] as Color).withOpacity(0.7),
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                article['image'] as String,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          article['color'] as Color,
                          (article['color'] as Color).withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.image,
                      color: Colors.white,
                      size: 24,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title'] as String,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${article['date']} • ${article['readTime']}',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          // Bookmark icon
          Container(
            padding: const EdgeInsets.all(8),
            child: const Icon(
              Icons.bookmark,
              color: Color(0xFF26B5A8),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
