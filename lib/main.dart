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
  double _counter = 0.0;
  double myFontSize = 30.0;
  late TextEditingController _loginController;
  late TextEditingController _passwordController;

  void setNewValue(double value)
  {
    setState(() {
      _counter = value;
      myFontSize = value;
    });
  }

  void _incrementCounter() {
    setState(() {
      if (_counter < 99.0)
      _counter++;
    });
  }

  @override //same as in java
  void initState() {
    super.initState(); //call the parent initState()
    _loginController = TextEditingController();//our late constructor
    _passwordController = TextEditingController();
  }


  @override
  void dispose()
  {
    super.dispose();
    _loginController.dispose();    // clean up memory
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextField(
              controller: _loginController,
              decoration: InputDecoration(
                labelText: "Login",
                border: OutlineInputBorder(),
              )
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
                obscureText:true
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
