import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/item.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse('$baseUrl/items'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<void> createItem(Item item) async {
    final response = await http.post(
      Uri.parse('$baseUrl/items'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create item');
    }
  }

  Future<void> updateItem(Item item) async {
    final response = await http.put(
      Uri.parse('$baseUrl/items/${item.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }

  Future<void> deleteItem(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/items/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }
}