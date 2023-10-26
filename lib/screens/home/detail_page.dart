import 'package:cofee_flutter/app_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/coffee.dart';

class CoffeeDetailsPage extends StatefulWidget {
  final Coffee coffee;

  const CoffeeDetailsPage({super.key, required this.coffee});

  @override
  State<CoffeeDetailsPage> createState() => _CoffeeDetailsPageState();
}

class _CoffeeDetailsPageState extends State<CoffeeDetailsPage> {
  int quantity_count = 1;

// decrement quantity
  void decrementQuantity() {
    setState(() {
      if (quantity_count > 1) {
        quantity_count--;
      }
    });
  }

// increment quantity
  void incrementQuantity() {
    setState(() {
      quantity_count++;
    });
  }

//add to favorite
  void addToFavorite() {
    //get access to order
    final coffee = context.read<Order>();

    //add to favorites
    coffee.addToFavorite(widget.coffee);

    //success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text(
          "Successfully added to favorites",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        actions: [
          // okay button
          IconButton(
            onPressed: () {
              // pop once to remove dialog box
              Navigator.pop(context);

              // pop again to move to the previous screen
              Navigator.pop(context);
            },
            icon: Icon(Icons.done),
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      ),
    );
  }

//add to cart
  void addTocart() {
    //get access to order
    final coffee = context.read<Order>();

    //add to the cart
    coffee.addToCart(widget.coffee, quantity_count);

    //success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text(
          "Successfully added to cart",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        actions: [
          // okay button
          IconButton(
            onPressed: () {
              // pop once to remove dialog box
              Navigator.pop(context);

              // pop again to move to the previous screen
              Navigator.pop(context);
            },
            icon: Icon(Icons.done),
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String coffeePrice = widget.coffee.price.toString();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Hero(
                tag: widget.coffee.imagePath,
                child: Image.asset(
                  widget.coffee.imagePath,
                  width: MediaQuery.of(context).size.width / 1.2,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BEST COFFEE",
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.4),
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.coffee.name,
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  CupertinoIcons.minus,
                                  size: 18,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: decrementQuantity,
                              ),
                              SizedBox(width: 5),
                              Text(
                                quantity_count.toString(),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 5),
                              IconButton(
                                icon: Icon(
                                  CupertinoIcons.add,
                                  size: 18,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: incrementQuantity,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$ $coffeePrice',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.coffee.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.4),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        "Volume",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.coffee.volume,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // add to cart button
                        Material(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(18),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 50),
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            onTap: addTocart,
                          ),
                        ),

                        //add to favorite button
                        Material(
                          color: Color(0xFFE57734),
                          borderRadius: BorderRadius.circular(18),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Icon(
                                Icons.favorite_outline,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            onTap: addToFavorite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
