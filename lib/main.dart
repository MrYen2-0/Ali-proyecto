import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/carta_viewmodel.dart';
import 'view/carta_catalogo_view.dart';

void main() {
  runApp(const MagicCatalogApp());
}

class MagicCatalogApp extends StatelessWidget {
  const MagicCatalogApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardViewModel(),
      child: MaterialApp(
        title: 'Magic Card Catalog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: const CardCatalogView(),
      ),
    );
  }
}