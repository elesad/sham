import 'package:flutter/material.dart';
import '../data/bus_data.dart';
import 'bus_seat_selection.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../screens/favorite_screen.dart';

class BusCompanySelectionScreen extends StatefulWidget {
  final String fromProvince;
  final String toProvince;
  final DateTime date;

  const BusCompanySelectionScreen({
    super.key,
    required this.fromProvince,
    required this.toProvince,
    required this.date,
  });

  @override
  State<BusCompanySelectionScreen> createState() => _BusCompanySelectionScreenState();
}

class _BusCompanySelectionScreenState extends State<BusCompanySelectionScreen> {
  // إزالة منطق المفضلة المحلي
  // final Set<String> _favoriteCompanies = <String>{};

  // bool _isFavorite(String companyId) {
  //   return _favoriteCompanies.contains(companyId);
  // }

  // void _toggleFavorite(dynamic company) {
  //   setState(() {
  //     if (_favoriteCompanies.contains(company.id)) {
  //       _favoriteCompanies.remove(company.id);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('تمت إزالة ${company.name} من المفضلة'),
  //           backgroundColor: const Color(0xFF127C8A),
  //         ),
  //       );
  //     } else {
  //       _favoriteCompanies.add(company.id);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('تمت إضافة ${company.name} إلى المفضلة'),
  //           backgroundColor: const Color(0xFF127C8A),
  //         ),
  //       );
  //     }
  //   });
  // }

  bool _isFavorite(String companyId, List<FavoriteCompany> favorites) {
    return favorites.any((c) => c.id == companyId);
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteCompanies = favoriteProvider.favoriteCompanies;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'شركات الباصات',
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
          // معلومات الرحلة
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'من: ${widget.fromProvince}',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'إلى: ${widget.toProvince}',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${widget.date.day}/${widget.date.month}/${widget.date.year}',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // قائمة الشركات
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: BusData.companies.length,
              itemBuilder: (context, index) {
                final company = BusData.companies[index];
                final isFavorite = _isFavorite(company.id, favoriteCompanies);
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
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
                        // إنشاء رحلة تجريبية
                        final trip = BusData.createSampleTrip(
                          fromProvince: widget.fromProvince,
                          toProvince: widget.toProvince,
                          date: widget.date,
                          companyId: company.id,
                        );
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusSeatSelectionScreen(trip: trip),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // شعار الشركة
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFF127C8A).withValues(alpha: 0.1),
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
                            
                            // معلومات الشركة
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    company.name,
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    company.description,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
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
                                          fontFamily: 'Cairo',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1F2937),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '(${company.reviewCount})',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // سعر الرحلة والمفضلة
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
                                            id: company.id,
                                            name: company.name,
                                            logo: company.logo,
                                            type: CompanyType.bus,
                                            rating: company.rating,
                                            routes: company.reviewCount,
                                            isFavorite: true,
                                          );
                                          favoriteProvider.toggleCompanyFavorite(favCompany);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('تمت إضافة ${company.name} إلى المفضلة'),
                                              backgroundColor: const Color(0xFF127C8A),
                                            ),
                                          );
                                        }
                                      },
                                      icon: Icon(
                                        isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: isFavorite ? Colors.red : Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                    const Text(
                                      '2500 ل.س',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF127C8A),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'متوفر',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF10B981),
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
            ),
          ),
        ],
      ),
    );
  }
} 