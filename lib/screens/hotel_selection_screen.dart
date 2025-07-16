import 'package:flutter/material.dart';
import '../data/hotel_data.dart';
import 'hotel_booking_screen.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../screens/favorite_screen.dart';

class HotelSelectionScreen extends StatefulWidget {
  const HotelSelectionScreen({super.key});

  @override
  State<HotelSelectionScreen> createState() => _HotelSelectionScreenState();
}

class _HotelSelectionScreenState extends State<HotelSelectionScreen> {
  final List<String> provinces = [
    'دمشق', 'ريف دمشق', 'حلب', 'حمص', 'حماة', 'اللاذقية', 'طرطوس',
    'إدلب', 'درعا', 'السويداء', 'دير الزور', 'الحسكة', 'الرقة', 'القنيطرة',
  ];
  String? selectedProvince;

  bool _isFavorite(String hotelId, List<FavoriteCompany> favorites) {
    return favorites.any((c) => c.id == hotelId);
  }

  @override
  Widget build(BuildContext context) {
    final filteredHotels = selectedProvince == null
        ? []
        : HotelData.hotels.where((h) => h.province == selectedProvince).toList();
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteCompanies = favoriteProvider.favoriteCompanies;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'الفنادق',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF127C8A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // اختيار المحافظة
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF127C8A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.hotel,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(height: 8),
                const Text(
                  'اختر المحافظة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: provinces.map((province) {
                    final isSelected = selectedProvince == province;
                    return ChoiceChip(
                      label: Text(province, style: const TextStyle(fontFamily: 'Cairo')),
                      selected: isSelected,
                      selectedColor: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: isSelected ? const Color(0xFF127C8A) : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      onSelected: (_) {
                        setState(() {
                          selectedProvince = province;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          // قائمة الفنادق
          if (selectedProvince != null)
            Expanded(
              child: filteredHotels.isEmpty
                  ? const Center(child: Text('لا يوجد فنادق في هذه المحافظة', style: TextStyle(fontFamily: 'Cairo')))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredHotels.length,
                      itemBuilder: (context, index) {
                        final hotel = filteredHotels[index];
                        final isFavorite = _isFavorite(hotel.id, favoriteCompanies);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
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
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HotelBookingScreen(hotel: hotel),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF127C8A).withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                            child: Text(
                                              hotel.images.first,
                                              style: const TextStyle(fontSize: 32),
                                            ),
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
                                                  fontFamily: 'Cairo',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF1F2937),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    hotel.province,
                                                    style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      fontSize: 12,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: List.generate(5, (index) {
                                                  return Icon(
                                                    Icons.star,
                                                    size: 14,
                                                    color: index < hotel.stars 
                                                        ? Colors.amber[600] 
                                                        : Colors.grey[300],
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if (!isFavorite) {
                                                      final favCompany = FavoriteCompany(
                                                        id: hotel.id,
                                                        name: hotel.name,
                                                        logo: hotel.images.first,
                                                        type: CompanyType.hotel,
                                                        rating: hotel.rating,
                                                        routes: hotel.stars,
                                                        isFavorite: true,
                                                      );
                                                      favoriteProvider.toggleCompanyFavorite(favCompany);
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text('تمت إضافة ${hotel.name} إلى المفضلة'),
                                                          backgroundColor: const Color(0xFF127C8A),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  icon: Icon(
                                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                                    color: isFavorite ? Colors.red : Colors.grey,
                                                    size: 24,
                                                  ),
                                                ),
                                                Text(
                                                  '${hotel.pricePerNight.toInt()} ${hotel.currency}',
                                                  style: const TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF127C8A),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'لليلة الواحدة',
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 10,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      hotel.description,
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
        ],
      ),
    );
  }
} 
