import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

/// Screen for editing existing relationship status
/// Pre-fills form with current data and allows updates
/// Features complete multi-language support
class DurumDuzenleScreen extends StatefulWidget {
  final Map<String, dynamic> durum;
  const DurumDuzenleScreen({super.key, required this.durum});

  @override
  State<DurumDuzenleScreen> createState() => _DurumDuzenleScreenState();
}

class _DurumDuzenleScreenState extends State<DurumDuzenleScreen> {
  final FirestoreService firestoreService = FirestoreService();

  // TextEditingControllers for form fields
  late TextEditingController isimController;
  late TextEditingController yasController;
  late TextEditingController ozelNotlarController;

  // Dropdown values
  String? fizikselDurum;
  String? iliskiDurumu;
  String? anlikDurum;

  @override
  void initState() {
    super.initState();
    // Load existing data into controllers
    isimController = TextEditingController(text: widget.durum['isim'] ?? '');
    yasController = TextEditingController(
      text: widget.durum['yas']?.toString() ?? '',
    );
    ozelNotlarController = TextEditingController(
      text: widget.durum['ozelNotlar'] ?? '',
    );

    fizikselDurum = widget.durum['fizikselDurum'];
    iliskiDurumu = widget.durum['iliskiDurumu'];
    anlikDurum = widget.durum['anlikDurum'];
  }

  @override
  void dispose() {
    isimController.dispose();
    yasController.dispose();
    ozelNotlarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İlişki Durumu Düzenle'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Person's name input - AUTO LOCALIZED 🌍
              TextField(
                controller: isimController,
                decoration: const InputDecoration(labelText: 'Kişinin Adı'),
              ),
              const SizedBox(height: 16),
              // Age input - AUTO LOCALIZED 🌍
              TextField(
                controller: yasController,
                decoration: const InputDecoration(labelText: 'Yaş'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              // Relationship status dropdown - AUTO LOCALIZED 🌍
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'İlişki Durumu'),
                value: iliskiDurumu,
                items: const [
                  DropdownMenuItem(value: 'Unknown', child: Text('Bilinmiyor')),
                  DropdownMenuItem(value: 'bekar', child: Text('Bekar')),
                  DropdownMenuItem(value: 'evli', child: Text('Evli')),
                  DropdownMenuItem(
                    value: 'iliskisi_var',
                    child: Text('İlişkisi Var'),
                  ),
                  DropdownMenuItem(value: 'karmasik', child: Text('Karmaşık')),
                ],
                onChanged: (value) {
                  setState(() {
                    iliskiDurumu = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Physical condition dropdown - AUTO LOCALIZED 🌍
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Fiziksel Durum'),
                value: fizikselDurum,
                items: const [
                  DropdownMenuItem(value: 'Normal', child: Text('Normal')),
                  DropdownMenuItem(value: 'saglikli', child: Text('Sağlıklı')),
                  DropdownMenuItem(value: 'sporcu', child: Text('Sporcu')),
                  DropdownMenuItem(value: 'diyet', child: Text('Diyet')),
                ],
                onChanged: (value) {
                  setState(() {
                    fizikselDurum = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Current situation dropdown - AUTO LOCALIZED 🌍
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Anlık Durum'),
                value: anlikDurum,
                items: const [
                  DropdownMenuItem(value: 'New', child: Text('Yeni Durum')),
                  DropdownMenuItem(
                    value: 'sosyal_medya',
                    child: Text('Sadece Sosyal Medya'),
                  ),
                  DropdownMenuItem(
                    value: 'ilk_bulusma',
                    child: Text('İlk Buluşma'),
                  ),
                  DropdownMenuItem(
                    value: 'birkac_bulusma',
                    child: Text('Birkaç Buluşma'),
                  ),
                  DropdownMenuItem(value: '6_ay_az', child: Text('6 Aydan Az')),
                  DropdownMenuItem(
                    value: '1_yil_az',
                    child: Text('1 Yıldan Az'),
                  ),
                  DropdownMenuItem(
                    value: '1_yil_fazla',
                    child: Text('1 Yıldan Fazla'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    anlikDurum = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Special notes input - AUTO LOCALIZED 🌍
              TextField(
                controller: ozelNotlarController,
                decoration: const InputDecoration(
                  labelText: 'Özel Notlar',
                  hintText: 'İlişki hakkında özel notlarınız...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 32),
              // Update button - AUTO LOCALIZED 🌍
              ElevatedButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);

                  try {
                    // Prepare updated data
                    Map<String, dynamic> guncelDurum = {
                      'isim': isimController.text,
                      'yas': int.tryParse(yasController.text) ?? 18,
                      'meslek': widget.durum['meslek'] ?? 'Student',
                      'foto': widget.durum['foto'] ?? 'assets/images/ayse.jpg',
                      'iliskiDurumu': iliskiDurumu ?? 'Unknown',
                      'fizikselDurum': fizikselDurum ?? 'Normal',
                      'anlikDurum': anlikDurum ?? 'New',
                      'ozelNotlar': ozelNotlarController.text,
                    };

                    // Update in Firestore
                    await firestoreService.updateStatus(
                      widget.durum['id'],
                      guncelDurum,
                    );
                    if (mounted) {
                      navigator.pop(true); // Return true to indicate success
                      messenger.showSnackBar(
                        const SnackBar(
                          content: Text('İlişki başarıyla güncellendi'),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      messenger.showSnackBar(
                        SnackBar(content: Text('Güncelleme başarısız: $e')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.pink,
                ),
                child: const Text(
                  'Güncelle',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
