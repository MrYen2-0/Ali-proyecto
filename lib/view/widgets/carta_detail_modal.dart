import 'package:flutter/material.dart';
import '../../model/carta_model.dart';

class CardDetailModal extends StatefulWidget {
  final MagicCard card;

  const CardDetailModal({Key? key, required this.card}) : super(key: key);

  @override
  State<CardDetailModal> createState() => _CardDetailModalState();
}

class _CardDetailModalState extends State<CardDetailModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _closeModal() {
    _controller.reverse().then((_) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeModal,
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevenir cierre al tocar el modal
            child: SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  constraints: const BoxConstraints(maxHeight: 480),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: widget.card.rarityColor.withOpacity(0.5),
                        blurRadius: 25,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      children: [
                        // Background
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF1e2139),
                                widget.card.rarityColor.withOpacity(0.2),
                              ],
                            ),
                          ),
                        ),

                        // Content
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              // Card image
                              Hero(
                                tag: 'card_${widget.card.id}',
                                child: Container(
                                  height: 220,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: widget.card.rarityColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: Image.network(
                                    widget.card.imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: const Color(0xFF2D3748),
                                        child: const Icon(
                                          Icons.broken_image,
                                          size: 50,
                                          color: Color(0xFF4A5568),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              // Card details
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Name and mana cost
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            widget.card.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: widget.card.colorGradient,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            widget.card.manaCost,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    // Type and rarity
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: widget.card.rarityColor.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(
                                              color: widget.card.rarityColor,
                                              width: 1,
                                            ),
                                          ),
                                          child: Text(
                                            widget.card.rarity.toUpperCase(),
                                            style: TextStyle(
                                              color: widget.card.rarityColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            widget.card.type,
                                            style: const TextStyle(
                                              color: Color(0xFFa0aec0),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 12),

                                    // Description
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        widget.card.description,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),

                                    // Power/Toughness
                                    if (widget.card.power.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                gradient: widget.card.colorGradient,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                '${widget.card.power}/${widget.card.toughness}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                              'POWER/TOUGHNESS',
                                              style: TextStyle(
                                                color: Color(0xFFa0aec0),
                                                fontSize: 10,
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

                        // Close button
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: _closeModal,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}