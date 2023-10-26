import 'package:cofee_flutter/Services/auth.dart';
import 'package:cofee_flutter/app_data.dart';
import 'package:cofee_flutter/screens/home/detail_page.dart';
import 'package:cofee_flutter/screens/widgets/items_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const screenRoute = '/home';
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // access to AuthService
  final AuthService _auth = AuthService();

  //navigate to details page
  void selectCoffee(int index) {
    // get Coffee menu
    final coffee = context.read<Order>();
    final coffeeMenu = coffee.coffeeMenu;

    // navigate to detail page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoffeeDetailsPage(
            coffee: coffeeMenu[index],
          ),
        ));
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // get Coffee menu
    final coffee = context.read<Order>();
    final coffeeMenu = coffee.coffeeMenu;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.sort,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              size: 25,
            )),
        title: Center(
          child: Text(
            "Coffee Shop",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(
              Icons.logout,
              color: Colors.redAccent.withOpacity(0.5),
            ),
          ),
        ],
      ),

      //body area
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              "It's a Great Day for coffee",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Find your coffee",
                hintStyle: TextStyle(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                ),
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: Color(0xFFE57734),
            unselectedLabelColor:
                Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            isScrollable: true,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2, color: Color(0xFFE57734)),
              insets: EdgeInsets.symmetric(horizontal: 13),
            ),
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            labelPadding: EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(
                text: "Hot Coffee",
              ),
              Tab(
                text: "Cold Coffee",
              ),
              Tab(
                text: "Cappuiccino",
              ),
              Tab(
                text: "Americano",
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 263,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
              ),
              itemCount: coffeeMenu.length,
              itemBuilder: (context, index) => ItemsWidget(
                coffee: coffeeMenu[index],
                onTap: () => selectCoffee(index),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
