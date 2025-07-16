import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'المفضلة',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortOptions,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'الشركات المفضلة'),
            Tab(text: 'الطرق المفضلة'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF127C8A),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Color(0xFF127C8A)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'البحث في المفضلة...',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.filter_list,
                    color: Color(0xFF127C8A),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCompaniesList(),
                _buildRoutesList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompaniesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: Provider.of<FavoriteProvider>(context).favoriteCompanies.length,
      itemBuilder: (context, index) {
        return _buildCompanyCard(Provider.of<FavoriteProvider>(context).favoriteCompanies[index]);
      },
    );
  }

  Widget _buildRoutesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: Provider.of<FavoriteProvider>(context).favoriteRoutes.length,
      itemBuilder: (context, index) {
        return _buildRouteCard(Provider.of<FavoriteProvider>(context).favoriteRoutes[index]);
      },
    );
  }

  Widget _buildCompanyCard(FavoriteCompany company) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _getCompanyGradient(company.type),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  company.logo,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        company.rating.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Cairo',
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${company.routes} مسار',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Cairo',
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    Provider.of<FavoriteProvider>(context, listen: false).removeCompany(company);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('تمت إزالة ${company.name} من المفضلة'),
                        backgroundColor: const Color(0xFF127C8A),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 28,
                  ),
                ),
                TextButton(
                  onPressed: () => _bookWithCompany(company),
                  child: const Text(
                    'احجز الآن',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Color(0xFF127C8A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteCard(FavoriteRoute route) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getRouteColor(route.type).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getRouteIcon(route.type),
                    color: _getRouteColor(route.type),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${route.from} → ${route.to}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      Text(
                        '${route.duration} • ${route.frequency}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Cairo',
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${route.price.toStringAsFixed(0)} ل.س',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color(0xFF127C8A),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _toggleRouteFavorite(route),
                      icon: Icon(
                        route.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: route.isFavorite ? Colors.red : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _searchRoute(route),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF127C8A),
                      side: const BorderSide(color: Color(0xFF127C8A)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'البحث عن رحلات',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _bookRoute(route),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF127C8A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'احجز الآن',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              size: 60,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF6B7280),
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF9CA3AF),
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _getCompanyGradient(CompanyType type) {
    switch (type) {
      case CompanyType.bus:
        return [const Color(0xFF127C8A), const Color(0xFF0F5F6B)];
      case CompanyType.flight:
        return [const Color(0xFF10B981), const Color(0xFF059669)];
      case CompanyType.hotel:
        return [const Color(0xFFF59E0B), const Color(0xFFD97706)];
      case CompanyType.train:
        return [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)];
    }
  }

  Color _getRouteColor(RouteType type) {
    switch (type) {
      case RouteType.bus:
        return const Color(0xFF127C8A);
      case RouteType.flight:
        return const Color(0xFF10B981);
      case RouteType.hotel:
        return const Color(0xFFF59E0B);
      case RouteType.train:
        return const Color(0xFF8B5CF6);
    }
  }

  IconData _getRouteIcon(RouteType type) {
    switch (type) {
      case RouteType.bus:
        return Icons.directions_bus;
      case RouteType.flight:
        return Icons.flight;
      case RouteType.hotel:
        return Icons.hotel;
      case RouteType.train:
        return Icons.train;
    }
  }

  void _toggleCompanyFavorite(FavoriteCompany company) {
    Provider.of<FavoriteProvider>(context, listen: false).toggleCompanyFavorite(company);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          company.isFavorite 
            ? 'تمت إضافة ${company.name} إلى المفضلة'
            : 'تمت إزالة ${company.name} من المفضلة'
        ),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _toggleRouteFavorite(FavoriteRoute route) {
    Provider.of<FavoriteProvider>(context, listen: false).toggleRouteFavorite(route);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          route.isFavorite 
            ? 'تمت إضافة المسار إلى المفضلة'
            : 'تمت إزالة المسار من المفضلة'
        ),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _bookWithCompany(FavoriteCompany company) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري الانتقال إلى حجز ${company.name}...'),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _searchRoute(FavoriteRoute route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري البحث عن رحلات من ${route.from} إلى ${route.to}...'),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _bookRoute(FavoriteRoute route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري الانتقال إلى حجز الرحلة من ${route.from} إلى ${route.to}...'),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ترتيب المفضلة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('حسب التقييم', style: TextStyle(fontFamily: 'Cairo')),
              onTap: () {
                Navigator.pop(context);
                Provider.of<FavoriteProvider>(context, listen: false).sortByRating();
              },
            ),
            ListTile(
              leading: const Icon(Icons.sort_by_alpha),
              title: const Text('حسب الاسم', style: TextStyle(fontFamily: 'Cairo')),
              onTap: () {
                Navigator.pop(context);
                Provider.of<FavoriteProvider>(context, listen: false).sortByName();
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('حسب السعر', style: TextStyle(fontFamily: 'Cairo')),
              onTap: () {
                Navigator.pop(context);
                Provider.of<FavoriteProvider>(context, listen: false).sortByPrice();
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum CompanyType { bus, flight, hotel, train }
enum RouteType { bus, flight, hotel, train }

class FavoriteCompany {
  final String id;
  final String name;
  final String logo;
  final CompanyType type;
  final double rating;
  final int routes;
  bool isFavorite;

  FavoriteCompany({
    required this.id,
    required this.name,
    required this.logo,
    required this.type,
    required this.rating,
    required this.routes,
    required this.isFavorite,
  });
}

class FavoriteRoute {
  final String id;
  final String from;
  final String to;
  final RouteType type;
  final double price;
  final String duration;
  final String frequency;
  bool isFavorite;

  FavoriteRoute({
    required this.id,
    required this.from,
    required this.to,
    required this.type,
    required this.price,
    required this.duration,
    required this.frequency,
    required this.isFavorite,
  });
} 
