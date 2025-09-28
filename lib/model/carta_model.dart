import 'package:flutter/material.dart';

class MagicCard {
  final String id;
  final String name;
  final String manaCost;
  final String type;
  final String rarity;
  final String imageUrl;
  final String description;
  final String power;
  final String toughness;
  final List<String> colors;

  MagicCard({
    required this.id,
    required this.name,
    required this.manaCost,
    required this.type,
    required this.rarity,
    required this.imageUrl,
    required this.description,
    this.power = '',
    this.toughness = '',
    required this.colors,
  });

  // Método para obtener el color del borde según la rareza
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

  // Método para obtener gradiente según los colores de la carta
  LinearGradient get colorGradient {
    if (colors.isEmpty) {
      return const LinearGradient(
        colors: [Color(0xFF4A5568), Color(0xFF2D3748)],
      );
    }

    List<Color> gradientColors = colors.map((color) {
      switch (color.toLowerCase()) {
        case 'white':
          return const Color(0xFFF9FAFB);
        case 'blue':
          return const Color(0xFF3B82F6);
        case 'black':
          return const Color(0xFF1F2937);
        case 'red':
          return const Color(0xFFEF4444);
        case 'green':
          return const Color(0xFF10B981);
        default:
          return const Color(0xFF6B7280);
      }
    }).toList();

    return LinearGradient(
      colors: gradientColors.length == 1
          ? [gradientColors[0], gradientColors[0].withOpacity(0.6)]
          : gradientColors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}