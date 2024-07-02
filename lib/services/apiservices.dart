import 'dart:convert';

import 'package:http/http.dart' as http;

class Apiservice {
  Future getcategories() async {
    final categoryurl = Uri.parse('https://dummyjson.com/products/category-list');
    final response = await http.get(categoryurl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getallproducts() async {
    final allproductsurl = Uri.parse('https://dummyjson.com/products');
    final response = await http.get(allproductsurl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getsingleproducts(int id) async {
    final singleproducturl = Uri.parse('https://dummyjson.com/products/$id');
    final response = await http.get(singleproducturl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getcategoryproducts(String catid) async {
    final productcategoryurl =
        Uri.parse('https://dummyjson.com/products/category/$catid');
    final response = await http.get(productcategoryurl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future getcartproducts() async {
    final cartproducts = Uri.parse('https://dummyjson.com/carts');
    final response = await http.get(cartproducts);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

//POSTS
  Future postuserlogin(String username, String password) async {
    final userloginurl = Uri.parse('https://dummyjson.com/auth/login');
    final response = await http
        .post(userloginurl, body: {'username': username, 'password': password});
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  //PUT
  Future updatecart(int id) async {
    final updatecarturl = Uri.parse('https://dummyjson.com/carts/$id');
    final response = await http.put(updatecarturl,
        body: {
          'products': [
            {
              'id': 1,
              'quantity': 1,
            },
          ]
        }.toString());
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  Future deletecart() async {
    final deletecarturl = Uri.parse('https://dummyjson.com/carts/1');
    final response = await http.delete(deletecarturl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }
}
