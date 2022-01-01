import 'package:bookstore/animations/up_to_down_fade.dart';
import 'package:bookstore/services/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '../widgets.dart';

class FavoritPage extends StatelessWidget {
  const FavoritPage({Key? key}) : super(key: key);

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
                'علاقه مندی ها',
                style: TextStyle(fontSize: 25, fontFamily: 'FontBold'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              reverse: true,
              itemCount: favorits.length,
              itemBuilder: (context, index) {
                return UpToDownFade(
                  controller: pagesController.controller,
                  delay: 0.4 + (index * 0.1),
                  childWidget: HorizonalBook(
                    book: favorits[index],
                    heroTag: 'favoritBooks',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
