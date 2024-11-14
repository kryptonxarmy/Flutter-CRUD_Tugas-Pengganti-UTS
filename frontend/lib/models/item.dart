class Item {
  final int? id;
  final String name;
  final String category;
  final double price;
  final String description;

  Item({
    this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'].toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson({bool includeId = false}) {
    final data = {
      'name': name,
      'category': category,
      'price': price,
      'description': description,
    };
    if (includeId && id != null) {
      data['id'] = id as Object;
    }
    return data;
  }
}