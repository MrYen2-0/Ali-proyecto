import 'package:flutter/material.dart';
import '../model/carta_model.dart';

class CardViewModel extends ChangeNotifier {
  final List<MagicCard> _cards = [
    MagicCard(
      id: '1',
      name: 'Black Lotus',
      rarity: 'Mythic',
      imageUrl: 'https://cards.scryfall.io/large/front/b/d/bd8fa327-dd41-4737-8f19-2cf5eb1f7cdd.jpg',
    ),
    MagicCard(
      id: '2',
      name: 'Lightning Bolt',
      rarity: 'Common',
      imageUrl: 'https://cards.scryfall.io/large/front/f/2/f29ba16f-c8fb-42fe-aabf-87089cb214a7.jpg',
    ),
    MagicCard(
      id: '3',
      name: 'Counterspell',
      rarity: 'Uncommon',
      imageUrl: 'https://cards.scryfall.io/large/front/a/4/a457f404-ddf1-40fa-b0f0-23c8598533f4.jpg',
    ),
    MagicCard(
      id: '4',
      name: 'Serra Angel',
      rarity: 'Rare',
      imageUrl: 'https://cards.scryfall.io/large/front/8/8/88aded20-4d0c-4e96-bc56-4781f6a6e0e3.jpg',
    ),
    MagicCard(
      id: '5',
      name: 'Dark Ritual',
      rarity: 'Common',
      imageUrl: 'https://cards.scryfall.io/large/front/9/5/95f27eeb-6f14-4db3-adb9-9be5ed76b34b.jpg',
    ),
    MagicCard(
      id: '6',
      name: 'Giant Growth',
      rarity: 'Common',
      imageUrl: 'https://cards.scryfall.io/large/front/0/6/06ec9e8b-4bd8-4caf-a559-6514b7ab4ca4.jpg',
    ),
  ];

  List<MagicCard> get cards => _cards;
}