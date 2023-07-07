import 'package:delta/utils/key/key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefGetProvider = FutureProvider.family((ref, String key) async {
  final controller = ref.watch(prefControllerProvider);
  final val = await controller.getPrefs(key);
  return val;
});
final prefSetProvider = FutureProvider.family((ref, String value) async {
  final controller = ref.watch(prefControllerProvider);
  final val = await controller.setPrefs(Prefs.gptApiKey, value);
  return val;
});

final prefControllerProvider = Provider<PrefController>((ref) {
  return PrefController();
});

class PrefController {
// Obtain shared preferences.

  Future<SharedPreferences> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<bool> setPrefs(String key, String value) async {
    final prefs = await init();
    final res = await prefs.setString(key, value);

    return res;
  }

  Future<String?> getPrefs(String key) async {
    final prefs = await init();
    final res = prefs.getString(key);

    return res;
  }
}
