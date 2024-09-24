import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
                "Brows Catagories", style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold)
            ),
            Text(" "),
            Text(
                "Not sure about exactly which recipe you're looking for? Do a search,"
                    " or dive into our most popular catagories"
            ),
            Text(" "),
            Text(
                "By Meat", style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold)
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                      children: <Widget>[
                        Image.asset("images/beef.jpg"),
                        Text(
                          "BEEF", style: TextStyle(fontSize: 10.0, backgroundColor:Colors.white ),
                        )
                      ]),

                ]
            ),
          ],
        ),
      ),
    );
  }
}
