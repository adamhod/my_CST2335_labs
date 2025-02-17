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
        body: Center(child: Text('Welcome to Other Page!'))
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}
