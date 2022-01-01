import 'package:bookstore/animations/up_to_down_fade.dart';
import 'package:bookstore/services/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '../widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PagesController pagesController = Get.put(PagesController());
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpToDownFade(
            controller: pagesController.controller,
            delay: 0,
            childWidget: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ShopHeaderpBar(),
            ),
          ),
          UpToDownFade(
            controller: pagesController.controller,
            delay: 0.2,
            childWidget: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'محبوب ترین ها',
                style: TextStyle(fontSize: 25, fontFamily: 'FontBold'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          UpToDownFade(
            controller: pagesController.controller,
            delay: 0.4,
            childWidget: SizedBox(
              height: 300,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: books.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(
                      right: 20, left: books.length - 1 == index ? 20 : 0),
                  width: 140,
                  child:
                      VerticalBook(book: books[index], heroTag: 'popularBooks'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          UpToDownFade(
            controller: pagesController.controller,
            delay: 0.6,
            childWidget: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'کتاب های جدید',
                style: TextStyle(fontSize: 25, fontFamily: 'FontBold'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              reverse: true,
              itemCount: books.length,
              itemBuilder: (context, index) {
                return UpToDownFade(
                    controller: pagesController.controller,
                    delay: 0.8 + (index * 0.1),
                    childWidget:
                        HorizonalBook(book: books[index], heroTag: 'newBooks'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
