import 'package:e_commerce/cart.dart';
import 'package:e_commerce/order.dart';

class User{
  int id;
  String name;
  String email;
  List<Order> orders=[];
  Cart cart=Cart();

  User({required this.id, required this.name, required this.email});
}