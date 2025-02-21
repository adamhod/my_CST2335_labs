import 'package:flutter/material.dart';

class OtherPage extends StatefulWidget {
  @override
  State<OtherPage> createState() => OtherPageState();
}

class OtherPageState extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Other Page')),
        body: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                  ),

                ]
              ),
            ]
        ),
        )
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}
