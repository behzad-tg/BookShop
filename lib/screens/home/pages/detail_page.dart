// ignore_for_file: prefer_const_constructors
import 'package:bookstore/animations/add_to_card_animation.dart';
import 'package:bookstore/animations/down_to_up_fade.dart';
import 'package:bookstore/animations/left_to_right_fade.dart';
import 'package:bookstore/const.dart';
import 'package:bookstore/screens/home/controller.dart';
import 'package:bookstore/screens/order/controller.dart';
import 'package:bookstore/services/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  final Book book;
  final String heroTag;
  const DetailPage({Key? key, required this.book, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.put(OrderController());
    AddToCardController addToCardController = Get.put(AddToCardController());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      height: MediaQuery.of(context).size.width * 0.65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: double.infinity,
                              child: Hero(
                                tag: '$heroTag${book.id}',
                                child: Image.network(
                                  book.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                LeftToRightFade(
                                  delay: 0.2,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LeftToRightFade(
                                      delay: 0.4,
                                      child: Text(
                                        book.title,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    LeftToRightFade(
                                      delay: 0.5,
                                      child: Text(book.author,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                    ),
                                    const SizedBox(height: 20),
                                    LeftToRightFade(
                                      delay: 0.6,
                                      child: Row(
                                        children: [
                                          Text(book.star,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.amber)),
                                          const SizedBox(width: 5),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    DownToUpFade(
                      delay: 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          book.text + book.text + book.text + book.text,
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 5,
                          style: const TextStyle(fontSize: 15, height: 1.8),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
              AddToCardAnimation(
                controller: addToCardController.addToCardController,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                childWidget: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.network(
                    book.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              DownToUpFade(
                delay: 1.0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                      )
                    ],
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: DownToUpFade(
                    delay: 1.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          book.price.toString() + ' تومان',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white),
                        ),
                        InkWell(
                          onTap: () async {
                            if (orderController.cardList.contains(book)) {
                              addToCardController.isAdding.value = true;
                              await Future.delayed(Duration(seconds: 1));
                              orderController.cardList.remove(book);
                              addToCardController.isAdding.value = false;
                            } else {
                              addToCardController.isAdding.value = true;

                              await addToCardController.addToCardController
                                  .forward();

                              addToCardController.addToCardController.reset();
                              orderController.cardList.add(book);
                              addToCardController.isAdding.value = false;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: 40,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(
                              child: Obx(
                                //
                                () => addToCardController.isAdding.value
                                    ? SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(
                                            color: primaryColor),
                                      )
                                    : Text(
                                        orderController.cardList.contains(book)
                                            ? 'حذف از سبد خرید'
                                            : 'افزودن به سبد',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor),
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
