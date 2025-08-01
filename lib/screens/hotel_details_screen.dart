import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorites_provider.dart';
import 'hotel_booking_screen.dart';

class HotelDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> hotel;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int rooms;
  final int guests;

  const HotelDetailsScreen({
    Key? key,
    required this.hotel,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rooms,
    required this.guests,
  }) : super(key: key);

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    final isFavorite = favoritesProvider.isFavorite(widget.hotel['id']);
    
    if (isFavorite) {
      favoritesProvider.removeFromFavorites(widget.hotel['id']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إزالة ${widget.hotel['name']} من المفضلة'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } else {
      final favoriteItem = FavoriteItem(
        id: widget.hotel['id'],
        name: widget.hotel['name'],
        type: 'hotel',
        fromLocation: widget.hotel['location'],
        toLocation: widget.hotel['location'],
        date: '${widget.checkInDate.day}/${widget.checkInDate.month}/${widget.checkInDate.year}',
        price: '${widget.hotel['price']} ل.س',
        time: '${widget.rooms} غرفة • ${widget.guests} شخص',
        description: widget.hotel['description'],
        features: widget.hotel['features'],
        addedAt: DateTime.now(),
      );
      favoritesProvider.addToFavorites(favoriteItem);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم إضافة ${widget.hotel['name']} إلى المفضلة'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  void _bookHotel() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelBookingScreen(
          hotelName: widget.hotel['name'],
          hotelImage: widget.hotel['image'],
          location: widget.hotel['location'],
          rating: widget.hotel['rating'].toDouble(),
          price: widget.hotel['price'],
          checkInDate: widget.checkInDate,
          checkOutDate: widget.checkOutDate,
          rooms: widget.rooms,
          guests: widget.guests,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8FAFC),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            // App Bar مع صورة الفندق
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              backgroundColor: isDark ? const Color(0xFF2D2D2D) : const Color(0xFF8B5CF6),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      widget.hotel['image'],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: isDark ? const Color(0xFF404040) : Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                              color: const Color(0xFF8B5CF6),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: isDark ? const Color(0xFF404040) : Colors.grey[200],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.hotel,
                                size: 80,
                                color: isDark ? Colors.white70 : Colors.grey[600],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'فشل في تحميل الصورة',
                                style: TextStyle(
                                  color: isDark ? Colors.white70 : Colors.grey[600],
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.hotel['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white70,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.hotel['location'],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Consumer<FavoritesProvider>(
                  builder: (context, favoritesProvider, child) {
                    final isFavorite = favoritesProvider.isFavorite(widget.hotel['id']);
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: _toggleFavorite,
                    );
                  },
                ),
              ],
            ),
            
            // محتوى التفاصيل
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // التقييم والسعر
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.hotel['rating'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${widget.hotel['price']} ل.س',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B5CF6),
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // الوصف
                    const Text(
                      'الوصف',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.hotel['description'],
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white70 : Colors.grey[700],
                        fontFamily: 'Cairo',
                        height: 1.5,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // المميزات
                    const Text(
                      'المميزات',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (widget.hotel['features'] as String).split(' • ').map<Widget>((feature) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            feature,
                            style: const TextStyle(
                              color: Color(0xFF8B5CF6),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // تفاصيل الحجز
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF2D2D2D) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark ? Colors.white24 : Colors.grey[200]!,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'تفاصيل الحجز',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildBookingDetail('تاريخ الدخول', '${widget.checkInDate.day}/${widget.checkInDate.month}/${widget.checkInDate.year}'),
                          _buildBookingDetail('تاريخ المغادرة', '${widget.checkOutDate.day}/${widget.checkOutDate.month}/${widget.checkOutDate.year}'),
                          _buildBookingDetail('عدد الغرف', '${widget.rooms} غرفة'),
                          _buildBookingDetail('عدد الأشخاص', '${widget.guests} شخص'),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // زر الحجز
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _bookHotel,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5CF6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'احجز الآن',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingDetail(String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white70 : Colors.grey[600],
              fontFamily: 'Cairo',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }
} 