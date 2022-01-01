class Book {
  late int id;
  late String image;
  late String title;
  late String text;
  late String author;
  late int price;
  late Category category;
  late String star;

  Book(
      {required this.id,
      required this.image,
      required this.title,
      required this.text,
      required this.author,
      required this.price,
      required this.category,
      required this.star});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    text = json['text'];
    author = json['author'];
    price = json['price'];
    category = Category.fromJson(json['category']);
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['text'] = text;
    data['author'] = author;
    data['price'] = price;
    data['category'] = category.toJson();
    data['star'] = star;
    return data;
  }
}

class Category {
  late int id;
  late String category;

  Category({required this.id,required this.category});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    return data;
  }
}
