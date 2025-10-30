import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LangUtils {
  static Map<String, dynamic>? _cache;

  static Future<Map<String, dynamic>> load(String code) async {
    if (_cache != null && _cache!['code'] == code) return _cache!['data'];
    final s = await rootBundle.loadString('assets/lang/' + code + '.json');
    final json = jsonDecode(s);
    _cache = {'code': code, 'data': json};
    return json;
  }

  static Future<String> t(String code, String key) async {
    final map = await load(code);
    return map[key] ?? key;
  }
}
