import 'package:flutter/material.dart';

import 'article_model.dart';
import 'artcile_expand.dart';

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

  void _openArticle(Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleExpandPage(article: article),
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
      const Article(
        image: 'assets/article1.png',
        category: 'Covid-19',
        title: 'Comparing the AstraZeneca and Pfizer COVID-19 Vaccines',
        date: 'Jun 12, 2021',
        readTime: '6 min read',
        content:
            'This article breaks down how the two vaccines were developed, how they perform against variants, and what side effects are commonly reported. It also covers who should prioritize each option based on local availability and health guidance.\n\n'
            'Both vaccines were developed using rigorous clinical research and continue to be monitored as new variants emerge, with studies showing they provide strong protection against severe illness and hospitalization. While mild side effects such as fever, fatigue, or soreness at the injection site are commonly reported, these typically resolve within a few days and indicate an active immune response. Choosing between the options often depends on factors such as availability, age eligibility, existing health conditions and guidance from local health authorities, making it important to follow recommendations provided by healthcare professionals.'
      ),
      const Article(
        image: 'assets/article2.png',
        category: 'Covid-19',
        title: 'The Horror Of The Second Wave Of COVID-19',
        date: 'Jun 10, 2021',
        readTime: '5 min read',
        content:
            'A look back at the second wave, how health systems became overwhelmed, and which public health practices helped reduce the spread. The article highlights community actions that were most effective and what to prepare for in future surges.\n\n'
            'The second wave placed immense pressure on healthcare infrastructure, exposing gaps in hospital capacity, oxygen supply and workforce readiness. However, widespread mask usage, improved testing and tracing, vaccination drives and community led support systems played a critical role in slowing transmission and protecting vulnerable populations. These experiences underline the importance of early preparedness, transparent communication and collective responsibility to better manage and respond to potential future surges.'
      ),
      const Article(
        image: 'assets/article3.png',
        category: 'Covid-19',
        title: 'Covid Appropriate Behaviour',
        date: 'Jun 8, 2021',
        readTime: '4 min read',
        content:
            'Practical guidance on masking, distancing, and ventilation in everyday life. The piece focuses on small habits that add up to big protection, especially in crowded or indoor settings.\n\n'
            'Consistent use of well-fitted masks, maintaining appropriate physical distance, and ensuring proper airflow indoors significantly reduce the risk of airborne transmission. Simple actions such as opening windows, avoiding overcrowded spaces, and being mindful of time spent indoors can greatly improve safety. When practiced together, these small but deliberate habits create multiple layers of protection, helping individuals and communities stay safer in everyday situations.'
      ),
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

  Widget _buildTrendingCard(Article article) {
    return InkWell(
      onTap: () => _openArticle(article),
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF26B5A8),
                        Color(0x8026B5A8),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      article.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF26B5A8),
                                Color(0x8026B5A8),
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
              article.category,
              style: const TextStyle(
                color: Color(0xFF26B5A8),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            // Title
            Text(
              article.title,
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
              '${article.date} • ${article.readTime}',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedArticles(bool isDesktop, bool isTablet) {
    final articles = [
      const Article(
        image: 'assets/R1.png',
        category: 'Nutrition',
        title:
            'The 25 Healthiest Fruits You Can Eat, According to a Nutritionist',
        date: 'Jun 10, 2021',
        readTime: '5 min read',
        content:
            'A quick guide to nutrient-dense fruits, including why they are beneficial and simple ways to add them to meals. The list highlights fiber, vitamin, and antioxidant content with easy serving ideas.\n\n'
            'Fruits that are rich in nutrients provide essential vitamins, minerals and antioxidants that support overall health and daily energy needs. Options such as berries, oranges, apples and bananas are well known for their high fiber content, which aids digestion and helps maintain steady blood sugar levels. Including a variety of colorful fruits ensures a broader range of nutrients, supporting immunity, heart health and skin vitality.\n\n'

'Adding nutrient dense fruits to meals does not require complicated preparation. They can be easily blended into smoothies, mixed into breakfast bowls, or enjoyed as a natural snack between meals. Fruits also pair well with salads, yogurt and desserts, enhancing flavor while boosting nutritional value. By making fruits a regular part of everyday meals, it becomes easier to meet dietary needs in a simple and enjoyable way.'
      ),
      const Article(
        image: 'assets/R2.png',
        category: 'Wellness',
        title: 'Traditional Herbal Medicine Treatments for COVID-19',
        date: 'Jun 9, 2021',
        readTime: '8 min read',
        content:
            'This article reviews common herbal remedies used across cultures and explains what is known about their safety. It also stresses when to consult a clinician and how to avoid unsafe interactions.\n\n'
            'Many herbal remedies have been used for generations to support wellness, relieve minor ailments and promote overall balance in the body. Ingredients such as ginger, turmeric, chamomile and tulsi are commonly valued for their soothing and anti-inflammatory properties. While these remedies can be helpful, their effects may vary depending on dosage, preparation and individual health conditions, making informed use especially important.\n\n'

'Despite their natural origin, herbal remedies are not always risk-free. Some herbs can interact with prescription medications, worsen existing conditions, or cause side effects when taken incorrectly. Pregnant individuals, older adults, and people with chronic illnesses should be particularly cautious. Consulting a qualified healthcare professional before starting any herbal treatment helps ensure safety and allows traditional remedies to complement modern medical care effectively.'
      ),
      const Article(
        image: 'assets/R3.png',
        category: 'Skin Care',
        title:
            'Beauty Tips For Face: 10 Dos and Don\'ts for Naturally Beautiful Skin',
        date: 'Jun 8, 2021',
        readTime: '6 min read',
        content:
            'A balanced routine matters more than fancy products. This article outlines gentle cleansing, hydration, and sun protection habits along with common mistakes that can irritate skin.\n\n'
            'A consistent skincare routine starts with understanding your skin type and keeping things simple. Using a mild cleanser twice a day helps remove dirt, oil and pollutants without stripping the skin’s natural barrier. Hydration is equally important applying a suitable moisturizer locks in moisture, supports skin repair and keeps the skin soft and resilient. Sunscreen should be a daily habit, even on cloudy days, as regular sun exposure is one of the leading causes of premature aging and uneven skin tone.'
      ),
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

  Widget _buildRelatedArticleCard(Article article) {
    return InkWell(
      onTap: () => _openArticle(article),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF26B5A8),
                    Color(0x8026B5A8),
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  article.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF26B5A8),
                            Color(0x8026B5A8),
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
                    article.title,
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
                    '${article.date} • ${article.readTime}',
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
      ),
    );
  }
}
