import 'package:ecommerce_app/routes/routing/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/StateModels/cartModel.dart';
import 'models/StateModels/favModel.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CartModel()),
    ChangeNotifierProvider(create: (context) => FavModel()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: router.Router.login,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
