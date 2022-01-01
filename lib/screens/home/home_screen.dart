import 'package:bookstore/screens/home/controller.dart';
import 'package:bookstore/screens/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/favorite_page.dart';
import 'pages/search_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePage(),
      const SearchPage(),
      const FavoritPage(),
    ];
    PagesController pagesController = Get.put(PagesController());
    pagesController.controller.forward();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Obx(
                  () => pages.elementAt(pagesController.pageIndex.value),
                ),
              ),
              Positioned(
                bottom: 20,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    color: Colors.black.withOpacity(1),
                    boxShadow: const [
                      BoxShadow(blurRadius: 6, color: Colors.black12),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await pagesController.controller.reverse();
                            pagesController.pageIndex.value = 0;
                            await Future.delayed(
                              const Duration(milliseconds: 100),
                            );
                            await pagesController.controller.forward();
                          },
                          icon: Obx(
                            () => Icon(
                              Icons.home_outlined,
                              color: pagesController.pageIndex.value == 0
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          )),
                      IconButton(
                          onPressed: () async {
                            await pagesController.controller.reverse();
                            pagesController.pageIndex.value = 1;
                            await Future.delayed(
                                const Duration(milliseconds: 100));
                            await pagesController.controller.forward();
                          },
                          icon: Obx(
                            () => Icon(
                              Icons.search_rounded,
                              color: pagesController.pageIndex.value == 1
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          )),
                      IconButton(
                          onPressed: () async {
                            await pagesController.controller.reverse();

                            pagesController.pageIndex.value = 2;
                            await Future.delayed(
                                const Duration(milliseconds: 100));
                            await pagesController.controller.forward();
                          },
                          icon: Obx(
                            () => Icon(
                              Icons.favorite_border_rounded,
                              color: pagesController.pageIndex.value == 2
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
