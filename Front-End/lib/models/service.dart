class Service {
  int? id;
  final String title;
  final String description;
  final String image;
  final int deliveryDays;
  final double price;
  final int categoryId;

  Service({
     this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.deliveryDays,
    required this.price,
    required this.categoryId,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      deliveryDays: json['delivery_days'],
      price: json['price'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'title': title,
      'description': description,
      'image': image,
      'delivery_days': deliveryDays,
      'price': price,
      'category_id': categoryId,
    };
  }
}
