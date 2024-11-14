import 'package:flutter/material.dart';
import '../api_service.dart';
import '../models/item.dart';
import 'item_detail__screen.dart';
import 'item_form_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final fetchedItems = await apiService.fetchItems();
    setState(() {
      items = fetchedItems;
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Thrifty Collection - Danu Wardana (1202213054)',
          style: TextStyle(
            color: Color(0xFF2D3436),
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            color: Color(0xFFE5E9F2),
            height: 1.0,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              elevation: 2,
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailScreen(item: items[index]),
                    ),
                  );
                  if (result == true) fetchItems();
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFF6C5CE7).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: Color(0xFF6C5CE7),
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[index].name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2D3436),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              items[index].category,
                              style: TextStyle(
                                color: Color(0xFF636E72),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '\$${items[index].price}',
                              style: TextStyle(
                                color: Color(0xFF6C5CE7),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF636E72),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF6C5CE7),
        child: Icon(Icons.add),
        elevation: 4,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemFormScreen(),
            ),
          );
          if (result == true) fetchItems();
        },
      ),
    );
  }
}