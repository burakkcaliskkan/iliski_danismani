import 'package:flutter/material.dart';
import '../localization/localization_helper.dart';
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
  late TextEditingController kizinAdiController;
  late TextEditingController seninYasinController;
  late TextEditingController onunYasiController;
  late TextEditingController eklemekIstediklerinController;
  late TextEditingController ozelNotlarController;

  // Dropdown values
  String? iletisimDurumu;
  String? mesajlasmaHizi;
  String? fizikselMesafe;
  String? duygusalDurum;
  String? sonIletisimTini;

  // Checkbox values
  bool konusmaKonulari = false;
  bool bulusmaFikirleri = false;
  bool mesajlasmaOnerileri = false;
  bool ilkAdimAtma = false;

  @override
  void initState() {
    super.initState();
    // Load existing data into controllers
    kizinAdiController = TextEditingController(
      text: widget.durum['kizinAdi'] ?? '',
    );
    seninYasinController = TextEditingController(
      text: widget.durum['seninYasin']?.toString() ?? '',
    );
    onunYasiController = TextEditingController(
      text: widget.durum['onunYasi']?.toString() ?? '',
    );
    eklemekIstediklerinController = TextEditingController(
      text: widget.durum['eklemekIstediklerin'] ?? '',
    );
    ozelNotlarController = TextEditingController(
      text: widget.durum['ozelNotlar'] ?? '',
    );

    // Load dropdown values
    iletisimDurumu = widget.durum['iletisimDurumu'];
    mesajlasmaHizi = widget.durum['mesajlasmaHizi'];
    fizikselMesafe = widget.durum['fizikselMesafe'];
    duygusalDurum = widget.durum['duygusalDurum'];
    sonIletisimTini = widget.durum['sonIletisimTini'];

    // Load checkbox values
    konusmaKonulari = widget.durum['konusmaKonulari'] ?? false;
    bulusmaFikirleri = widget.durum['bulusmaFikirleri'] ?? false;
    mesajlasmaOnerileri = widget.durum['mesajlasmaOnerileri'] ?? false;
    ilkAdimAtma = widget.durum['ilkAdimAtma'] ?? false;
  }

  @override
  void dispose() {
    kizinAdiController.dispose();
    seninYasinController.dispose();
    onunYasiController.dispose();
    eklemekIstediklerinController.dispose();
    ozelNotlarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationHelper.translate('edit_relationship_status')),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Person's name input
              TextField(
                controller: kizinAdiController,
                decoration: InputDecoration(
                  labelText: LocalizationHelper.translate('person_name'),
                ),
              ),
              const SizedBox(height: 16),
              // Age inputs
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: seninYasinController,
                      decoration: InputDecoration(
                        labelText: LocalizationHelper.translate('your_age'),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: onunYasiController,
                      decoration: InputDecoration(
                        labelText: LocalizationHelper.translate('their_age'),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Communication level dropdown
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
              // Messaging speed dropdown
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
              // Physical distance dropdown
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
              // Emotional state dropdown
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
              // Last communication tone dropdown
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
              // Additional thoughts input
              TextField(
                controller: eklemekIstediklerinController,
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
              ),
              const SizedBox(height: 16),
              // Special notes input
              TextField(
                controller: ozelNotlarController,
                decoration: InputDecoration(
                  labelText: LocalizationHelper.translate('special_notes'),
                  hintText: LocalizationHelper.translate('special_notes_hint'),
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              // Help topics section
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
              // Update button
              ElevatedButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final messenger = ScaffoldMessenger.of(context);

                  try {
                    // Prepare updated data
                    Map<String, dynamic> guncelDurum = {
                      'kizinAdi': kizinAdiController.text,
                      'seninYasin':
                          int.tryParse(seninYasinController.text) ?? 18,
                      'onunYasi': int.tryParse(onunYasiController.text) ?? 18,
                      'iletisimDurumu': iletisimDurumu ?? 'no_contact',
                      'mesajlasmaHizi': mesajlasmaHizi ?? 'balanced',
                      'fizikselMesafe': fizikselMesafe ?? 'same_place',
                      'duygusalDurum': duygusalDurum ?? 'friendly',
                      'sonIletisimTini': sonIletisimTini ?? 'warm',
                      'eklemekIstediklerin': eklemekIstediklerinController.text,
                      'ozelNotlar': ozelNotlarController.text,
                      'konusmaKonulari': konusmaKonulari,
                      'bulusmaFikirleri': bulusmaFikirleri,
                      'mesajlasmaOnerileri': mesajlasmaOnerileri,
                      'ilkAdimAtma': ilkAdimAtma,
                      'foto': widget.durum['foto'] ?? 'assets/images/ayse.jpg',
                    };

                    // Update in Firestore
                    await firestoreService.updateStatus(
                      widget.durum['id'],
                      guncelDurum,
                    );
                    if (mounted) {
                      navigator.pop(true); // Return true to indicate success
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            LocalizationHelper.translate('update_success'),
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            '${LocalizationHelper.translate('update_failed')}: $e',
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
                  LocalizationHelper.translate('update'),
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
