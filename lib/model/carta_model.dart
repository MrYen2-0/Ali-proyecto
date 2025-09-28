import 'package:flutter/material.dart';

class MagicCard {
  final String id;
  final String name;
  final String imageUrl;
  final String rarity;

  MagicCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rarity,
  });

  Color get rarityColor {
    switch (rarity.toLowerCase()) {
      case 'mythic':
        return const Color(0xFFFF6B35);
      case 'rare':
        return const Color(0xFFFFD23F);
      case 'uncommon':
        return const Color(0xFFC0C0C0);
      default:
        return const Color(0xFF8B8B8B);
    }
  }
}