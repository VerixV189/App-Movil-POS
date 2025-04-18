import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/services/API/server_url.dart';
class Storage {
    static Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      Server.TOKEN,
      token,
    ); // Guarda el token en shared_preferences
  }

  // Método para obtener el token
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Server.TOKEN);
  }

  static Future<void> revokeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(Server.TOKEN);
  }
}
