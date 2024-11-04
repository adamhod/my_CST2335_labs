import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _imagePath = "images/img.png";
  SharedPreferences? _prefs;



  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _setPrefs();
  }

  void _setPrefs() {
    _prefs?.setString("loginName","_loginController");

  }

  void _getPrefs() {
    _prefs?.getString("loginName");
  }

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
    _initPrefs();
  }

  Widget yesButton = TextButton(
    child: Text("Yes"),
    onPressed:  () {
      EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
      prefs.getString("Name").then( (name) {
        if(name.isNotEmpty){
          //show a Snackbar
        }
      });

    },
  );

  Widget noButton = TextButton(
    child: Text("No"),
    onPressed:  () {},
  );

  @override
  void dispose()
  {
    super.dispose();
    _loginController.dispose();    // clean up memory
    _passwordController.dispose();
  }

  void buttonClicked(){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password: ${_passwordController.text}'),
        ),
      );
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(""),
          content: const Text('Would you like to save your '
              'username and password?'),
          actions: <Widget>[
            yesButton,
            noButton,
          ],
        ),
      );
  }

  void _handlePasswordSubmission(String password) {
    setState(() {
      if (password == "QWERTY123") {
        _imagePath = "images/img_1.png"; // Path to the first image
      } else {
        _imagePath = "images/img_2.png"; // Path to the second image
      }
    });
  }

  // Load and obtain the shared preferences for this app.
  void functionName() async {
    final prefs = await SharedPreferences.getInstance();
  }

  void _handleLogin() {
    String name = _loginController.text.trim();
    String password = _passwordController.text;
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
                obscureText:true,
              onSubmitted: _handlePasswordSubmission,
            ),
            ElevatedButton(
                onPressed: _handleLogin,
                child:  Text("Login")
            ),
            Image.asset(
              _imagePath,
              width: 300,
              height: 300,
            ),
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

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed:  () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
