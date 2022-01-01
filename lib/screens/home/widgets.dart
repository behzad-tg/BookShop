import 'package:bookstore/const.dart';
import 'package:bookstore/screens/home/pages/detail_page.dart';
import 'package:bookstore/screens/order/controller.dart';
import 'package:bookstore/screens/order/pages/card_page.dart';
import 'package:bookstore/services/data.dart';
import 'package:bookstore/services/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

// header
class ShopHeaderpBar extends StatelessWidget {
  const ShopHeaderpBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.put(OrderController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'بوکـ شاپ',
          style: TextStyle(fontSize: 20, fontFamily: 'FontBold'),
        ),
        Row(
          children: [
            Obx(() => orderController.cardList.isEmpty
                ? Container()
                : Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.redAccent),
                    child: Text(
                      orderController.cardList.length.toString(),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const CardPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0.0, -1.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ],
        )
      ],
    );
  }
}

// horizonal List
class HorizonalBook extends StatelessWidget {
  final Book book;
  final String heroTag;
  const HorizonalBook({Key? key, required this.book, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isFavorit = false;
    var checkFavorit = favorits.where((e) => e.id == book.id);
    if (checkFavorit.isNotEmpty) {
      isFavorit = true;
    } else {
      isFavorit = false;
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(book: book, heroTag: heroTag),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              width: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Hero(
                        tag: '$heroTag${book.id}',
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: book.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                book.title,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Icon(Icons.favorite,
                                  size: 18,
                                  color:
                                      isFavorit ? Colors.red : Colors.black12),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(book.author,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${book.price.toString()} تومان',
                            style: TextStyle(
                                fontSize: 15,
                                color: primaryColor,
                                fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text(book.star,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.amber)),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerticalBook extends StatelessWidget {
  final Book book;
  final String heroTag;
  const VerticalBook({Key? key, required this.book, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(book: book, heroTag: heroTag),
          ),
        );
      },
      child: SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Hero(
                            tag: '$heroTag${book.id}',
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: book.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.7, 1],
                            colors: [Colors.transparent, Colors.black87],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        child: Row(
                          children: [
                            Text(book.star,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.amber)),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  book.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            Text(
              '${book.price.toString()} تومان',
              style: TextStyle(
                  fontSize: 15,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
