import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'user_repository.dart';



class OtherPage extends StatefulWidget {
  final UserRepository userRepository;
  const OtherPage({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<OtherPage> createState() => OtherPageState();
}

class OtherPageState extends State<OtherPage> {

  // Text editing controllers
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.userRepository.firstName);
    _lastNameController = TextEditingController(text: widget.userRepository.lastName);
    _phoneNumberController = TextEditingController(text: widget.userRepository.phoneNumber);
    _emailController = TextEditingController(text: widget.userRepository.email);
    // Load user data
    _loadData();
  }

  Future<void> _loadData() async {
    await widget.userRepository.loadData();
    setState(() {
      _firstNameController.text = widget.userRepository.firstName;
      _lastNameController.text = widget.userRepository.lastName;
      _phoneNumberController.text = widget.userRepository.phoneNumber;
      _emailController.text = widget.userRepository.email;
    });
  }

// text editing controller disposing
  @override
  void dispose() {
    widget.userRepository.firstName = _firstNameController.text;
    widget.userRepository.lastName = _lastNameController.text;
    widget.userRepository.phoneNumber = _phoneNumberController.text;
    widget.userRepository.email = _emailController.text;
    widget.userRepository.saveData(); // Save data on exit

    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Function to launch phone dialer
  void _makePhoneCall() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: _phoneNumberController.text);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch dialer")),
      );
    }
  }

  // Function to send an SMS
  void _sendSMS() async {
    final Uri smsUri = Uri(scheme: 'sms', path: _phoneNumberController.text);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open SMS app")),
      );
    }
  }

  // Function to send an email
  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _emailController.text,
      queryParameters: {
        'subject': 'Hello',
        'body': 'This is a pre-filled email body.'
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open email app")),
      );
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Other Page')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: "First Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16), // Adds spacing
                  TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16), // Adds spacing
                  Row(
                    children: <Widget>[
                      Expanded( // Ensures TextField takes available space inside Row
                        child: TextField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone, // Ensures correct keyboard layout
                          decoration: const InputDecoration(
                            labelText: "Phone Number",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8), // Space between TextField and Button
                      IconButton(
                        icon: const Icon(Icons.phone, color: Colors.blue),
                        onPressed: _makePhoneCall, // Calls the function to launch dialer
                      ),
                      IconButton(
                        icon: const Icon(Icons.message, color: Colors.green),
                        onPressed: _sendSMS, // Calls the function to send SMS
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // Adds spacing
                  // Email with Email Button
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email Address",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8), // Space between TextField and Button
                      IconButton(
                        icon: const Icon(Icons.email, color: Colors.red),
                        onPressed: _sendEmail,
                      ),
                    ],
                  ),
                ]
            ),
          ),
        )
    ); //Use a Scaffold to layout a page with an AppBar and main body region
  }
}
