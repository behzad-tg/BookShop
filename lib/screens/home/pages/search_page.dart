import 'package:bookstore/animations/up_to_down_fade.dart';
import 'package:bookstore/const.dart';
import 'package:bookstore/screens/home/controller.dart';

import 'package:bookstore/services/data.dart';
import 'package:bookstore/services/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchController searchController = Get.put(SearchController());
    PagesController pagesController = Get.put(PagesController());
    final textFocusNode = FocusNode();
    FocusScope.of(context).unfocus();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
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
            childWidget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: IconButton(
                      onPressed: () {
                        _showButtonModal(context);
                      },
                      icon: const Icon(
                        Icons.filter_alt_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              focusNode: textFocusNode,
                              autofocus: false,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                  hintText: 'جستجو...'),
                              onChanged: (value) async {
                                searchController.searchTextFilter.text = value;
                                await searchController.searchingBook();
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          UpToDownFade(
            controller: pagesController.controller,
            delay: 0.4,
            childWidget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نتایج جستحو',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => Text(
                          '${searchController.searchList.length} کتاب یافت شد',
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          searchController.isList.value = false;
                        },
                        icon: Obx(
                          () => Icon(
                            Icons.grid_view,
                            color: searchController.isList.value
                                ? Colors.black
                                : primaryColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          searchController.isList.value = true;
                        },
                        icon: Obx(
                          () => Icon(
                            Icons.format_list_bulleted_rounded,
                            color: searchController.isList.value
                                ? primaryColor
                                : Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 10,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.filter_list_rounded,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          UpToDownFade(
            controller: pagesController.controller,
            delay: 0.6,
            childWidget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Obx(
                () => searchController.isLoading.value
                    ? Container(
                        padding: const EdgeInsets.only(top: 200),
                        child: Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      )
                    : (searchController.isList.value
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: searchController.searchList.length,
                            itemBuilder: (context, index) {
                              return HorizonalBook(
                                  book: searchController.searchList[index],
                                  heroTag: 'listBooks');
                            },
                          )
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: searchController.searchList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.6,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (context, index) {
                              return VerticalBook(
                                  book: searchController.searchList[index],
                                  heroTag: 'GridBooks');
                            },
                          )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showButtonModal(BuildContext context) {
    SearchController searchController = Get.put(SearchController());
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - 100,
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 40,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'محدوده قیمت',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black26),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Center(
                                child: Obx(
                              () => Text(
                                  '${searchController.priceRange.value.start.round().toString()} تومان'),
                            )),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.black26,
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black26),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Center(
                                child: Obx(
                              () => Text(
                                  '${searchController.priceRange.value.end.round().toString()} تومان'),
                            )),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => RangeSlider(
                        min: 0,
                        max: 100000,
                        divisions: 1000,
                        values: searchController.priceRange.value,
                        activeColor: primaryColor,
                        inactiveColor: Colors.black12,
                        onChanged: (values) async {
                          searchController.priceRange.value = values;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'دسته بندی ها',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: categorys
                          .map(
                            (Category value) => Row(
                              children: [
                                Obx(() {
                                  return Checkbox(
                                    value: searchController.categoryFilter
                                            .contains(value.category)
                                        ? true
                                        : false,
                                    onChanged: (e) {
                                      if (e as bool) {
                                        searchController.categoryFilter
                                            .add(value.category);
                                      } else {
                                        searchController.categoryFilter
                                            .remove(value.category);
                                      }
                                    },
                                  );
                                }),
                                Text(value.category),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () async {
                        searchController.searchingBook();
                        Navigator.pop(context);
                      },
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
