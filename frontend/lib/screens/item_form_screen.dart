import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api_service.dart';
import '../models/item.dart';

class ItemFormScreen extends StatefulWidget {
  final Item? item;

  ItemFormScreen({this.item});

  @override
  _ItemFormScreenState createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? category;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      nameController.text = widget.item!.name;
      priceController.text = widget.item!.price.toString();
      descriptionController.text = widget.item!.description;
      category = widget.item!.category;
    }
  }

  Future<void> submit() async {
    final item = Item(
      id: widget.item?.id,
      name: nameController.text,
      category: category ?? '',
      price: double.parse(priceController.text),
      description: descriptionController.text,
    );
    try {
      if (widget.item == null) {
        await apiService.createItem(item);
        Fluttertoast.showToast(
            msg: 'Item berhasil dibuat',
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        await apiService.updateItem(item);
        Fluttertoast.showToast(
            msg: 'Item berhasil diupdate',
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      Navigator.pop(context, true);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Gagal menyimpan item',
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red.shade600,
          textColor: Colors.white,
          fontSize: 16.0
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF2D3436)),
        title: Text(
          widget.item == null ? 'Add Item' : 'Edit Item',
          style: TextStyle(
            color: Color(0xFF2D3436),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Color(0xFF636E72)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFE5E9F2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF6C5CE7)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: category,
                    items: ['T-Shirt', 'Hoodie', 'Pants']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() => category = value),
                    decoration: InputDecoration(
                      labelText: 'Category',
                      labelStyle: TextStyle(color: Color(0xFF636E72)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFE5E9F2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF6C5CE7)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      prefixText: '\$ ',
                      labelStyle: TextStyle(color: Color(0xFF636E72)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFE5E9F2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF6C5CE7)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(color: Color(0xFF636E72)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFE5E9F2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFF6C5CE7)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: submit,
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6C5CE7),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
