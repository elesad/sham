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
            Tab(text: 'الرحلات المفضلة'),
            Tab(text: 'الفنادق المفضلة'),
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
                _buildTripsList(),
                _buildHotelsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsList() {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final trips = favoritesProvider.getFavoritesByType('bus')
          ..addAll(favoritesProvider.getFavoritesByType('plane'))
          ..addAll(favoritesProvider.getFavoritesByType('train'));
        
        if (trips.isEmpty) {
          return _buildEmptyState(
            icon: Icons.flight,
            title: 'لا توجد رحلات مفضلة',
            subtitle: 'أضف رحلاتك المفضلة لتظهر هنا',
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: trips.length,
          itemBuilder: (context, index) {
            return _buildTripCard(trips[index]);
          },
        );
      },
    );
  }

  Widget _buildHotelsList() {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        final hotels = favoritesProvider.getFavoritesByType('hotel');
        
        if (hotels.isEmpty) {
          return _buildEmptyState(
            icon: Icons.hotel,
            title: 'لا توجد فنادق مفضلة',
            subtitle: 'أضف فنادقك المفضلة لتظهر هنا',
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            return _buildHotelCard(hotels[index]);
          },
        );
      },
    );
  }

  Widget _buildTripCard(FavoriteItem trip) {
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
                    color: _getTripColor(trip.type).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getTripIcon(trip.type),
                    color: _getTripColor(trip.type),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      Text(
                        '${trip.fromLocation} → ${trip.toLocation}',
                        style: const TextStyle(
                          fontSize: 14,
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
                      trip.price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color(0xFF127C8A),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _removeFromFavorites(trip.id),
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
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _searchTrip(trip),
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
                    onPressed: () => _bookTrip(trip),
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

  Widget _buildHotelCard(FavoriteItem hotel) {
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
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.hotel,
                    color: Color(0xFFF59E0B),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      Text(
                        hotel.description,
                        style: const TextStyle(
                          fontSize: 14,
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
                      hotel.price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Color(0xFF127C8A),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _removeFromFavorites(hotel.id),
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
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _searchHotel(hotel),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF127C8A),
                      side: const BorderSide(color: Color(0xFF127C8A)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'البحث عن فنادق',
                      style: TextStyle(fontFamily: 'Cairo'),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _bookHotel(hotel),
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

  Color _getTripColor(String type) {
    switch (type) {
      case 'bus':
        return const Color(0xFF127C8A);
      case 'plane':
        return const Color(0xFF10B981);
      case 'train':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF127C8A);
    }
  }

  IconData _getTripIcon(String type) {
    switch (type) {
      case 'bus':
        return Icons.directions_bus;
      case 'plane':
        return Icons.flight;
      case 'train':
        return Icons.train;
      default:
        return Icons.directions_bus;
    }
  }

  void _removeFromFavorites(String id) {
    Provider.of<FavoritesProvider>(context, listen: false).removeFromFavorites(id);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تمت إزالة العنصر من المفضلة'),
        backgroundColor: Color(0xFF127C8A),
      ),
    );
  }

  void _searchTrip(FavoriteItem trip) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري البحث عن رحلات من ${trip.fromLocation} إلى ${trip.toLocation}...'),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _bookTrip(FavoriteItem trip) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري الانتقال إلى حجز الرحلة من ${trip.fromLocation} إلى ${trip.toLocation}...'),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _searchHotel(FavoriteItem hotel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري البحث عن فنادق في ${hotel.toLocation}...'),
        backgroundColor: const Color(0xFF127C8A),
      ),
    );
  }

  void _bookHotel(FavoriteItem hotel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('جاري الانتقال إلى حجز ${hotel.name}...'),
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
              leading: const Icon(Icons.access_time),
              title: const Text('حسب التاريخ', style: TextStyle(fontFamily: 'Cairo')),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم ترتيب المفضلة حسب التاريخ'),
                    backgroundColor: Color(0xFF127C8A),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sort_by_alpha),
              title: const Text('حسب الاسم', style: TextStyle(fontFamily: 'Cairo')),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم ترتيب المفضلة حسب الاسم'),
                    backgroundColor: Color(0xFF127C8A),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('حسب النوع', style: TextStyle(fontFamily: 'Cairo')),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم ترتيب المفضلة حسب النوع'),
                    backgroundColor: Color(0xFF127C8A),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 
