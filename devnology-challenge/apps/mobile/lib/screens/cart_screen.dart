import 'package:flutter/material.dart';
import 'package:mobile/providers/cart_provider.dart';
import 'package:mobile/screens/checkout_screen.dart'; // Importa a tela de checkout
import 'package:mobile/widgets/cart_item_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Acessa o estado do carrinho para obter os itens e o total
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu Carrinho'),
        backgroundColor: Colors.blue[700],
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: <Widget>[
          // Card com o resumo do total
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Total', style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  Chip(
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    // Desabilita o botão se o carrinho estiver vazio
                    onPressed: cart.items.isEmpty
                        ? null
                        : () {
                            // Navega para a tela de checkout quando o botão é pressionado
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const CheckoutScreen(),
                              ),
                            );
                          },
                    child: const Text('FINALIZAR COMPRA'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // A lista de itens do carrinho
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItemTile(
                // Passa os dados necessários para o widget de item do carrinho
                productId: cart.items.keys.toList()[i],
                cartItem: cart.items.values.toList()[i],
              ),
            ),
          )
        ],
      ),
    );
  }
}
