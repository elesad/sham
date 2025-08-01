import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorites_provider.dart';
import 'bus_seat_selection.dart';

class BusCompany {
  final String id;
  final String name;
  final String logo;
  final double rating;
  final int price;
  final String time;
  final String description;
  final String features;

  BusCompany({
    required this.id,
    required this.name,
    required this.logo,
    required this.rating,
    required this.price,
    required this.time,
    required this.description,
    required this.features,
  });
}

final List<BusCompany> busCompanies = [
  BusCompany(
    id: '1',
    name: 'شركة النور للنقل',
    logo: '🚌',
    rating: 4.7,
    price: 25000,
    time: '08:00',
    description: 'خدمة نقل مريحة وآمنة',
    features: 'مكيف • WiFi • مقاعد مريحة',
  ),
  BusCompany(
    id: '2',
    name: 'شركة البركة للنقل',
    logo: '🚍',
    rating: 4.5,
    price: 26000,
    time: '09:30',
    description: 'رحلات يومية منتظمة',
    features: 'مكيف • خدمة مشروبات • مقاعد فاخرة',
  ),
  BusCompany(
    id: '3',
    name: 'شركة الهدى للنقل',
    logo: '🚌',
    rating: 4.3,
    price: 24000,
    time: '11:00',
    description: 'أسعار منافسة وجودة عالية',
    features: 'مكيف • مقاعد عريضة • خدمة عملاء',
  ),
  BusCompany(
    id: '4',
    name: 'شركة الشام للنقل',
    logo: '🚍',
    rating: 4.6,
    price: 25500,
    time: '12:30',
    description: 'خبرة أكثر من 20 عام',
    features: 'مكيف • WiFi • مقاعد مريحة • خدمة مشروبات',
  ),
  BusCompany(
    id: '5',
    name: 'شركة الفرات للنقل',
    logo: '🚌',
    rating: 4.2,
    price: 24500,
    time: '14:00',
    description: 'رحلات سريعة ومريحة',
    features: 'مكيف • مقاعد عريضة',
  ),
  BusCompany(
    id: '6',
    name: 'شركة الشرق للنقل',
    logo: '🚍',
    rating: 4.4,
    price: 25000,
    time: '15:30',
    description: 'خدمة نقل حديثة ومتطورة',
    features: 'مكيف • WiFi • مقاعد فاخرة • خدمة مشروبات',
  ),
  BusCompany(
    id: '7',
    name: 'شركة الكوثر للنقل',
    logo: '🚌',
    rating: 4.1,
    price: 23500,
    time: '17:00',
    description: 'أسعار اقتصادية وجودة ممتازة',
    features: 'مكيف • مقاعد مريحة',
  ),
  BusCompany(
    id: '8',
    name: 'شركة الريان للنقل',
    logo: '🚍',
    rating: 4.0,
    price: 23000,
    time: '18:30',
    description: 'رحلات مسائية مريحة',
    features: 'مكيف • مقاعد عريضة • خدمة عملاء',
  ),
];

class BusCompanySelectionScreen extends StatefulWidget {
  final String fromCity;
  final String toCity;
  final DateTime date;

  const BusCompanySelectionScreen({
    super.key,
    required this.fromCity,
    required this.toCity,
    required this.date,
  });

  @override
  State<BusCompanySelectionScreen> createState() => _BusCompanySelectionScreenState();
}

class _BusCompanySelectionScreenState extends State<BusCompanySelectionScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String sortBy = 'time'; // 'time', 'price', 'rating'

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    
    // تحميل المفضلة عند فتح الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesProvider>().loadFavorites();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<BusCompany> get sortedCompanies {
    List<BusCompany> sorted = List.from(busCompanies);
    switch (sortBy) {
      case 'time':
        sorted.sort((a, b) => a.time.compareTo(b.time));
        break;
      case 'price':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'rating':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    return sorted;
  }

  void _toggleFavorite(BusCompany company, BuildContext context) {
    final favoritesProvider = context.read<FavoritesProvider>();
    final isFavorite = favoritesProvider.isFavorite(company.id);
    
    if (isFavorite) {
      // إزالة من المفضلة
      favoritesProvider.removeFromFavorites(company.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إزالة ${company.name} من المفضلة'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          action: SnackBarAction(
            label: 'تراجع',
            textColor: Colors.white,
            onPressed: () {
              // إعادة إضافة إلى المفضلة
              final favoriteItem = FavoriteItem(
                id: company.id,
                name: company.name,
                type: 'bus',
                fromLocation: widget.fromCity,
                toLocation: widget.toCity,
                date: '${widget.date.day}/${widget.date.month}/${widget.date.year}',
                price: '${company.price} ل.س',
                time: company.time,
                description: company.description,
                features: company.features,
                addedAt: DateTime.now(),
              );
              favoritesProvider.addToFavorites(favoriteItem);
            },
          ),
        ),
      );
    } else {
      // إضافة إلى المفضلة
      final favoriteItem = FavoriteItem(
        id: company.id,
        name: company.name,
        type: 'bus',
        fromLocation: widget.fromCity,
        toLocation: widget.toCity,
        date: '${widget.date.day}/${widget.date.month}/${widget.date.year}',
        price: '${company.price} ل.س',
        time: company.time,
        description: company.description,
        features: company.features,
        addedAt: DateTime.now(),
      );
      favoritesProvider.addToFavorites(favoriteItem);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إضافة ${company.name} إلى المفضلة'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          action: SnackBarAction(
            label: 'تراجع',
            textColor: Colors.white,
            onPressed: () {
              favoritesProvider.removeFromFavorites(company.id);
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            // Custom App Bar
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              backgroundColor: const Color(0xFF1E3A8A),
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'شركات الباصات',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                Consumer<FavoritesProvider>(
                  builder: (context, favoritesProvider, child) {
                    final busFavoritesCount = favoritesProvider.getFavoritesCountByType('bus');
                    return Stack(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.white),
                          onPressed: () {
                            // يمكن إضافة شاشة عرض المفضلة هنا
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('لديك $busFavoritesCount عنصر في المفضلة'),
                                backgroundColor: Colors.pink[400],
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          },
                        ),
                        if (busFavoritesCount > 0)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '$busFavoritesCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),

            // Trip Info Card
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1E3A8A).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
          children: [
            Container(
                                    padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                                        const Text(
                                          'من',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          widget.fromCity,
                                          style: const TextStyle(
                                            fontFamily: 'Cairo',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'إلى',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          widget.toCity,
                                          style: const TextStyle(
                                            fontFamily: 'Cairo',
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                      '${widget.date.day}/${widget.date.month}/${widget.date.year}',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
                  ],
                ),
              ),
            ),

            // Sort Options
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ترتيب حسب',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildSortOption('الوقت', 'time', Icons.access_time),
                        const SizedBox(width: 8),
                        _buildSortOption('السعر', 'price', Icons.attach_money),
                        const SizedBox(width: 8),
                        _buildSortOption('التقييم', 'rating', Icons.star),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Companies List
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final company = sortedCompanies[index];
                    return Consumer<FavoritesProvider>(
                      builder: (context, favoritesProvider, child) {
                        final isFavorite = favoritesProvider.isFavorite(company.id);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusSeatSelectionScreen(
                            company: company,
                            fromCity: widget.fromCity,
                            toCity: widget.toCity,
                            date: widget.date,
                          ),
                        ),
                      );
                    },
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        // Company Logo
                                        Container(
                                          width: 60,
                                          height: 60,
                      decoration: BoxDecoration(
                                            color: const Color(0xFF1E3A8A).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                            child: Text(
                                              company.logo,
                                              style: const TextStyle(fontSize: 30),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        
                                        // Company Info
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                company.name,
                                                style: const TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Color(0xFF1F2937),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                company.description,
                                                style: const TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                company.features,
                                                style: const TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 12,
                                                  color: Color(0xFF1E3A8A),
                                                  fontWeight: FontWeight.w500,
                                                ),
                          ),
                        ],
                      ),
                                        ),
                                        
                                        // Favorite Button
                                IconButton(
                                  icon: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : Colors.grey,
                                            size: 28,
                                          ),
                                          onPressed: () => _toggleFavorite(company, context),
                                ),
                              ],
                            ),
                                    
                                    const SizedBox(height: 16),
                                    
                                    // Trip Details
                                    Row(
                                      children: [
                                        // Time
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF1E3A8A).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.access_time,
                                                  size: 16,
                                                  color: Color(0xFF1E3A8A),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  company.time,
                                                  style: const TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF1E3A8A),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        
                                        const SizedBox(width: 12),
                                        
                                        // Rating
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.orange.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Colors.orange,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  company.rating.toString(),
                                                  style: const TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        
                                        const SizedBox(width: 12),
                                        
                                        // Price
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: Colors.green.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                                const Icon(
                                                  Icons.attach_money,
                                                  size: 16,
                                                  color: Colors.green,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  '${company.price}',
                                                  style: const TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                          ),
                        );
                      },
                  );
                },
                  childCount: sortedCompanies.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String label, String value, IconData icon) {
    final isSelected = sortBy == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            sortBy = value;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey[300]!,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 