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
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevenir cierre al tocar la imagen
            child: SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
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
                  child: Stack(
                    children: [
                      // Card image - Imagen completa
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Hero(
                          tag: 'card_${widget.card.id}',
                          child: Image.network(
                            widget.card.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 300,
                                height: 400,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2D3748),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Color(0xFF4A5568),
                                  ),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 300,
                                height: 400,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2D3748),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: widget.card.rarityColor,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Close button - Botón de cerrar
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: _closeModal,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: widget.card.rarityColor,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
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
    );
  }
}