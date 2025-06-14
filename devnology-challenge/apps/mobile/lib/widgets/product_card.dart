import 'package:flutter/material.dart';
import 'package:mobile/models/product.dart';
import 'package:mobile/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Acessa o nosso "cérebro" do carrinho.
    // listen: false significa que este widget não precisa ser reconstruído
    // quando o carrinho muda, ele apenas dispara ações.
    final cart = Provider.of<CartProvider>(context, listen: false);

    // Tenta converter o preço para um número, com um valor padrão de 0.0
    final price = double.tryParse(product.preco) ?? 0.0;

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      clipBehavior: Clip.antiAlias, // Garante que a imagem não "vaze" das bordas
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Imagem ---
          // A imagem agora tem uma altura fixa para garantir consistência no layout
          SizedBox(
            height: 120, // Altura fixa para a área da imagem
            child: Container(
              color: Colors.grey[200],
              child: product.imagem.isNotEmpty
                  ? Image.network(
                      product.imagem,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator(strokeWidth: 2.0));
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image_not_supported_outlined, size: 40, color: Colors.grey[400]);
                      },
                    )
                  : Center(child: Icon(Icons.shopping_bag_outlined, size: 40, color: Colors.grey[400])),
            ),
          ),

          // --- Bloco de Informações ---
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, 
              children: [
                // Nome do produto
                Text(
                  product.nome,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 12), // Espaço consistente

                // Preço
                Text(
                  'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          
          // O Spacer força o botão a ficar no fundo do espaço que sobrou no Card
          const Spacer(),

          // --- Botão ---
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Chama a função addItem do nosso CartProvider
                cart.addItem(product);

                // Mostra uma mensagem de confirmação na parte de baixo da tela
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.nome} foi adicionado ao carrinho!'),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                padding: const EdgeInsets.symmetric(vertical: 8),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Adicionar', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}

