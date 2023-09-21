class Env {
 

  static const Map<String, String> _keys = {
    'KEY_APPLICATION_ID': String.fromEnvironment('KEY_APPLICATION_ID'),
    'KEY_CLIENT_KEY': String.fromEnvironment('KEY_CLIENT_KEY'),
    'KEY_PARSE_SERVER_URL': String.fromEnvironment('KEY_PARSE_SERVER_URL')
  };

  static String _getKey(String key) {
    final value = _keys[key] ?? '';
    if (value.isEmpty) {
      throw Exception('$key is not set in Env');
    }
    return value;
  }

 static  String get keyApplicationId  => _getKey('KEY_APPLICATION_ID');
 static  String get keyClientKey => _getKey('KEY_CLIENT_KEY');
 static  String get keyParseServerUrl  => _getKey('KEY_PARSE_SERVER_URL');
}
