import 'package:bookstore/animations/left_to_right_fade.dart';
import 'package:bookstore/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

import '../controller.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.put(OrderController());
    orderController.totalCountr();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          centerTitle: true,
          title: const Text(
            'بوکـ شاپ',
            style: TextStyle(
                fontSize: 20, fontFamily: 'FontBold', color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(
                  () => AnimatedList(
                    physics: const BouncingScrollPhysics(),
                    initialItemCount: orderController.cardList.length,
                    itemBuilder: (context, index, animation) {
                      final book = orderController.cardList[index];
                      return LeftToRightFade(
                        delay: 0.2 + index * 0.1,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 60,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: Hero(
                                        tag: 'cardList${book.id}',
                                        child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: book.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            book.title,
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            '${book.price.toString()} تومان',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          orderController.cardList.remove(book);
                                          AnimatedList.of(context).removeItem(
                                              index,
                                              (context, animation) =>
                                                  Container());
                                          orderController.totalCountr();
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline_rounded,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.black26,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'مبلغ نهایی :',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black45),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Text(
                        '${orderController.total.value} تومان',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'اعمال',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
