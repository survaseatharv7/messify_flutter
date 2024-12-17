class MainCourseModel {
  final String item1;
  final double price1;

  MainCourseModel({required this.item1, required this.price1});

  Map<String, dynamic> breakfastMap() {
    return {
      'Item': item1,
      'Price': price1,
    };
  }
}
