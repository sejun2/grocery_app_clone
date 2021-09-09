import 'package:get/get.dart';
import 'package:grocery_app_clone/models/Product.dart';
import 'package:grocery_app_clone/models/ProductItem.dart';

enum HomeState { normal, cart }

class HomeController extends GetxController {
  var homeState = HomeState.normal.obs;
  var cart = [].obs;

  void changeHomeState(HomeState state) {
    homeState.value = state;
  }

  void addProductToCart(Product product){
    for(ProductItem item in cart){
        if(item.product!.title == product.title){
            item.increment();
            return;
        }
    }
    cart.add(ProductItem(product: product));
  }

  int totalCartItems() => cart.fold(0, (previousValue, element) => previousValue + element.quantity as int);
}
