// lib/widgets/cart_badge.dart

import 'package:flutter/material.dart';
import 'package:mobile/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({
    super.key,
    required this.child,
  });

  // O widget 'filho' será o nosso ícone do carrinho
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // O Consumer reconstrói este widget sempre que o CartProvider notifica uma alteração
    return Consumer<CartProvider>(
      builder: (ctx, cart, _) => Stack(
        alignment: Alignment.center,
        children: [
          child, // O ícone do carrinho
          // O contador vermelho (badge) só aparece se houver itens no carrinho
          if (cart.totalItems > 0)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.red,
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  cart.totalItems.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}