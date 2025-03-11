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

  Future<void> _initializeDatabase() async {
    database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final SLE = await database.shopping_listDAO.findAllItems();
    setState(() {
      words = SLE;
    });
  }


  void _addToList() {
    setState(() {

      if (_itemName.text.isNotEmpty && _itemCount.text.isNotEmpty) {
        words.add({
          "item": _itemName.text,
          "quantity": _itemCount.text
        });
      }

      _itemName.clear();
      _itemCount.clear();
    });
  }
  
  //removes item from list
  void _removeItem(int index) {
    setState(() {
      words.removeAt(index);
    });
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
