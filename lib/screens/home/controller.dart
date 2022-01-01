import 'package:bookstore/services/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PagesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt pageIndex = 0.obs;
  late AnimationController controller;

  @override
  void onInit() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class SearchController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isList = true.obs;
  RxList searchList = [].obs;
  TextEditingController searchTextFilter = TextEditingController();
  final priceRange = const RangeValues(0, 100000).obs;
  RxList categoryFilter = [].obs;

  @override
  void onInit() {
    searchingBook();
    super.onInit();
  }

  searchingBook() async {
    isLoading.value = false;
    searchList.value = [];
    for (final obj in books) {
      bool condition1 = false;
      bool condition2 = false;
      bool condition3 = false;
      //condirion 1
      if (obj.title.contains(searchTextFilter.text) ||
          searchTextFilter.text.isEmpty) {
        condition1 = true;
      }
      //condirion 2
      if (obj.price >= priceRange.value.start &&
          obj.price <= priceRange.value.end) {
        condition2 = true;
      }
      //condirion 3
      if (categoryFilter.contains(obj.category.category) ||
          categoryFilter.isEmpty) {
        condition3 = true;
      }
      //resulte
      if (condition1 && condition2 && condition3) {
        searchList.add(obj);
      }
    }
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }
}

class FavoritController extends GetxController {}

class AddToCardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController addToCardController;
  RxBool isAdding = false.obs;

  @override
  void onInit() {
    addToCardController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    super.onInit();
  }

  @override
  void dispose() {
    addToCardController.dispose();
    super.dispose();
  }
}
