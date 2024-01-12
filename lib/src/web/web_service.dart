import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebService {
  final http.Client client;
  final bool isTokenBased;
  WebService({client, isTokenBased}) : client = client ?? http.Client(), isTokenBased = isTokenBased ?? false;

  Future get(Uri url) async {
    return await client.get(url);
  }

  Future post(Uri url, params) async {
    return await client.post(
      url,
      headers: _getHeaders(),
      body: jsonEncode(params)
    );
  }

  Future put(Uri url, params) async {
    return await client.put(
      url,
      headers: _getHeaders()
    );
  }

  _getHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final prefix = isTokenBased ? 'Bearer' : 'Apikey';
    final token = isTokenBased ? prefs.getString('TOKEN') : dotenv.env['API_KEY'];
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': "Apikey ${dotenv.env['API_KEY']}",
      'Authorization': "$prefix ${token ?? ''}",
    };
  }
}