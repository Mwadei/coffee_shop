import 'package:cofee_flutter/app_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/coffee.dart';

class CartPage extends StatefulWidget {
  static const screenRoute = '/cart';

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //remove from the cart
  void removeFromCart(Coffee coffee, BuildContext context) {
    //get access to order
    final item = context.read<Order>();

    //remove from the cart
    setState(() {
      if (item.cart.length > 0) {
        item.removeFromCart(coffee);
      }
    });
  }

  //calculate total
  String calculateTotal() {
    //get access to order
    final item = context.read<Order>();

    //calculate the total
    double totalPrice = 0;
    for (int i = 0; item.cart.length > i; i++) {
      totalPrice += (item.cart[i].price);
    }

    return totalPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    final String totalPrice = calculateTotal();
    return Consumer<Order>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Cart',
                style: TextStyle(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: value.cart.length,
                  itemBuilder: (context, index) {
                    //get coffee from cart
                    final Coffee coffee = value.cart[index];

                    //get coffee image
                    final String coffeeImage = coffee.imagePath;
                    //get coffee name
                    final String coffeeName = coffee.name;

                    //get coffee price
                    final String coffeePrice = coffee.price.toString();

                    //return list tile
                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.primary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Image.asset(coffeeImage),
                        title: Text(
                          coffeeName,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.8)),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              'Price: ',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.8)),
                            ),
                            Text(
                              '\$ $coffeePrice',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.8)),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(CupertinoIcons.delete),
                          onPressed: () => removeFromCart(coffee, context),
                          color: Colors.red.withOpacity(0.5),
                        ),
                      ),
                    );
                  },
                ),
              ),
              value.cart.length == 0
                  ? Center(
                      child: Text(
                        'The Cart Is Empty',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.3),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  // total price + pay now
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Color(0xFFE57734),
                        borderRadius: BorderRadius.circular(18),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Total Price:",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.8),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$ $totalPrice',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.8),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.8),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Pay Now',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.8),
                                          fontSize: 20,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.8),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
