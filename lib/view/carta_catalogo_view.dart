import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/carta_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/carta_viewmodel.dart';
import 'widgets/carta_grid_item.dart';
import 'widgets/carta_detail_modal.dart';

class CardCatalogView extends StatelessWidget {
  const CardCatalogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0a0e27),
              Color(0xFF1a1f3a),
              Color(0xFF2a1a4a),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(child: _buildCardGrid(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Text(
        'Magic: The Gathering',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCardGrid(BuildContext context) {
    final viewModel = context.watch<CardViewModel>();
    final cards = viewModel.cards;

    if (cards.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 50,
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(height: 12),
            Text(
              'No cards found',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
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
          onTap: () {
            viewModel.selectCard(cards[index]);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => CardDetailModal(card: cards[index]),
            );
          },
        );
      },
    );
  }
}