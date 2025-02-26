import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class UserRepository {
  final EncryptedSharedPreferences _encryptedPrefs = EncryptedSharedPreferences();

  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String email = '';

  // Load user data from EncryptedSharedPreferences
  Future<void> loadData() async {
    firstName = await _encryptedPrefs.getString("first_name") ?? '';
    lastName = await _encryptedPrefs.getString("last_name") ?? '';
    phoneNumber = await _encryptedPrefs.getString("phone_number") ?? '';
    email = await _encryptedPrefs.getString("email") ?? '';
  }

  // Save user data to EncryptedSharedPreferences
  Future<void> saveData() async {
    await _encryptedPrefs.setString("first_name", firstName);
    await _encryptedPrefs.setString("last_name", lastName);
    await _encryptedPrefs.setString("phone_number", phoneNumber);
    await _encryptedPrefs.setString("email", email);
  }
}