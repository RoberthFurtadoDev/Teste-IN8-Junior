import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

class Product {
    final String id;
    final String nome;
    final String descricao;
    final String preco;
    final String imagem;
    final String origin;

    Product({
        required this.id,
        required this.nome,
        required this.descricao,
        required this.preco,
        required this.imagem,
        required this.origin,
    });

    // A mágica da correção está toda neste método 'fromJson'
    factory Product.fromJson(Map<String, dynamic> json) => Product(
        // Para cada campo, usamos o operador '??' para fornecer um valor padrão
        // caso o campo venha como 'null' da API.
        id: json["id"] ?? 'id_desconhecido', 
        nome: json["nome"] ?? json["name"] ?? 'Nome indisponível',
        descricao: json["descricao"] ?? json["description"] ?? 'Sem descrição.',
        preco: json["preco"] ?? '0.00',
        imagem: json["imagem"] ?? '', // Se a imagem for nula, usa uma string vazia
        origin: json["origin"] ?? 'N/A',
    );
}
