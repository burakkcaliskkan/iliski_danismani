import 'package:flutter/material.dart';
import '../localization/localization_helper.dart';
import '../services/firestore_service.dart';

class DurumEkleScreen extends StatefulWidget {
  const DurumEkleScreen({super.key});

  @override
  State<DurumEkleScreen> createState() => _DurumEkleScreenState();
}

class _DurumEkleScreenState extends State<DurumEkleScreen> {
  final FirestoreService firestoreService = FirestoreService();

  // Yeni form değişkenleri
  String? iletisimDurumu;
  String? mesajlasmaHizi;
  String? fizikselMesafe;
  String? duygusalDurum;
  String? sonIletisimTini;
  String? eklemekIstediklerin;

  // Kişi bilgileri
  String? kizinAdi;
  String? seninYasin;
  String? onunYasi;

  // Özel notlar için
  String? ozelNotlar;

  bool konusmaKonulari = false;
  bool bulusmaFikirleri = false;
  bool mesajlasmaOnerileri = false;
  bool ilkAdimAtma = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationHelper.translate('add_relationship_status')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: LocalizationHelper.translate('person_name'),
                ),
                onChanged: (value) => kizinAdi = value,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: LocalizationHelper.translate('your_age'),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => seninYasin = value,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: LocalizationHelper.translate('their_age'),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => onunYasi = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: LocalizationHelper.translate(
                    'communication_level_title',
                  ),
                  border: OutlineInputBorder(),
                ),
                value: iletisimDurumu,
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: 'no_contact',
                    child: Text(
                      LocalizationHelper.translate('communication_no_contact'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'only_messages',
                    child: Text(
                      LocalizationHelper.translate(
                        'communication_only_messages',
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'first_meeting',
                    child: Text(
                      LocalizationHelper.translate(
                        'communication_first_meeting',
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'few_meetings',
                    child: Text(
                      LocalizationHelper.translate(
                        'communication_few_meetings',
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'flirty_signals',
                    child: Text(
                      LocalizationHelper.translate(
                        'communication_flirty_signals',
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'custom',
                    child: Text(
                      LocalizationHelper.translate('communication_custom'),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    iletisimDurumu = value;
                  });
                },
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: LocalizationHelper.translate(
                    'messaging_speed_title',
                  ),
                  border: OutlineInputBorder(),
                ),
                value: mesajlasmaHizi,
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: 'very_slow',
                    child: Text(
                      LocalizationHelper.translate('messaging_very_slow'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'slow',
                    child: Text(LocalizationHelper.translate('messaging_slow')),
                  ),
                  DropdownMenuItem(
                    value: 'balanced',
                    child: Text(
                      LocalizationHelper.translate('messaging_balanced'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'fast',
                    child: Text(LocalizationHelper.translate('messaging_fast')),
                  ),
                  DropdownMenuItem(
                    value: 'very_fast',
                    child: Text(
                      LocalizationHelper.translate('messaging_very_fast'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'custom',
                    child: Text(
                      LocalizationHelper.translate('messaging_custom'),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    mesajlasmaHizi = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: LocalizationHelper.translate(
                    'physical_distance_title',
                  ),
                  border: OutlineInputBorder(),
                ),
                value: fizikselMesafe,
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: 'same_place',
                    child: Text(
                      LocalizationHelper.translate('distance_same_place'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'walking_distance',
                    child: Text(
                      LocalizationHelper.translate('distance_walking_distance'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'different_cities',
                    child: Text(
                      LocalizationHelper.translate('distance_different_cities'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'different_countries',
                    child: Text(
                      LocalizationHelper.translate(
                        'distance_different_countries',
                      ),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'custom',
                    child: Text(
                      LocalizationHelper.translate('distance_custom'),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    fizikselMesafe = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: LocalizationHelper.translate(
                    'emotional_state_title',
                  ),
                  border: OutlineInputBorder(),
                ),
                value: duygusalDurum,
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: 'romantic',
                    child: Text(
                      LocalizationHelper.translate('emotional_romantic'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'friendly',
                    child: Text(
                      LocalizationHelper.translate('emotional_friendly'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'mixed',
                    child: Text(
                      LocalizationHelper.translate('emotional_mixed'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'uncertain',
                    child: Text(
                      LocalizationHelper.translate('emotional_uncertain'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'concerned',
                    child: Text(
                      LocalizationHelper.translate('emotional_concerned'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'custom',
                    child: Text(
                      LocalizationHelper.translate('emotional_custom'),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    duygusalDurum = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: LocalizationHelper.translate(
                    'last_communication_title',
                  ),
                  border: OutlineInputBorder(),
                ),
                value: sonIletisimTini,
                isExpanded: true,
                items: [
                  DropdownMenuItem(
                    value: 'flirty',
                    child: Text(
                      LocalizationHelper.translate('last_communication_flirty'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'warm',
                    child: Text(
                      LocalizationHelper.translate('last_communication_warm'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'cold',
                    child: Text(
                      LocalizationHelper.translate('last_communication_cold'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'mixed',
                    child: Text(
                      LocalizationHelper.translate('last_communication_mixed'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'custom',
                    child: Text(
                      LocalizationHelper.translate('last_communication_custom'),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    sonIletisimTini = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: LocalizationHelper.translate(
                    'additional_thoughts_title',
                  ),
                  hintText: LocalizationHelper.translate(
                    'additional_thoughts_hint',
                  ),
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                onChanged: (value) => eklemekIstediklerin = value,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: LocalizationHelper.translate('special_notes'),
                  hintText: LocalizationHelper.translate('special_notes_hint'),
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                onChanged: (value) => ozelNotlar = value,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  LocalizationHelper.translate('help_topics'),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              CheckboxListTile(
                title: Text(
                  LocalizationHelper.translate('conversation_topics'),
                ),
                value: konusmaKonulari,
                onChanged: (bool? value) {
                  setState(() {
                    konusmaKonulari = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(LocalizationHelper.translate('meeting_ideas')),
                value: bulusmaFikirleri,
                onChanged: (bool? value) {
                  setState(() {
                    bulusmaFikirleri = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  LocalizationHelper.translate('messaging_suggestions'),
                ),
                value: mesajlasmaOnerileri,
                onChanged: (bool? value) {
                  setState(() {
                    mesajlasmaOnerileri = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(LocalizationHelper.translate('take_first_step')),
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
                      'foto': 'assets/images/ayse.jpg',
                      'iletisimDurumu': iletisimDurumu ?? 'Unknown',
                      'mesajlasmaHizi': mesajlasmaHizi ?? 'Unknown',
                      'fizikselMesafe': fizikselMesafe ?? 'Normal',
                      'duygusalDurum': duygusalDurum ?? 'New',
                      'sonIletisimTini': sonIletisimTini ?? 'Unknown',
                      'eklemekIstediklerin': eklemekIstediklerin ?? '',
                      'ozelNotlar': ozelNotlar ?? '',
                    };
                    await firestoreService.addStatus(yeniDurum);
                    if (mounted) {
                      navigator.pop(yeniDurum);
                    }
                  } catch (e) {
                    if (mounted) {
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            '${LocalizationHelper.translate('error')}: $e',
                          ),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.pink,
                ),
                child: Text(
                  LocalizationHelper.translate('save'),
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
