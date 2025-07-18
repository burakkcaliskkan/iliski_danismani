import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../services/firestore_service.dart';
import 'durum_duzenle_screen.dart';

class ProfilDetayScreen extends StatefulWidget {
  final Map<String, dynamic> durum;
  const ProfilDetayScreen({super.key, required this.durum});

  @override
  State<ProfilDetayScreen> createState() => _ProfilDetayScreenState();
}

class _ProfilDetayScreenState extends State<ProfilDetayScreen> {
  final FirestoreService firestoreService = FirestoreService();

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('İlişkiyi Sil'),
          content: const Text(
            'Bu ilişkiyi silmek istediğinizden emin misiniz?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                final messenger = ScaffoldMessenger.of(context);

                try {
                  await firestoreService.deleteStatus(widget.durum['id']);
                  if (mounted) {
                    navigator.pop();
                    navigator.pop(true);
                    messenger.showSnackBar(
                      const SnackBar(content: Text('İlişki başarıyla silindi')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    messenger.showSnackBar(
                      SnackBar(content: Text('Silme başarısız: $e')),
                    );
                  }
                }
              },
              child: const Text('Sil', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        title: Text(widget.durum['isim']),
        backgroundColor: AppColors.primaryPink,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () async {
              final navigator = Navigator.of(context);

              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DurumDuzenleScreen(durum: widget.durum),
                ),
              );
              if (result == true && mounted) {
                navigator.pop(true);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              _showDeleteDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                widget.durum['foto'] ?? 'assets/images/ayse.jpg',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.durum['isim'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.durum['yas']} yaşında - ${widget.durum['meslek']}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.pink, size: 24),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'İlişki Durumu',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        _translateRelationshipStatus(
                          widget.durum['iliskiDurumu'],
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.fitness_center,
                    color: Colors.green,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fiziksel Durum',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        _translatePhysicalCondition(
                          widget.durum['fizikselDurum'],
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.schedule, color: Colors.blue, size: 24),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anlık Durum',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        _translateCurrentStatus(widget.durum['anlikDurum']),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (widget.durum['ozelNotlar'] != null &&
                widget.durum['ozelNotlar'].isNotEmpty)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber[200]!, width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.note_alt, color: Colors.orange[700], size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Özel Notlar',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.durum['ozelNotlar'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange[800],
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _translateRelationshipStatus(String? status) {
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
        return 'Belirtilmemiş';
    }
  }

  String _translatePhysicalCondition(String? condition) {
    switch (condition) {
      case 'saglikli':
        return 'Sağlıklı';
      case 'sporcu':
        return 'Sporcu';
      case 'diyet':
        return 'Diyet';
      default:
        return 'Belirtilmemiş';
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
        return 'Belirtilmemiş';
    }
  }
}
