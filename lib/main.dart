import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  final EncryptedSharedPreferences _encryptedPrefs = EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _loadSavedData();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Method to load saved username and password on app start
  void _loadSavedData() async {
    String? savedUsername = await _encryptedPrefs.getString("username");
    String? savedPassword = await _encryptedPrefs.getString("password");

    if (savedUsername != null && savedPassword != null) {
      setState(() {
        _loginController.text = savedUsername;
        _passwordController.text = savedPassword;
      });

      // Show SnackBar with "Undo" action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Previous login name and password loaded."),
          action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              // Clear the TextFields but keep the saved data in SharedPreferences
              setState(() {
                _loginController.text = "";
                _passwordController.text = "";
              });
            },
          ),
        ),
      );
    }
  }

  void _incrementCounter() {
    setState(() {
      if (_counter < 99.0) _counter++;
    });
  }

  void _handlePasswordSubmission(String password) {
    setState(() {
      if (password == "QWERTY123") {
        _imagePath = "images/img_1.png";
      } else {
        _imagePath = "images/img_2.png";
      }
    });
  }

  void _handleLogin() {
    _showOptionsDialog();
  }

  void _showOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save User Information?'),
          content: const Text('Would you like to save your username and password?'),
          actions: <Widget>[
            TextButton(
              child: const Text("Save"),
              onPressed: () async {
                await _encryptedPrefs.setString("username", _loginController.text);
                await _encryptedPrefs.setString("password", _passwordController.text);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Information saved.")),
                );
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () async {
                await _encryptedPrefs.remove("username");
                await _encryptedPrefs.remove("password");
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Information deleted.")),
                );
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () async {
                await _encryptedPrefs.remove("username");
                await _encryptedPrefs.remove("password");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              decoration: const InputDecoration(
                labelText: "Login",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onSubmitted: _handlePasswordSubmission,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text("Login"),
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
      ),
    );
  }
}

