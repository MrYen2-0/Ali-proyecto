import 'package:flutter/material.dart';
import '../../model/carta_model.dart';

class CardGridItem extends StatelessWidget {
  final MagicCard card;
  final VoidCallback onTap;

  const CardGridItem({
    Key? key,
    required this.card,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: card.rarityColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: card.rarityColor.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            card.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFF2D3748),
                child: const Icon(
                  Icons.broken_image,
                  color: Color(0xFF4A5568),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}