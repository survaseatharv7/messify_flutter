class Breadmodel {
  final String item2;
  final double price2;

  Breadmodel({required this.item2, required this.price2});

  Map<String, dynamic> breakfastMap() {
    return {
      'Item': item2,
      'Price': price2,
    };
  }
}
