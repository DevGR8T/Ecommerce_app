import 'package:ecommerce_app/pages/allcategory.dart';
import 'package:ecommerce_app/pages/cartpage.dart';
import 'package:ecommerce_app/pages/categories.dart';
import 'package:ecommerce_app/services/apiservices.dart';
import 'package:ecommerce_app/widgets/homewidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activetab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 260,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(7),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Find your product',
                            hintStyle: TextStyle(fontWeight: FontWeight.w400)),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 30),
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5)),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartPage(),
                                  ));
                            },
                            icon: Icon(Icons.shopping_cart)))
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/friendshipday.jpg'),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Text('Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllCategory(),
                              ));
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.teal),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                FutureBuilder(
                  future: Apiservice().getcategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: 50,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  activetab = index;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoriesPage(
                                            catid: snapshot.data[index]
                                                .toString()
                                                .toUpperCase()),
                                      ));
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: activetab == index
                                        ? Colors.teal
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    snapshot.data[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: activetab == index
                                            ? Colors.white
                                            : Colors.grey[700]),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                HomeWidget(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
