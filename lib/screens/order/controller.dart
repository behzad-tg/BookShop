import 'package:bookstore/services/models.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  RxList cardList = <Book>[].obs;
  RxInt total = 0.obs;

  totalCountr() {
    total.value = 0;
    for (final obj in cardList) {
      total += obj.price;
    }
  }
}
