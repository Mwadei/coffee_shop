import 'package:cofee_flutter/model/coffee.dart';
import 'package:flutter/material.dart';

class Order extends ChangeNotifier {
  // coffee menu
  final List<Coffee> coffee_data = [
    Coffee(
      id: '1',
      name: 'Latte',
      imagePath: 'images/Latte.png',
      price: 30,
      description:
          'Coffee is  a major source of antioxidants in the diet. it has many health benefits',
      volume: '60 ml',
    ),
    Coffee(
      id: '2',
      name: 'Espresso',
      imagePath: 'images/Espresso.png',
      price: 18,
      description:
          'Coffee is  a major source of antioxidants in the diet. it has many health benefits',
      volume: '60 ml',
    ),
    Coffee(
      id: '3',
      name: 'Black Coffee',
      imagePath: 'images/Black Coffee.png',
      price: 12,
      description:
          'Coffee is  a major source of antioxidants in the diet. it has many health benefits',
      volume: '60 ml',
    ),
    Coffee(
      id: '4',
      name: 'Cold Coffee',
      imagePath: 'images/Cold Coffee.png',
      price: 15,
      description:
          'Coffee is  a major source of antioxidants in the diet. it has many health benefits',
      volume: '60 ml',
    ),
  ];

  //customer Favorite
  final List<Coffee> _favorite = [];

  // customer cart
  final List<Coffee> _cart = [];

  // getter methode
  List<Coffee> get coffeeMenu => coffee_data;
  List<Coffee> get favorite => _favorite;
  List<Coffee> get cart => _cart;

  //add to favorites
  void addToFavorite(Coffee coffeeItem) {
    _favorite.add(coffeeItem);
  }

  //remove from favorites
  void removeFromFavorite(Coffee coffeeItem) {
    _favorite.remove(coffeeItem);
  }

  // add to cart
  void addToCart(Coffee coffeeItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(coffeeItem);
    }
  }

  //remove from cart
  void removeFromCart(Coffee coffeeItem) {
    _cart.remove(coffeeItem);
  }
}
