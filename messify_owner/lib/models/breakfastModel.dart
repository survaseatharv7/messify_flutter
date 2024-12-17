class breakFastModel {
  final String item;
  final double price;

  breakFastModel({required this.item, required this.price});

  Map<String, dynamic> breakfastMap() {
    return {
      'Item': item,
      'Price': price,
    };
  }
}
