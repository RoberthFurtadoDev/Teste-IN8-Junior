// lib/widgets/cart_item_tile.dart
import 'package:flutter/material.dart';
import 'package:mobile/models/cart_item.dart';
import 'package:mobile/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatelessWidget {
  final String productId;
  final CartItem cartItem;

  const CartItemTile({
    super.key,
    required this.productId,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    // O Dismissible permite arrastar o item para o lado para removê-lo
    return Dismissible(
      key: ValueKey(productId),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      direction: DismissDirection.endToStart, // Só permite arrastar da direita para a esquerda
      onDismissed: (direction) {
        // Chama a função para remover o item do carrinho
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('R\$${double.parse(cartItem.product.preco).toStringAsFixed(2)}'),
                ),
              ),
            ),
            title: Text(cartItem.product.nome),
            subtitle: Text('Total: R\$ ${(double.parse(cartItem.product.preco) * cartItem.quantity).toStringAsFixed(2)}'),
            trailing: Text('${cartItem.quantity} x'),
          ),
        ),
      ),
    );
  }
}