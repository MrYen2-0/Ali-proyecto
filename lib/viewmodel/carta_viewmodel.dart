import 'package:flutter/material.dart';
import '../model/carta_model.dart';

class CardViewModel extends ChangeNotifier {
  List<MagicCard> _cards = [];
  MagicCard? _selectedCard;

  List<MagicCard> get cards => _cards;
  MagicCard? get selectedCard => _selectedCard;

  CardViewModel() {
    _loadCards();
  }

  // Cargar datos de cartas
  void _loadCards() {
    _cards = [
      MagicCard(
        id: '1',
        name: 'Black Lotus',
        manaCost: '0',
        type: 'Artifact',
        rarity: 'Mythic',
        imageUrl: 'https://cards.scryfall.io/large/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.jpg',
        description: 'Sacrifice Black Lotus: Add three mana of any one color.',
        colors: ['black'],
      ),
      MagicCard(
        id: '2',
        name: 'Lightning Bolt',
        manaCost: 'R',
        type: 'Instant',
        rarity: 'Common',
        imageUrl: 'https://cards.scryfall.io/large/front/f/2/f29ba16f-c8fb-42fe-aabf-87089cb214a7.jpg',
        description: 'Lightning Bolt deals 3 damage to any target.',
        colors: ['red'],
      ),
      MagicCard(
        id: '3',
        name: 'Counterspell',
        manaCost: 'UU',
        type: 'Instant',
        rarity: 'Uncommon',
        imageUrl: 'https://cards.scryfall.io/large/front/a/4/a457f404-ddf1-40fa-b0f0-23c8598533f4.jpg',
        description: 'Counter target spell.',
        colors: ['blue'],
      ),
      MagicCard(
        id: '4',
        name: 'Serra Angel',
        manaCost: '3WW',
        type: 'Creature — Angel',
        rarity: 'Rare',
        imageUrl: 'https://cards.scryfall.io/large/front/8/8/88aded20-4d0c-4e96-bc56-4781f6a6e0e3.jpg',
        description: 'Flying, vigilance',
        power: '4',
        toughness: '4',
        colors: ['white'],
      ),
      MagicCard(
        id: '5',
        name: 'Dark Ritual',
        manaCost: 'B',
        type: 'Instant',
        rarity: 'Common',
        imageUrl: 'https://cards.scryfall.io/large/front/9/5/95f27eeb-6f14-4db3-adb9-9be5ed76b34b.jpg',
        description: 'Add BBB.',
        colors: ['black'],
      ),
      MagicCard(
        id: '6',
        name: 'Giant Growth',
        manaCost: 'G',
        type: 'Instant',
        rarity: 'Common',
        imageUrl: 'https://cards.scryfall.io/large/front/0/6/06ec9e8b-4bd8-4caf-a559-6514b7ab4ca4.jpg',
        description: 'Target creature gets +3/+3 until end of turn.',
        colors: ['green'],
      ),
      MagicCard(
        id: '7',
        name: 'Jace, the Mind Sculptor',
        manaCost: '2UU',
        type: 'Planeswalker — Jace',
        rarity: 'Mythic',
        imageUrl: 'https://cards.scryfall.io/large/front/c/0/c057dc0d-4017-4e60-9c5e-45fc569a8d31.jpg',
        description: '+2: Look at the top card of target player\'s library.',
        colors: ['blue'],
      ),
      MagicCard(
        id: '8',
        name: 'Shivan Dragon',
        manaCost: '4RR',
        type: 'Creature — Dragon',
        rarity: 'Rare',
        imageUrl: 'https://cards.scryfall.io/large/front/2/2/227cf1b5-f85b-41fe-be98-66e383652039.jpg',
        description: 'Flying. R: Shivan Dragon gets +1/+0 until end of turn.',
        power: '5',
        toughness: '5',
        colors: ['red'],
      ),
    ];
    notifyListeners();
  }

  // Seleccionar carta
  void selectCard(MagicCard? card) {
    _selectedCard = card;
    notifyListeners();
  }

  // Limpiar selección
  void clearSelection() {
    _selectedCard = null;
    notifyListeners();
  }
}