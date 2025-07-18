import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'durum_ekle_screen.dart';
import 'profil_detay_screen.dart';
import '../services/firestore_service.dart';

class DurumlarScreen extends StatefulWidget {
  const DurumlarScreen({super.key});

  @override
  State<DurumlarScreen> createState() => _DurumlarScreenState();
}

class _DurumlarScreenState extends State<DurumlarScreen> {
  final FirestoreService firestoreService = FirestoreService();
  List<Map<String, dynamic>> statusList = [];
  bool isLoading = true;

  Future<void> getStatusList() async {
    setState(() {
      isLoading = true;
    });

    final list = await firestoreService.fetchStatusList();
    setState(() {
      statusList = list;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getStatusList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getStatusList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        title: const Text('İlişkilerim'),
        backgroundColor: AppColors.primaryPink,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DurumEkleScreen(),
                ),
              );
              getStatusList();
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : statusList.isEmpty
          ? const Center(
              child: Text(
                'Henüz ilişki durumu eklenmemiş',
                style: TextStyle(fontSize: 24, color: AppColors.textDark),
              ),
            )
          : ListView.builder(
              itemCount: statusList.length,
              itemBuilder: (context, index) {
                final durum = statusList[index];
                return InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilDetayScreen(durum: durum),
                      ),
                    );
                    if (result == true) {
                      getStatusList();
                    }
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              durum['foto'] ?? 'assets/images/ayse.jpg',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  durum['isim'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${durum['yas']} yaşında',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${_translateStatus(durum['iliskiDurumu'])} • ${_translateCurrentStatus(durum['anlikDurum'])}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _translateStatus(String? status) {
    switch (status) {
      case 'bekar':
        return 'Bekar';
      case 'evli':
        return 'Evli';
      case 'iliskisi_var':
        return 'İlişkisi Var';
      case 'karmasik':
        return 'Karmaşık';
      default:
        return 'Bilinmiyor';
    }
  }

  String _translateCurrentStatus(String? status) {
    switch (status) {
      case 'sosyal_medya':
        return 'Sadece Sosyal Medya';
      case 'ilk_bulusma':
        return 'İlk Buluşma';
      case 'birkac_bulusma':
        return 'Birkaç Buluşma';
      case '6_ay_az':
        return '6 Aydan Az';
      case '1_yil_az':
        return '1 Yıldan Az';
      case '1_yil_fazla':
        return '1 Yıldan Fazla';
      default:
        return 'Yeni Durum';
    }
  }
}
