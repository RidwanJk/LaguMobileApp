import 'dart:convert';
import 'package:http/http.dart' as http;

class Category {
  final int categoryId;
  final String name;
  final String imageUrl;

  Category({
    required this.categoryId,
    required this.name,
    required this.imageUrl,
  });
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
  // A method to fetch categories from an API
  static Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://azzalea.pythonanywhere.com/api/categories'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Mapping JSON data to Category objects
        List<Category> categories = data.map((categoryData) {
          return Category(
            categoryId: categoryData['category_id'],
            name: categoryData['name'],
            imageUrl: categoryData['imageUrl'],
          );
        }).toList();

        return categories;
      } else {
        throw Exception('Failed to load categoriesaaaaaaaaaaaaaaaaaaaaa');
      }
    } catch (e) {
      throw Exception('Error fetching categories:aaaaaaaaaaaaaaaaaa $e');
    }
  }
}
