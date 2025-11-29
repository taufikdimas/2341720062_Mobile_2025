import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/pizza.dart';

class HttpHelper {
  // Singleton pattern
  static final HttpHelper _httpHelper = HttpHelper._internal();
  HttpHelper._internal();
  factory HttpHelper() {
    return _httpHelper;
  }

  final String authority = '24y7w.wiremockapi.cloud';
  final String path = 'pizza';

  Future<List<Pizza>> getPizzaList() async {
    try {
      final Uri url = Uri.https(authority, path);
      print('Fetching from: $url');
      final http.Response result = await http.get(url);
      print('Status code: ${result.statusCode}');
      print('Response body: ${result.body}');
      if (result.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(result.body);
        // Provide a type argument to the map method to avoid type error
        List<Pizza> pizzas = jsonResponse
            .map<Pizza>((i) => Pizza.fromJson(i))
            .toList();
        print('Pizzas loaded: ${pizzas.length}');
        return pizzas;
      } else {
        print('Error: Status code ${result.statusCode}');
        return _getLocalPizzas();
      }
    } catch (e) {
      print('Exception: $e');
      return _getLocalPizzas();
    }
  }

  // Fallback data lokal jika API gagal
  List<Pizza> _getLocalPizzas() {
    const String jsonString = '''
    [
      {
        "id": 1,
        "pizzaName": "Margherita",
        "description": "Pizza with tomato, fresh mozzarella and basil",
        "price": 8.75,
        "imageUrl": "images/margherita.png"
      },
      {
        "id": 2,
        "pizzaName": "Marinara",
        "description": "Pizza with tomato, garlic and oregano",
        "price": 7.5,
        "imageUrl": "images/marinara.png"
      },
      {
        "id": 3,
        "pizzaName": "Napoli",
        "description": "Pizza with tomato, garlic and anchovies",
        "price": 9.5,
        "imageUrl": "images/marinara.png"
      },
      {
        "id": 4,
        "pizzaName": "Carciofi",
        "description": "Pizza with tomato, fresh mozzarella and artichokes",
        "price": 8.8,
        "imageUrl": "images/marinara.png"
      },
      {
        "id": 5,
        "pizzaName": "Bufala",
        "description": "Pizza with tomato, buffalo mozzarella and basil",
        "price": 12.5,
        "imageUrl": "images/marinara.png"
      }
    ]
    ''';
    final jsonResponse = json.decode(jsonString);
    return jsonResponse.map<Pizza>((i) => Pizza.fromJson(i)).toList();
  }

  Future<String> postPizza(Pizza pizza) async {
    const postPath = '/pizza';
    String post = json.encode(pizza.toJson());
    Uri url = Uri.https(authority, postPath);
    http.Response r = await http.post(url, body: post);
    return r.body;
  }

  Future<String> putPizza(Pizza pizza) async {
    const putPath = '/pizza';
    String put = json.encode(pizza.toJson());
    Uri url = Uri.https(authority, putPath);
    http.Response r = await http.put(url, body: put);
    return r.body;
  }
}
