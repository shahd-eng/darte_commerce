import 'dart:io';
import 'package:e_commerce/category.dart';
import 'package:e_commerce/product.dart';
import 'package:e_commerce/user.dart';
import 'package:e_commerce/order.dart';

void main() {
  // Sample categories and products
  var electronics = Category(
    id: 1,
    name: 'Electronics',
    products: [],
  );
  var clothing = Category(
    id: 2,
    name: 'Clothing',
    products: [],
  );

  var phone = Product(
    id: 1,
    name: 'Smartphone',
    price: 999.99,
    description: 'A high-end smartphone',
    category: electronics,
    stock: 10,
  );
  var laptop = Product(
    id: 2,
    name: 'Laptop',
    price: 1499.99,
    description: 'A powerful laptop',
    category: electronics,
    stock: 5,
  );
  var tshirt = Product(
    id: 3,
    name: 'T-Shirt',
    price: 19.99,
    description: 'Comfortable cotton t-shirt',
    category: clothing,
    stock: 20,
  );
  var jeans = Product(
    id: 4,
    name: 'Jeans',
    price: 49.99,
    description: 'Stylish blue jeans',
    category: clothing,
    stock: 15,
  );

  electronics.products.addAll([phone, laptop]);
  clothing.products.addAll([tshirt, jeans]);
  var categories = [electronics, clothing];

  // Sample user
  var user1 = User(id: 1, name: 'Demo User', email: 'user@gmail.com');

  int orderIdCounter = 1;

  while (true) {
    print('\n--- E-Commerce App ---');
    print('1. View Categories and Products');
    print('2. Add Product to Cart');
    print('3. View Cart');
    print('4. Remove Product from Cart');
    print('5. Place Order (Checkout)');
    print('6. View Order History');
    print('0. Exit');
    stdout.write('Select an option: ');
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        print('\nCategories and Products:');
        for (var cat in categories) {
          print('\n${cat.name}:');
          for (var prod in cat.products) {
            print('  ${prod.id}. ${prod.name} - \$${prod.price} (Stock: ${prod.stock})');
          }
        }
        break;
      case '2':
        print('\nSelect a category:');
        for (var i = 0; i < categories.length; i++) {
          print('${i + 1}. ${categories[i].name}');
        }
        stdout.write('Enter category number: ');
        var catIndex = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        if (catIndex < 1 || catIndex > categories.length) {
          print('Invalid category.');
          break;
        }
        var selectedCategory = categories[catIndex - 1];
        print('Products in ${selectedCategory.name}:');
        for (var prod in selectedCategory.products) {
          print('  ${prod.id}. ${prod.name} - \$${prod.price} (Stock: ${prod.stock})');
        }
        stdout.write('Enter product id to add to cart: ');
        var prodId = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        var product = selectedCategory.products.firstWhere(
          (p) => p.id == prodId,

        );
        if (product == null) {
          print('Invalid product.');
          break;
        }
        stdout.write('Enter quantity: ');
        var quantity = int.tryParse(stdin.readLineSync() ?? '') ?? 1;
        if (quantity < 1 || quantity > product.stock) {
          print('Invalid quantity.');
          break;
        }
        user1.cart.addProduct(product, quantity: quantity);
        print('${product.name} (x$quantity) added to cart.');
        break;
      case '3':
        print('\nYour Cart:');
        if (user1.cart.items.isEmpty) {
          print('Cart is empty.');
        } else {
          for (var i = 0; i < user1.cart.items.length; i++) {
            var item = user1.cart.items[i];
            print('${i + 1}. ${item.product.name} - \$${item.product.price} x ${item.quantity} = \$${item.total}');
          }
        }
        break;
      case '4':
        if (user1.cart.items.isEmpty) {
          print('Cart is empty.');
          break;
        }
        print('\nYour Cart:');
        for (var i = 0; i < user1.cart.items.length; i++) {
          var item = user1.cart.items[i];
          print('${i + 1}. ${item.product.name} - \$${item.product.price} x ${item.quantity}');
        }
        stdout.write('Enter product number to remove: ');
        var removeIndex = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
        if (removeIndex < 1 || removeIndex > user1.cart.items.length) {
          print('Invalid selection.');
          break;
        }
        var prodIdToRemove = user1.cart.items[removeIndex - 1].product.id;
        user1.cart.removeProduct(prodIdToRemove);
        print('Product removed from cart.');
        break;
      case '5':
        if (user1.cart.items.isEmpty) {
          print('Cart is empty.');
          break;
        }
        // Check stock
        bool inStock = true;
        for (var item in user1.cart.items) {
          if (item.quantity > item.product.stock) {
            print('Not enough stock for ${item.product.name}.');
            inStock = false;
          }
        }
        if (!inStock) break;
        // Deduct stock
        for (var item in user1.cart.items) {
          item.product.stock -= item.quantity;
        }
        var order = Order(id: orderIdCounter++, items: List.from(user1.cart.items));
        user1.orders.add(order);
        user1.cart.clear();
        print('Order placed! Total: \$${order.total} on ${order.date}');
        break;
      case '6':
        print('\nOrder History:');
        if (user1.orders.isEmpty) {
          print('No orders yet.');
        } else {
          for (var i = 0; i < user1.orders.length; i++) {
            var o = user1.orders[i];
            print('Order ${o.id} on ${o.date}:');
            for (var item in o.items) {
              print('  - ${item.product.name} x ${item.quantity} = \$${item.total}');
            }
            print('  Total: \$${o.total}\n');
          }
        }
        break;
      case '0':
        print('Goodbye!');
        return;
      default:
        print('Invalid option.');
    }
  }
}