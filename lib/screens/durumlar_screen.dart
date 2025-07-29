import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../localization/localization_helper.dart';
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
        title: Text(LocalizationHelper.translate('relationships_title')),
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
          ? Center(
              child: Text(
                LocalizationHelper.translate('no_relationships'),
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
                                  '${durum['yas']} ${LocalizationHelper.translate('years_old')}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${_translatePhysicalDistance(durum['fizikselMesafe'] ?? 'same_place')} • ${_translateEmotionalState(durum['duygusalDurum'] ?? 'friendly')}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                  ),
                                ),

                                const SizedBox(height: 4),
                                Text(
                                  '${_translateCommunicationLevel(durum['iletisimDurumu'] ?? 'no_contact')} • ${_translateMessagingSpeed(durum['mesajlasmaHizi'] ?? 'balanced')}',
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

  String _translateCommunicationLevel(String? status) {
    if (status == null)
      return LocalizationHelper.translate('communication_custom');

    switch (status) {
      case 'no_contact':
        return LocalizationHelper.translate('communication_no_contact');
      case 'only_messages':
        return LocalizationHelper.translate('communication_only_messages');
      case 'first_meeting':
        return LocalizationHelper.translate('communication_first_meeting');
      case 'few_meetings':
        return LocalizationHelper.translate('communication_few_meetings');
      case 'flirty_signals':
        return LocalizationHelper.translate('communication_flirty_signals');
      default:
        return LocalizationHelper.translate('communication_custom');
    }
  }

  String _translateMessagingSpeed(String? status) {
    if (status == null) return LocalizationHelper.translate('messaging_custom');

    switch (status) {
      case 'very_slow':
        return LocalizationHelper.translate('messaging_very_slow');
      case 'slow':
        return LocalizationHelper.translate('messaging_slow');
      case 'balanced':
        return LocalizationHelper.translate('messaging_balanced');
      case 'fast':
        return LocalizationHelper.translate('messaging_fast');
      case 'very_fast':
        return LocalizationHelper.translate('messaging_very_fast');
      default:
        return LocalizationHelper.translate('messaging_custom');
    }
  }

  String _translatePhysicalDistance(String? status) {
    if (status == null) return LocalizationHelper.translate('distance_custom');

    switch (status) {
      case 'same_place':
        return LocalizationHelper.translate('distance_same_place');
      case 'walking_distance':
        return LocalizationHelper.translate('distance_walking_distance');
      case 'different_cities':
        return LocalizationHelper.translate('distance_different_cities');
      case 'different_countries':
        return LocalizationHelper.translate('distance_different_countries');
      default:
        return LocalizationHelper.translate('distance_custom');
    }
  }

  String _translateEmotionalState(String? status) {
    if (status == null) return LocalizationHelper.translate('emotional_custom');

    switch (status) {
      case 'romantic':
        return LocalizationHelper.translate('emotional_romantic');
      case 'friendly':
        return LocalizationHelper.translate('emotional_friendly');
      case 'mixed':
        return LocalizationHelper.translate('emotional_mixed');
      case 'uncertain':
        return LocalizationHelper.translate('emotional_uncertain');
      case 'concerned':
        return LocalizationHelper.translate('emotional_concerned');
      default:
        return LocalizationHelper.translate('emotional_custom');
    }
  }
}
