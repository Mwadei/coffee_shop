import 'package:cofee_flutter/Services/auth.dart';
import 'package:cofee_flutter/app_data.dart';
import 'package:cofee_flutter/model/users.dart';
import 'package:cofee_flutter/screens/home/Screens.dart';
import 'package:cofee_flutter/screens/home/cart_screen.dart';
import 'package:cofee_flutter/screens/home/home_screen.dart';
import 'package:cofee_flutter/screens/home/welcom_screen.dart';
import 'package:cofee_flutter/screens/wrapper.dart';
import 'package:cofee_flutter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBZaIfRk2FdnqQNDCP5cnCn--ZYkBGOfK4",
      appId: "1:465929855129:android:15ce98ce1969150fe45808",
      messagingSenderId: "465929855129",
      projectId: "coffee-shop-b428e",
    ),
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => Order(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      catchError: (User, user) => null,
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        //theme: ThemeData(scaffoldBackgroundColor: Color(0xFF212325)),
        home: WelcomeScreen(),
        routes: {
          //WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
          Wrapper.screenRoute: (context) => Wrapper(),
          Screens.screenRoute: (context) => Screens(),
          HomeScreen.screenRoute: (context) => HomeScreen(),
          CartPage.screenRoute: (context) => CartPage(),
        },
      ),
    );
  }
}
