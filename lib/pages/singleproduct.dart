import 'package:ecommerce_app/services/apiservices.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SingleProduct extends StatefulWidget {
  SingleProduct({required this.id, super.key});
  int id;

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  int currentImage = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Apiservice().getsingleproducts(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> images = snapshot.data['images'];
            List<String> ImageSlider =
                images.take(3).map((image) => image.toString()).toList();

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  height: size.height / 2,
                  child: Stack(children: [
                    CarouselSlider.builder(
                      itemCount: ImageSlider.length,
                      itemBuilder: (context, index, realIndex) {
                        return Image.network(
                          ImageSlider[index],
                          fit: BoxFit.fill,
                        );
                      },
                      options: CarouselOptions(
                        height: 386,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentImage = index;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 170,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ImageSlider.map((e) {
                          int index = ImageSlider.indexOf(e);
                          return Container(
                            margin: EdgeInsets.all(2),
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentImage == index
                                    ? Colors.white
                                    : Colors.grey[500]),
                          );
                        }).toList(),
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            snapshot.data['title'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          Spacer(),
                          Text(
                            '\$' + snapshot.data['price'].toString(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          snapshot.data['category'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      RatingBar.builder(
                        itemPadding: EdgeInsets.only(right: 6),
                        allowHalfRating: false,
                        itemCount: 5,
                        glow: true,
                        itemSize: 20.0,
                        minRating: 0,
                        itemBuilder: (context, index) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                        onRatingUpdate: (value) {},
                      ),
                      SizedBox(height: 25),
                      Text(snapshot.data['description']),
                      SizedBox(height: 60),
                      Center(
                        child: FloatingActionButton(
                            onPressed: () async {
                              await Apiservice().updatecart(widget.id);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'Product added to cart',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.green,
                              ));
                            },
                            child: Icon(Icons.shopping_cart),
                            backgroundColor: Colors.teal),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
