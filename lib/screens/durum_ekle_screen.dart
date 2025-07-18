import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class DurumEkleScreen extends StatefulWidget {
  const DurumEkleScreen({super.key});

  @override
  State<DurumEkleScreen> createState() => _DurumEkleScreenState();
}

class _DurumEkleScreenState extends State<DurumEkleScreen> {
  final FirestoreService firestoreService = FirestoreService();

  String? fizikselDurum;
  String? iliskiDurumu;
  String? kizinAdi;
  String? seninYasin;
  String? onunYasi;
  String? anlikDurum;
  String? ozelNotlar;
  String? konu;

  bool konusmaKonulari = false;
  bool bulusmaFikirleri = false;
  bool mesajlasmaOnerileri = false;
  bool ilkAdimAtma = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('İlişki Durumu Ekle')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Kişinin Adı'),
                onChanged: (value) => kizinAdi = value,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Senin Yaşın',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => seninYasin = value,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(labelText: 'Onun Yaşı'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => onunYasi = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'İlişki Durumu'),
                value: iliskiDurumu,
                items: const [
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
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Fiziksel Durum'),
                value: fizikselDurum,
                items: const [
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
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Anlık Durum'),
                value: anlikDurum,
                items: const [
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
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Özel Notlar',
                  hintText: 'İlişki hakkında özel notlarınız...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                onChanged: (value) => ozelNotlar = value,
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hangi konularda yardım istiyorsunuz?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              CheckboxListTile(
                title: const Text('Konuşma Konuları'),
                value: konusmaKonulari,
                onChanged: (bool? value) {
                  setState(() {
                    konusmaKonulari = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Buluşma Fikirleri'),
                value: bulusmaFikirleri,
                onChanged: (bool? value) {
                  setState(() {
                    bulusmaFikirleri = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Mesajlaşma Önerileri'),
                value: mesajlasmaOnerileri,
                onChanged: (bool? value) {
                  setState(() {
                    mesajlasmaOnerileri = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('İlk Adım Atma'),
                value: ilkAdimAtma,
                onChanged: (bool? value) {
                  setState(() {
                    ilkAdimAtma = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);

                  try {
                    Map<String, dynamic> yeniDurum = {
                      'isim': kizinAdi ?? 'Anonymous',
                      'yas': int.tryParse(onunYasi ?? '') ?? 18,
                      'meslek': 'Student',
                      'foto': 'assets/images/ayse.jpg',
                      'iliskiDurumu': iliskiDurumu ?? 'Unknown',
                      'fizikselDurum': fizikselDurum ?? 'Normal',
                      'anlikDurum': anlikDurum ?? 'New',
                      'ozelNotlar': ozelNotlar ?? '',
                    };
                    await firestoreService.addStatus(yeniDurum);
                    if (mounted) {
                      navigator.pop(yeniDurum);
                    }
                  } catch (e) {
                    if (mounted) {
                      messenger.showSnackBar(
                        SnackBar(content: Text('Hata: $e')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.pink,
                ),
                child: const Text(
                  'Kaydet',
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
