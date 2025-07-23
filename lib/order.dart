import 'package:e_commerce/cart_item.dart';

enum OrderStatus{
  pending,
  placed,
  shipped,
  outForDelivery,
  delivered,
  canceled,
}
class Order{
  int id;
  List<CarItem> items;
  double total;
  DateTime date;
  //: for initializer list constructor(to assign values to const & final before the constructor starts his work

  Order({required this.id, required this.items})
      : total = items.fold(0, (sum, item) => sum + item.total),
        date = DateTime.now();
}