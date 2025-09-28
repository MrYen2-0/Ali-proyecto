import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/carta_viewmodel.dart';
import '../model/carta_model.dart';
import 'widgets/carta_grid_item.dart';
import 'widgets/carta_detail_modal.dart';

class CardCatalogView extends StatelessWidget {
  const CardCatalogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cards = context.watch<CardViewModel>().cards;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0a0e27), Color(0xFF1a1f3a), Color(0xFF2a1a4a)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Magic: The Gathering',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid de cartas
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return CardGridItem(
                      card: cards[index],
                      onTap: () => _showCardDetail(context, cards[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCardDetail(BuildContext context, MagicCard card) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CardDetailModal(card: card),
    );
  }
}