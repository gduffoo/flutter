import 'package:shared_preferences/shared_preferences.dart';
import 'package:teslo_shop/features/shared/infraestructure/services/key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getvalue<T>(String key) async {
    final prefs = await getSharedPrefs();
    switch (T) {
      case int:
        return prefs.getInt(key) as T?;
      case String:
        return prefs.getString(key) as T?;
      case double:
        return prefs.getDouble(key) as T?;
      default:
        throw UnimplementedError("get no implmentado para ese tipo");
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();
    switch (T) {
      case int:
        await prefs.setInt(key, value as int);
        break;
      case String:
        await prefs.setString(key, value as String);
        break;
      case double:
        await prefs.setDouble(key, value as double);
        break;
      default:
        throw UnimplementedError("Set no implmentado para ese tipo");
    }
  }
}
