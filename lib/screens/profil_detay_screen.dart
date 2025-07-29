import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../localization/localization_helper.dart';
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
          title: Text(LocalizationHelper.translate('delete_relationship')),
          content: Text(
            LocalizationHelper.translate('delete_relationship_confirm'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(LocalizationHelper.translate('cancel')),
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
                      SnackBar(
                        content: Text(
                          LocalizationHelper.translate('relationship_deleted'),
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          '${LocalizationHelper.translate('delete_failed')}: $e',
                        ),
                      ),
                    );
                  }
                }
              },
              child: Text(
                LocalizationHelper.translate('delete'),
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Debug: Veri yapısını kontrol et
    print('DEBUG: Durum verisi: ${widget.durum}');
    print('DEBUG: İletişim durumu: ${widget.durum['iletisimDurumu']}');
    print('DEBUG: Mesajlaşma hızı: ${widget.durum['mesajlasmaHizi']}');

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
              '${widget.durum['yas']} ${LocalizationHelper.translate('years_old')} - ${widget.durum['meslek']}',
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
                  const Icon(Icons.chat, color: Colors.blue, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalizationHelper.translate(
                            'communication_level_title',
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          _safeTranslateCommunicationLevel(
                            widget.durum['iletisimDurumu'] ??
                                widget.durum['iliskiDurumu'],
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
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
                  const Icon(Icons.speed, color: Colors.orange, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalizationHelper.translate('messaging_speed_title'),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          _safeTranslateMessagingSpeed(
                            widget.durum['mesajlasmaHizi'] ?? 'balanced',
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
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
                  const Icon(Icons.location_on, color: Colors.green, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalizationHelper.translate(
                            'physical_distance_title',
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          _safeTranslatePhysicalDistance(
                            widget.durum['fizikselMesafe'] ??
                                widget.durum['fizikselDurum'],
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
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
                  const Icon(Icons.favorite, color: Colors.pink, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalizationHelper.translate('emotional_state_title'),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          _safeTranslateEmotionalState(
                            widget.durum['duygusalDurum'] ??
                                widget.durum['anlikDurum'],
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
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
                  const Icon(Icons.mic, color: Colors.purple, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalizationHelper.translate(
                            'last_communication_title',
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          _safeTranslateLastCommunication(
                            widget.durum['sonIletisimTini'] ?? 'warm',
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
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
                            LocalizationHelper.translate('special_notes_label'),
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

  String _translateCommunicationLevel(String? status) {
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

  String _translateLastCommunication(String? status) {
    switch (status) {
      case 'flirty':
        return LocalizationHelper.translate('last_communication_flirty');
      case 'warm':
        return LocalizationHelper.translate('last_communication_warm');
      case 'cold':
        return LocalizationHelper.translate('last_communication_cold');
      case 'mixed':
        return LocalizationHelper.translate('last_communication_mixed');
      default:
        return LocalizationHelper.translate('last_communication_custom');
    }
  }

  // Güvenli çeviri fonksiyonları
  String _safeTranslateCommunicationLevel(String? status) {
    try {
      return _translateCommunicationLevel(status);
    } catch (e) {
      print('DEBUG: Communication level error: $e');
      return 'İletişim durumu belirtilmemiş';
    }
  }

  String _safeTranslateMessagingSpeed(String? status) {
    try {
      return _translateMessagingSpeed(status);
    } catch (e) {
      print('DEBUG: Messaging speed error: $e');
      return 'Mesajlaşma hızı belirtilmemiş';
    }
  }

  String _safeTranslatePhysicalDistance(String? status) {
    try {
      return _translatePhysicalDistance(status);
    } catch (e) {
      print('DEBUG: Physical distance error: $e');
      return 'Fiziksel mesafe belirtilmemiş';
    }
  }

  String _safeTranslateEmotionalState(String? status) {
    try {
      return _translateEmotionalState(status);
    } catch (e) {
      print('DEBUG: Emotional state error: $e');
      return 'Duygusal durum belirtilmemiş';
    }
  }

  String _safeTranslateLastCommunication(String? status) {
    try {
      return _translateLastCommunication(status);
    } catch (e) {
      print('DEBUG: Last communication error: $e');
      return 'Son iletişim belirtilmemiş';
    }
  }
}
