import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<FavoriteCompany> _favoriteCompanies = [
    FavoriteCompany(
      id: '1',
      name: 'شركة الشام للنقل',
      logo: '🚌',
      type: CompanyType.bus,
      rating: 4.8,
      routes: 15,
      isFavorite: true,
    ),
    FavoriteCompany(
      id: '2',
      name: 'طيران الإمارات',
      logo: '✈️',
      type: CompanyType.flight,
      rating: 4.9,
      routes: 8,
      isFavorite: true,
    ),
    FavoriteCompany(
      id: '3',
      name: 'فندق الشام الفاخر',
      logo: '🏨',
      type: CompanyType.hotel,
      rating: 4.7,
      routes: 3,
      isFavorite: true,
    ),
  ];

  final List<FavoriteRoute> _favoriteRoutes = [
    FavoriteRoute(
      id: '1',
      from: 'دمشق',
      to: 'حلب',
      type: RouteType.bus,
      price: 1500,
      duration: '3 ساعات',
      frequency: 'كل ساعة',
      isFavorite: true,
    ),
    FavoriteRoute(
      id: '2',
      from: 'دمشق',
      to: 'دبي',
      type: RouteType.flight,
      price: 45000,
      duration: '2.5 ساعة',
      frequency: 'يومياً',
      isFavorite: true,
    ),
  ];

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
      appBar: AppBar(
        title: const Text(
          'المفضلة',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
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
              color: Color(0xFF1E3A8A),
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
                        const Icon(Icons.search, color: Color(0xFF1E3A8A)),
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
                    color: Color(0xFF1E3A8A),
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
    if (_favoriteCompanies.isEmpty) {
      return _buildEmptyState(
        icon: Icons.favorite_border,
        title: 'لا توجد شركات مفضلة',
        subtitle: 'أضف الشركات التي تفضلها لتسهيل الحجز',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _favoriteCompanies.length,
      itemBuilder: (context, index) {
        return _buildCompanyCard(_favoriteCompanies[index]);
      },
    );
  }

  Widget _buildRoutesList() {
    if (_favoriteRoutes.isEmpty) {
      return _buildEmptyState(
        icon: Icons.route,
        title: 'لا توجد طرق مفضلة',
        subtitle: 'أضف الطرق التي تسافر عليها بكثرة',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _favoriteRoutes.length,
      itemBuilder: (context, index) {
        return _buildRouteCard(_favoriteRoutes[index]);
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
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        _getCompanyIcon(company.type),
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getCompanyTypeText(company.type),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < company.rating.floor()
                                ? Icons.star
                                : Icons.star_border,
                            size: 16,
                            color: Colors.amber,
                          );
                        }),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        company.rating.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${company.routes} مسار',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontFamily: 'Cairo',
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
                  onPressed: () => _toggleCompanyFavorite(company),
                  icon: Icon(
                    company.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: company.isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _bookWithCompany(company),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('حجز'),
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
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _getRouteGradient(route.type),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getRouteIcon(route.type),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${route.from} → ${route.to}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${route.duration} • ${route.frequency}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontFamily: 'Cairo',
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
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                        fontFamily: 'Cairo',
                      ),
                    ),
                    IconButton(
                      onPressed: () => _toggleRouteFavorite(route),
                      icon: Icon(
                        route.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: route.isFavorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _viewRouteDetails(route),
                    icon: const Icon(Icons.info_outline),
                    label: const Text('التفاصيل'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1E3A8A),
                      side: const BorderSide(color: Color(0xFF1E3A8A)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _bookRoute(route),
                    icon: const Icon(Icons.confirmation_number),
                    label: const Text('حجز'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E3A8A),
                      foregroundColor: Colors.white,
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
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontFamily: 'Cairo',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getCompanyIcon(CompanyType type) {
    switch (type) {
      case CompanyType.bus:
        return Icons.directions_bus;
      case CompanyType.flight:
        return Icons.flight;
      case CompanyType.hotel:
        return Icons.hotel;
    }
  }

  String _getCompanyTypeText(CompanyType type) {
    switch (type) {
      case CompanyType.bus:
        return 'شركة نقل';
      case CompanyType.flight:
        return 'شركة طيران';
      case CompanyType.hotel:
        return 'فندق';
    }
  }

  List<Color> _getCompanyGradient(CompanyType type) {
    switch (type) {
      case CompanyType.bus:
        return [const Color(0xFF1E3A8A), const Color(0xFF3B82F6)];
      case CompanyType.flight:
        return [const Color(0xFF059669), const Color(0xFF10B981)];
      case CompanyType.hotel:
        return [const Color(0xFFDC2626), const Color(0xFFEF4444)];
    }
  }

  IconData _getRouteIcon(RouteType type) {
    switch (type) {
      case RouteType.bus:
        return Icons.directions_bus;
      case RouteType.flight:
        return Icons.flight;
    }
  }

  List<Color> _getRouteGradient(RouteType type) {
    switch (type) {
      case RouteType.bus:
        return [const Color(0xFF1E3A8A), const Color(0xFF3B82F6)];
      case RouteType.flight:
        return [const Color(0xFF059669), const Color(0xFF10B981)];
    }
  }

  void _toggleCompanyFavorite(FavoriteCompany company) {
    setState(() {
      company.isFavorite = !company.isFavorite;
    });
  }

  void _toggleRouteFavorite(FavoriteRoute route) {
    setState(() {
      route.isFavorite = !route.isFavorite;
    });
  }

  void _bookWithCompany(FavoriteCompany company) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري فتح صفحة حجز ${company.name}...'),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
    );
  }

  void _bookRoute(FavoriteRoute route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري حجز رحلة ${route.from} إلى ${route.to}...'),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
    );
  }

  void _viewRouteDetails(FavoriteRoute route) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تفاصيل المسار'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('من: ${route.from}'),
            Text('إلى: ${route.to}'),
            Text('المدة: ${route.duration}'),
            Text('التكرار: ${route.frequency}'),
            Text('السعر: ${route.price.toStringAsFixed(0)} ل.س'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
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
              leading: const Icon(Icons.sort_by_alpha),
              title: const Text('ترتيب أبجدي'),
              onTap: () {
                Navigator.pop(context);
                // تطبيق الترتيب الأبجدي
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('ترتيب حسب التقييم'),
              onTap: () {
                Navigator.pop(context);
                // تطبيق الترتيب حسب التقييم
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('ترتيب حسب السعر'),
              onTap: () {
                Navigator.pop(context);
                // تطبيق الترتيب حسب السعر
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum CompanyType { bus, flight, hotel }
enum RouteType { bus, flight }

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
