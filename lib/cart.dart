import 'package:e_commerce/cart_item.dart';
import 'package:e_commerce/product.dart';
class Cart{
 final List<CarItem> items=[];
  void addProduct(Product product,{int quantity=1}){
    final index=items.indexWhere((item)=>item.product.id==product.id);
    if (index!=-1)
      {
        items[index].quantity+=quantity;
      }
    else{
      items.add(CarItem(product, quantity));
    }

  }

  void removeProduct(int productId)
  {
    items.removeWhere((item)=>item.product.id==productId);
  }

  void clear()=>items.clear();


}