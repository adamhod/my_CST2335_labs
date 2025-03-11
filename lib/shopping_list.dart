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

  late TextEditingController _itemName;
  late TextEditingController _itemCount;
  late AppDatabase database;
  List<Map<String, String>> words = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
    _itemName = TextEditingController();
    _itemCount = TextEditingController();
  }

  /// Initializes the database and loads existing items
  Future<void> _initializeDatabase() async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    _loadItems();
  }

  /// Loads all items from the database and updates the list
  Future<void> _loadItems() async {
    final items = await database.shopping_listDAO.findAllItems();
    setState(() {
      words = items.map((sle) => {"id": sle.id.toString(), "item": sle.item, "quantity": sle.quantity}).toList();
    });
  }



  /// Removes an item from the list and deletes it from the database
  Future<void> _removeItem(int index) async {
    final id = int.tryParse(words[index]["id"] ?? "");

    if (id != null) {
    final sleToDelete = SLE(id: id, item: words[index]["item"]!, quantity: words[index]["quantity"]!);
    await database.shopping_listDAO.deleteItem(sleToDelete);
    _loadItems(); // Refresh UI
    }
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
                    controller: _itemName,
                    decoration: InputDecoration(labelText: "Type item name here"),
                  ),
                ),
                SizedBox(width: 10), // Spacing
                Expanded(
                  child: TextField(
                    controller: _itemCount,
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
              child: Container(
                alignment: Alignment.center,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () => _removeItem(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${index + 1}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("${words[index]['item']}, Quantity: ${words[index]['quantity']}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ]
        ),
      ),
    );

  }
}
