class LunchDinnerModel {
  final String item;
  final double price;
  final String sabji1;
  final String sabji2;
  final String sweet;
  final String chapati;
  final double chapaticount;
  final String rice;
  final String dal;

  LunchDinnerModel(
      {required this.item,
      required this.price,
      required this.sabji1,
      required this.sabji2,
      required this.sweet,
      required this.chapati,
      required this.chapaticount,
      required this.rice,
      required this.dal});

  Map<String, dynamic> breakfastMap() {
    return {
      'Item': item,
      'Price': price,
      'Sabji1': sabji1,
      'Sabji2': sabji2,
      'Sweet': sweet,
      'Chapati/Bhakari': chapati,
      'Chapati/Bhakari count': chapaticount,
      'Rice': rice,
      'Dal': dal
    };
  }
}
