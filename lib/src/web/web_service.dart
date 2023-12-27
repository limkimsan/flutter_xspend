import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WebService {
  final http.Client client;
  WebService({client}) : client = client ?? http.Client();

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

  _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Apikey ${dotenv.env['API_KEY']}",
    };
  }
}