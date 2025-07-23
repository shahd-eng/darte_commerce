

import 'package:e_commerce/category.dart';

class Product{

  int id;
  String name;
  double price;
  String description;
  int stock;
  Category category;

  Product({required this.id, required this.name, required this.price, required this.description,required this.category, required this.stock});
}