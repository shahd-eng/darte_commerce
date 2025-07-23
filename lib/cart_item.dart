import 'package:e_commerce/product.dart';


class CarItem{
  Product product;
  int quantity;

  CarItem(this.product, this.quantity);

  double get total => product.price * quantity;
}