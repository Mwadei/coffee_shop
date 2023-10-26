import 'package:cofee_flutter/app_data.dart';
import 'package:cofee_flutter/model/coffee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  //remove from the favorites
  void removeFromFavorite(Coffee coffee, BuildContext context) {
    //get access to order
    final item = context.read<Order>();

    //remove from the favorites
    setState(() {
      if (item.favorite.length > 0) {
        item.removeFromFavorite(coffee);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                'Favorites',
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
              value.favorite.length > 0
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: value.cart.length,
                        itemBuilder: (context, index) {
                          //get coffee from favorites
                          final Coffee coffee = value.favorite[index];

                          //get coffee image
                          final String coffeeImage = coffee.imagePath;
                          //get coffee name
                          final String coffeeName = coffee.name;

                          //get coffee price
                          final String coffeePrice = coffee.price.toString();

                          //return list tile
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 13),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).colorScheme.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.4),
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
                                onPressed: () =>
                                    removeFromFavorite(coffee, context),
                                color: Colors.red.withOpacity(0.5),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        'The Favorites Is Empty',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.3),
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
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
