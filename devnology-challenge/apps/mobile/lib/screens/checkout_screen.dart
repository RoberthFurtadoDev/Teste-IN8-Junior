// lib/screens/checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:mobile/providers/cart_provider.dart';
import 'package:mobile/services/api_service.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  final _customerData = {
    'name': '',
    'email': '',
    'address': '',
  };

  Future<void> _submitOrder() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    _formKey.currentState?.save();
    setState(() { _isLoading = true; });

    final cart = Provider.of<CartProvider>(context, listen: false);

    try {
      await ApiService.createOrder(
        cart.items.values.toList(),
        cart.totalAmount,
        _customerData,
      );
      cart.clear();
      Navigator.of(context).popUntil((route) => route.isFirst);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Compra realizada com sucesso!'), backgroundColor: Colors.green),
      );
    } catch (error) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao registrar pedido: $error'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finalizar Compra'),
         backgroundColor: Colors.blue[700],
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome Completo'),
                textInputAction: TextInputAction.next,
                validator: (value) => value!.isEmpty ? 'Por favor, insira seu nome.' : null,
                onSaved: (value) => _customerData['name'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => !(value?.contains('@') ?? false) ? 'Por favor, insira um e-mail válido.' : null,
                onSaved: (value) => _customerData['email'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Endereço'),
                textInputAction: TextInputAction.done,
                 validator: (value) => value!.isEmpty ? 'Por favor, insira seu endereço.' : null,
                onSaved: (value) => _customerData['address'] = value!,
                 onFieldSubmitted: (_) => _submitOrder(),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ElevatedButton(
                  onPressed: _submitOrder,
                  child: const Text('Confirmar Pedido'),
                )
            ],
          ),
        ),
      ),
    );
  }
}
