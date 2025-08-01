import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorites_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  String searchQuery = '';
  String selectedFilter = 'الكل';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'المفضلة',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: isDark ? const Color(0xFF2D2D2D) : const Color(0xFF127C8A),
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
          // شريط البحث والفلترة
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D2D2D) : const Color(0xFF127C8A),
            ),
            child: Column(
              children: [
                // شريط البحث
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF404040) : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: isDark ? Colors.white70 : const Color(0xFF127C8A),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'البحث في المفضلة...',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: isDark ? Colors.white54 : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // شريط الفلترة
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('الكل', isDark),
                      const SizedBox(width: 8),
                      _buildFilterChip('باص', isDark),
                      const SizedBox(width: 8),
                      _buildFilterChip('قطار', isDark),
                      const SizedBox(width: 8),
                      _buildFilterChip('طائرة', isDark),
                      const SizedBox(width: 8),
                      _buildFilterChip('فندق', isDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // محتوى التبويبات
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCompaniesList(isDark, favoritesProvider),
                _buildRoutesList(isDark, favoritesProvider),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isDark) {
    final isSelected = selectedFilter == label;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected 
            ? Colors.white 
            : (isDark ? Colors.white70 : const Color(0xFF127C8A)),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedColor: const Color(0xFF127C8A),
      backgroundColor: isDark ? const Color(0xFF404040) : Colors.white,
      onSelected: (selected) {
        setState(() {
          selectedFilter = label;
        });
      },
    );
  }

  Widget _buildCompaniesList(bool isDark, FavoritesProvider favoritesProvider) {
    final companies = _getFilteredCompanies(favoritesProvider);
    
    if (companies.isEmpty) {
      return _buildEmptyState(
        icon: Icons.favorite_border,
        title: 'لا توجد شركات مفضلة',
        subtitle: 'اضغط على القلب لإضافة الشركات إلى المفضلة',
        isDark: isDark,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: companies.length,
      itemBuilder: (context, index) {
        return _buildCompanyCard(companies[index], isDark);
      },
    );
  }

  Widget _buildRoutesList(bool isDark, FavoritesProvider favoritesProvider) {
    final routes = _getFilteredRoutes(favoritesProvider);
    
    if (routes.isEmpty) {
      return _buildEmptyState(
        icon: Icons.route,
        title: 'لا توجد طرق مفضلة',
        subtitle: 'اضغط على القلب لإضافة الطرق إلى المفضلة',
        isDark: isDark,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: routes.length,
      itemBuilder: (context, index) {
        return _buildRouteCard(routes[index], isDark);
      },
    );
  }

  Widget _buildCompanyCard(FavoriteItem company, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark 
              ? Colors.black.withOpacity(0.3)
              : Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // أيقونة الشركة
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
                child: Icon(
                  _getCompanyIcon(company.type),
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // معلومات الشركة
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: isDark ? Colors.white : const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getCompanyTypeLabel(company.type),
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      color: isDark ? Colors.white70 : const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: isDark ? Colors.white70 : const Color(0xFF6B7280),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${company.fromLocation} → ${company.toLocation}',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Cairo',
                          color: isDark ? Colors.white70 : const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // زر القلب
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    Provider.of<FavoritesProvider>(context, listen: false)
                        .removeFromFavorites(company.id);
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
                  child: Text(
                    'احجز الآن',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: const Color(0xFF127C8A),
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

  Widget _buildRouteCard(FavoriteItem route, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark 
              ? Colors.black.withOpacity(0.3)
              : Colors.black.withOpacity(0.1),
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
                // أيقونة النوع
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getRouteColor(route.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getRouteIcon(route.type),
                    color: _getRouteColor(route.type),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                // معلومات الرحلة
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${route.fromLocation} → ${route.toLocation}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: isDark ? Colors.white : const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${route.date} • ${route.time}',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Cairo',
                          color: isDark ? Colors.white70 : const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                // السعر وزر القلب
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${route.price} ل.س',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: const Color(0xFF127C8A),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<FavoritesProvider>(context, listen: false)
                            .removeFromFavorites(route.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تمت إزالة الرحلة من المفضلة'),
                            backgroundColor: Color(0xFF127C8A),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // أزرار الإجراءات
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
    required bool isDark,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF404040) : Colors.grey[100],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              size: 60,
              color: isDark ? Colors.white54 : Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: isDark ? Colors.white70 : const Color(0xFF6B7280),
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white54 : const Color(0xFF9CA3AF),
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }

  List<FavoriteItem> _getFilteredCompanies(FavoritesProvider provider) {
    var companies = provider.favorites.where((item) => 
      item.name.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();

    if (selectedFilter != 'الكل') {
      companies = companies.where((item) => 
        _getCompanyTypeLabel(item.type) == selectedFilter
      ).toList();
    }

    return companies;
  }

  List<FavoriteItem> _getFilteredRoutes(FavoritesProvider provider) {
    var routes = provider.favorites.where((item) => 
      item.fromLocation.toLowerCase().contains(searchQuery.toLowerCase()) ||
      item.toLocation.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();

    if (selectedFilter != 'الكل') {
      routes = routes.where((item) => 
        _getCompanyTypeLabel(item.type) == selectedFilter
      ).toList();
    }

    return routes;
  }

  List<Color> _getCompanyGradient(String type) {
    switch (type) {
      case 'bus':
        return [const Color(0xFF127C8A), const Color(0xFF0F5F6B)];
      case 'train':
        return [const Color(0xFF10B981), const Color(0xFF059669)];
      case 'flight':
        return [const Color(0xFFF59E0B), const Color(0xFFD97706)];
      case 'hotel':
        return [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)];
      default:
        return [const Color(0xFF127C8A), const Color(0xFF0F5F6B)];
    }
  }

  IconData _getCompanyIcon(String type) {
    switch (type) {
      case 'bus':
        return Icons.directions_bus;
      case 'train':
        return Icons.train;
      case 'flight':
        return Icons.flight;
      case 'hotel':
        return Icons.hotel;
      default:
        return Icons.business;
    }
  }

  String _getCompanyTypeLabel(String type) {
    switch (type) {
      case 'bus':
        return 'باص';
      case 'train':
        return 'قطار';
      case 'flight':
        return 'طائرة';
      case 'hotel':
        return 'فندق';
      default:
        return 'شركة';
    }
  }

  Color _getRouteColor(String type) {
    switch (type) {
      case 'bus':
        return const Color(0xFF127C8A);
      case 'train':
        return const Color(0xFF10B981);
      case 'flight':
        return const Color(0xFFF59E0B);
      case 'hotel':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF127C8A);
    }
  }

  IconData _getRouteIcon(String type) {
    switch (type) {
      case 'bus':
        return Icons.directions_bus;
      case 'train':
        return Icons.train;
      case 'flight':
        return Icons.flight;
      case 'hotel':
        return Icons.hotel;
      default:
        return Icons.route;
    }
  }

  void _bookWithCompany(FavoriteItem company) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري الانتقال إلى حجز ${company.name}...'),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _searchRoute(FavoriteItem route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري البحث عن رحلات من ${route.fromLocation} إلى ${route.toLocation}...'),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _bookRoute(FavoriteItem route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري الانتقال إلى حجز الرحلة من ${route.fromLocation} إلى ${route.toLocation}...'),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _showSortOptions() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF2D2D2D) : Colors.white,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ترتيب المفضلة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(
                Icons.star,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              title: Text(
                'حسب التقييم',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // تنفيذ الترتيب حسب التقييم
              },
            ),
            ListTile(
              leading: Icon(
                Icons.sort_by_alpha,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              title: Text(
                'حسب الاسم',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // تنفيذ الترتيب حسب الاسم
              },
            ),
            ListTile(
              leading: Icon(
                Icons.attach_money,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
              title: Text(
                'حسب السعر',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // تنفيذ الترتيب حسب السعر
              },
            ),
          ],
        ),
      ),
    );
  }
} 
