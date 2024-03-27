import 'package:ecommerce_app/services/apiservices.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Apiservice().getallproducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: Image.network(
                    snapshot.data['products'][index]['images'][0],
                  ),
                  title: Text(
                    snapshot.data['products'][index]['title'],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
