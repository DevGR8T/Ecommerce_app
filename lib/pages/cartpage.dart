import 'package:ecommerce_app/pages/rootpage.dart';
import 'package:ecommerce_app/services/apiservices.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RootPage(),
                  ));
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('Your Cart'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Apiservice().getcartproducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(5),
                  leading: Image.network(
                    snapshot.data['carts'][index]['products'][index]
                        ['thumbnail'],
                    height: 40,
                  ),
                  title: Text(snapshot.data['carts'][index]['products'][index]
                      ['title']),
                  subtitle: Text('Quantity:  ' +
                      snapshot.data['carts'][index]['products'][index]
                              ['quantity']
                          .toString()),
                  trailing: IconButton(
                    onPressed: () async {
                      await Apiservice().deletecart();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Product deleted successfully',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        color: Colors.teal,
        height: 45,
        child: Text(
          'Order Now',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
