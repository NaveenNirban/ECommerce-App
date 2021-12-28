import 'package:ecommerce_app/models/StateModels/cartModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _couponController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    double totalAmount = 0.0;

    /// Defining appbar
    AppBar appBar = AppBar(
      title: Text('Cart'),
    );

    /// Height of appbar
    double appBarHeight = appBar.preferredSize.height;
    var safeHeight = height - MediaQuery.of(context).padding.top - appBarHeight;

    return SafeArea(
        child: Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(children: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Column(children: [
                Container(
                  height: safeHeight * 0.87,
                  child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        totalAmount = cart.totalPrice;
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            trailing: Text("₹ " +
                                cart.items[index].price.toString() +
                                " /-"),
                            leading: Image.network(cart.items[index].image),
                            title: Text(cart.items[index].title.toString()),
                            subtitle:
                                Text(cart.items[index].description.toString()),
                          ),
                        );
                      }),
                ),
                Column(children: [
                  Container(
                    height: safeHeight * 0.03,
                    child: Text(_couponController.text == "10PER"
                        ? "Coupon applied, you got 15% discount"
                        : "Wow, you got 10% of discount"),
                  ),
                  Container(
                    height: safeHeight * 0.05,
                    child: TextField(
                      controller: _couponController,
                      decoration: InputDecoration(
                          hintText: 'Enter Coupon',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                  Container(
                    height: safeHeight * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Grand Total"),
                        Text(
                          _couponController.text == "10PER"
                              ? "₹ " +
                                  cart.get10PercentDiscount.toString() +
                                  " /-"
                              : "₹ " + cart.totalPrice.toString() + " /-",
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                  ),
                ])
              ]);
            },
          ),
        ]),
      ),
    ));
  }
}
