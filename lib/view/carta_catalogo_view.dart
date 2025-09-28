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
              _buildSearchBar(context),
              _buildRarityFilter(context),
              Expanded(child: _buildCardGrid(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6B46C1), Color(0xFF9333EA)],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF9333EA).withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Magic: The Gathering',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Card Catalog',
                  style: TextStyle(
                    color: Color(0xFFa0aec0),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1e2139),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF4A5568).withOpacity(0.3),
          ),
        ),
        child: TextField(
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: 'Search cards...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 13),
            prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.5), size: 18),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
          onChanged: (value) {
            context.read<CardViewModel>().updateSearch(value);
          },
        ),
      ),
    );
  }

  Widget _buildRarityFilter(BuildContext context) {
    final viewModel = context.watch<CardViewModel>();
    final rarities = ['all', 'common', 'uncommon', 'rare', 'mythic'];

    return Container(
      height: 45,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: rarities.length,
        itemBuilder: (context, index) {
          final rarity = rarities[index];
          final isSelected = viewModel.filterRarity == rarity;

          return GestureDetector(
            onTap: () => viewModel.updateRarityFilter(rarity),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                  colors: [Color(0xFF6B46C1), Color(0xFF9333EA)],
                )
                    : null,
                color: isSelected ? null : const Color(0xFF1e2139),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : const Color(0xFF4A5568).withOpacity(0.3),
                ),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: const Color(0xFF9333EA).withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ]
                    : null,
              ),
              child: Center(
                child: Text(
                  rarity.toUpperCase(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFFa0aec0),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          );
        },
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
        crossAxisCount: 3, // Más columnas para items más pequeños
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