import 'package:flutter/material.dart';
import 'AppDatabase.dart';
import 'SLE.dart';
import 'Shopping_listDAO.dart';


// lab 7
class shopping_list extends StatefulWidget {

  @override
  State<shopping_list> createState() => _shopping_listState();

}

class _shopping_listState extends State<shopping_list> {

  late TextEditingController _itemNameController;
  late TextEditingController _itemQuantityController;
  late AppDatabase database;
  late Shopping_listDAO shopping_listDAO;
  List<SLE> items = [];


  @override
  void initState() {
    super.initState();
    _initializeDatabase();
    _itemNameController = TextEditingController();
    _itemQuantityController = TextEditingController();

  }

  // Initializes database and loads existing items
  Future<void> _initializeDatabase() async {
    database = await $FloorAppDatabase.databaseBuilder('shopping_list.db').build();
    shopping_listDAO = database.shopping_listDAO;
    _loadItems();
  }

  // Load items from database
  Future<void> _loadItems() async {
    final fetchedItems = await shopping_listDAO.getAllItems();
    setState(() {
      items = fetchedItems;
    });
  }

  // Add a new item to database
  Future<void> _addToList() async {
    final String name = _itemNameController.text.trim();
    final int quantity = _itemQuantityController.text.trim() as int;

    final newItem = SLE(item: name, quantity: quantity);
    await shopping_listDAO.insertItem(newItem);
    _itemNameController.clear();
    _itemQuantityController.clear();
  }

  // Remove item from database
  Future<void> _removeItem(int index) async {
    final itemToRemove = items[index];
    await shopping_listDAO.removeItem(itemToRemove);
    _loadItems();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Shopping List"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemNameController,
                    decoration: InputDecoration(labelText: "Type item name here"),
                  ),
                ),
                SizedBox(width: 10), // Spacing
                Expanded(
                  child: TextField(
                    controller: _itemQuantityController,
                    decoration: InputDecoration(labelText: "Type amount of item here"),
                  ),
                ),
                SizedBox(width: 10), // Spacing
                ElevatedButton(
                  onPressed: _addToList,
                  child: Text("Add"),
                ),
              ]
            ),
            //where we will add the input boxes for the list

            //the list
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () => _removeItem(index),
                    child: ListTile(
                      title: Text("${items[index].item}"),
                      subtitle: Text("Quantity: ${items[index].quantity}"),
                      trailing: Icon(Icons.delete, color: Colors.red),
                    ),
                  );
                }
              )
            ),
          ]
        ),
      ),
    );

  }
}
