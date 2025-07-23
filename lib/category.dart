import 'package:e_commerce/product.dart';
class Category{
  int id;
  String name;
   List <Product> products;

  Category({required this.id,required this.name, required this.products});
}