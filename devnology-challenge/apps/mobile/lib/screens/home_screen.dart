// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/services/api_service.dart';
import 'package:mobile/widgets/product_card.dart';
import 'package:mobile/widgets/cart_badge.dart'; // 1. Importe o CartBadge
import 'package:mobile/screens/cart_screen.dart'; // 2. Importe a CartScreen

class HomeScreen extends StatefulWidget {
  //... (código do StatefulWidget sem alterações)
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //... (código do _HomeScreenState sem alterações)
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devnology Store'),
        backgroundColor: Colors.blue[700],
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        // 3. Adicione a seção de ações ao AppBar
        actions: <Widget>[
          CartBadge(
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                // Navega para a tela do carrinho quando o ícone é pressionado
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        // ... (código do FutureBuilder sem alterações)
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } 
          else if (snapshot.hasData) {
            final products = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.6,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            );
          }
          return const Center(child: Text('Nenhum produto encontrado.'));
        },
      ),
    );
  }
}