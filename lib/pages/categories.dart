import 'package:ecommerce_app/pages/singleproduct.dart';
import 'package:ecommerce_app/services/apiservices.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({required this.catid, super.key});
  final String catid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text(catid),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Apiservice().getcategoryproducts(catid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleProduct(
                              id: snapshot.data['products'][index]['id']),
                        ));
                  },
                  child: ListTile(
                    leading: Image.network(
                      snapshot.data['products'][index]['images'][0],
                      height: 30,
                    ),
                    title: Text(snapshot.data['products'][index]['title']),
                    subtitle: Text('Price:  \$' +
                        snapshot.data['products'][index]['price'].toString()),
                  ),
                );
              },
            );
          } else {
            return LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
