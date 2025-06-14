// lib/services/api_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:mobile/models/cart_item.dart';
import 'package:mobile/models/product.dart';

class ApiService {
  static final String _baseUrl = kIsWeb ? 'http://localhost:3000' : 'http://10.0.2.2:3000';

  static Future<List<Product>> getProducts() async {
    // ... (código do getProducts sem alterações)
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));
      if (response.statusCode == 200) {
        return productFromJson(response.body);
      } else {
        throw Exception('Falha ao carregar produtos');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Novo método para criar o pedido
  static Future<void> createOrder(List<CartItem> cartItems, double total, Map<String, String> customerData) async {
    final url = Uri.parse('$_baseUrl/orders');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'products': cartItems.map((ci) => {
            'id': ci.product.id,
            'nome': ci.product.nome,
            'preco': ci.product.preco,
            'quantity': ci.quantity
          }).toList(),
          'total': total,
          'customer': customerData,
        }),
      );

      if (response.statusCode >= 400) {
        throw Exception('Falha ao criar pedido: ${response.body}');
      }
    } catch (error) {
      rethrow;
    }
  }
}
