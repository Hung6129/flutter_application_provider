class Products {
  int? id;
  String? title;

  Products({
    this.id,
    this.title,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}
