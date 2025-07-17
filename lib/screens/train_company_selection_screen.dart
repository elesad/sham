import 'package:flutter/material.dart';
import 'train_seat_selection_screen.dart';

class TrainCompanySelectionScreen extends StatefulWidget {
  final String fromProvince;
  final String toProvince;
  final DateTime date;
  const TrainCompanySelectionScreen({Key? key, required this.fromProvince, required this.toProvince, required this.date}) : super(key: key);

  @override
  State<TrainCompanySelectionScreen> createState() => _TrainCompanySelectionScreenState();
}

class _TrainCompanySelectionScreenState extends State<TrainCompanySelectionScreen> {
  bool isFavorite = false;

  final Map<String, dynamic> trainTrip = {
    'companyName': 'المؤسسة العامة للخطوط الحديدية السورية',
    'logo': '🚆',
    'time': '3:00 مساءً',
    'price': 15000,
    'tripNumber': 'TR202',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نتائج رحلات القطار'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.green.shade100,
                      child: Text(trainTrip['logo'], style: const TextStyle(fontSize: 32)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(trainTrip['companyName'], style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                          const SizedBox(height: 4),
                          Text('رحلة قطار بين ${widget.fromProvince} و${widget.toProvince}', style: const TextStyle(fontFamily: 'Cairo', color: Colors.grey)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                      onPressed: () => setState(() => isFavorite = !isFavorite),
                      tooltip: 'إضافة إلى المفضلة',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Text(trainTrip['logo'], style: const TextStyle(fontSize: 22)),
                ),
                title: Text('رحلة رقم ${trainTrip['tripNumber']}', style: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('الوقت: ${trainTrip['time']}', style: const TextStyle(fontFamily: 'Cairo')),
                    Text('السعر: ${trainTrip['price']} ل.س', style: const TextStyle(fontFamily: 'Cairo')),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                  onPressed: () => setState(() => isFavorite = !isFavorite),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrainSeatSelectionScreen(
                        companyName: trainTrip['companyName'],
                        fromProvince: widget.fromProvince,
                        toProvince: widget.toProvince,
                        date: widget.date,
                        tripNumber: trainTrip['tripNumber'],
                        tripTime: trainTrip['time'],
                        price: trainTrip['price'],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 