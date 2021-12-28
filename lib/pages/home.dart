import 'dart:convert';

import 'package:ecommerce_app/config/application.dart';
import 'package:ecommerce_app/models/StateModels/cartModel.dart';
import 'package:ecommerce_app/models/StateModels/favModel.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/routes/routing/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    /// Defining appbar
    AppBar appBar = AppBar(
        title: Text('Ecommerce App'),
        leading: Container(),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, router.Router.cart);
            },
            child: Container(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Consumer<CartModel>(
                      builder: (context, cart, child) {
                        return Text(
                          cart.items.length.toString(),
                          style: TextStyle(fontSize: 18),
                        );
                      },
                    ),
                  ),
                  const IconButton(
                    icon: Icon(Icons.shopping_cart_outlined),
                    tooltip: 'Cart',
                    // Passed it null because we have called onTap event in its parent Inkwell.
                    onPressed: null,
                  )
                ],
              ),
            ),
          ),
        ]);

    /// Height of appbar
    double appBarHeight = appBar.preferredSize.height;
    var safeHeight = height - MediaQuery.of(context).padding.top - appBarHeight;

    /// Async fetch call
    Future<List<Product>> _fetchProducts() async {
      dynamic response = await http.get(Uri.parse(APIInfo.getAll));
      //print(jsonDecode(response.body)['data']);

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        //var data = response.body['data'];
        List<Product> listData = (json.decode(response.body) as List)
            .map((data) => Product.fromJson(data))
            .toList();

        return listData;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: safeHeight,
                  child: FutureBuilder<List<Product>>(
                    future: _fetchProducts(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                  elevation: 5,
                                  child: ListTile(
                                    trailing: InkWell(
                                        onTap: () {
                                          Provider.of<CartModel>(context,
                                                  listen: false)
                                              .add(snapshot.data[index]);
                                        },
                                        child: Icon(Icons.add_shopping_cart)),
                                    leading: Container(
                                      child: Stack(children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.05,
                                              top: width * 0.03),
                                          child: Image.network(
                                              snapshot.data[index].image),
                                        ),
                                        Consumer<FavModel>(
                                            builder: (context, fav, child) {
                                          return fav.getFav(
                                                  snapshot.data[index].id)
                                              ? InkWell(
                                                  onTap: () {
                                                    Provider.of<FavModel>(
                                                            context,
                                                            listen: false)
                                                        .remove(snapshot
                                                            .data[index].id);
                                                  },
                                                  child: FaIcon(
                                                    FontAwesomeIcons.solidHeart,
                                                    color: Colors.red,
                                                    size: 18,
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    Provider.of<FavModel>(
                                                            context,
                                                            listen: false)
                                                        .add(snapshot
                                                            .data[index].id);
                                                  },
                                                  child: FaIcon(
                                                    FontAwesomeIcons.heart,
                                                    size: 18,
                                                  ),
                                                );
                                        }),
                                      ]),
                                    ),
                                    title: Text(snapshot.data[index].title),
                                    subtitle: Wrap(children: [
                                      Text(
                                        snapshot.data[index].description,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ]),
                                  ));
                            });
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error.toString()}');
                      }

                      // By default, show a loading spinner.
                      return Center(child: const CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
