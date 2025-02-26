import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'OtherPage.dart';
import 'user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is ready
  UserRepository userRepository = UserRepository();
  await userRepository.loadData(); // Load stored data before app starts

  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    initialRoute: '/',  // The default (starting) route
    routes: {
      '/': (context) => MyHomePage(title: 'Flutter Demo Home Page', userRepository: userRepository),
      '/otherPage': (context) => OtherPage(userRepository: userRepository),      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final UserRepository userRepository;

  const MyHomePage({Key? key, required this.title, required this.userRepository}) : super(key: key);

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
    _loginController = TextEditingController(text: widget.userRepository.firstName);
    _passwordController = TextEditingController(text: widget.userRepository.lastName);
  }

  @override
  void dispose() {
    widget.userRepository.firstName = _loginController.text;
    widget.userRepository.lastName = _passwordController.text;
    widget.userRepository.saveData(); // Save data before exiting
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

  //increments the counter
  void _incrementCounter() {
    setState(() {
      if (_counter < 99.0) _counter++;
    });
  }

  //checks if password matches
  void _handlePasswordSubmission(String password) {
    setState(() {
      if (password == "QWERTY123") {
        _imagePath = "images/img_1.png";
      } else {
        _imagePath = "images/img_2.png";
      }
    });
  }

  //what happens when login button is clicked
  void _handleLogin() {
    //Navigator.pushNamed(context, '/otherPage'); // brings to other page
    _showOptionsDialog();
    //_handlePasswordSubmission(_passwordController.text);

  }

  //handles details of logging in
  void _otherPageLogin(String password) {
    if (password == "QWERTY123") {
      Navigator.pushNamed(context, '/otherPage');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect password.")),
      );
    }

  }

  // lab 4
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
                _otherPageLogin(_passwordController.text);
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
    //_handlePasswordSubmission(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // body start
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

