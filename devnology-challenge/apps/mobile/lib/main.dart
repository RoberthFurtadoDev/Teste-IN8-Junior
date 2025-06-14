// lib/main.dart
import 'package:flutter/material.dart';
import 'package:mobile/providers/cart_provider.dart';
import 'package:mobile/screens/home_screen.dart';
import 'package:provider/provider.dart'; // 1. Importe o provider

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Embrulhe o MaterialApp com o ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (ctx) => CartProvider(), // Cria uma instância do nosso CartProvider
      child: MaterialApp(
        title: 'Devnology Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}