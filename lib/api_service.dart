import 'package:dio/dio.dart';
import 'package:pks9/model/product.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://85.192.40.154:8080',
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 50),
    ),
  );

  Future<List<Collector>> getProducts() async {
    try {
      final response = await _dio.get('http://85.192.40.154:8080/products');
      if (response.statusCode == 200) {
        List<Collector> collectorList = (response.data as List)
            .map((collector) => Collector.fromJson(collector))
            .toList();
        return collectorList;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Collector> createProducts(Collector collector) async {
    try {
      final response = await _dio.post(
        'http://85.192.40.154:8080/products/create',
        data: collector.toJson(),
      );
      if (response.statusCode == 200) {
        return Collector.fromJson(response.data);
      } else {
        throw Exception('Failed to create collector: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating collector: $e');
    }
  }

  Future<Collector> getProductById(int id) async {
    try {
      final response = await _dio.get('http://85.192.40.154:8080/products/$id');
      if (response.statusCode == 200) {
        return Collector.fromJson(response.data);
      } else {
        throw Exception('Failed to load collector with ID $id: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching collector by ID: $e');
    }
  }

  Future<Collector> updateProduct(int id, Collector collector) async {
    try {
      final response = await _dio.put(
        'http://85.192.40.154:8080/products/update/$id',
        data: collector.toJson(),
      );
      if (response.statusCode == 200) {
        return Collector.fromJson(response.data);
      } else {
        throw Exception('Failed to update collector: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating collector: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await _dio.delete('http://85.192.40.154:8080/products/delete/$id');
      if (response.statusCode == 204) {
        print("Car with ID $id deleted successfully.");
      } else {
        throw Exception('Failed to delete collector: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting collector: $e');
    }
  }
}
