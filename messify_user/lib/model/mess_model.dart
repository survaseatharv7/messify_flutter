class MessModel {
  final String messname;
  final int totalRating;
  final int noOfRaters;
  final double avgRating;
  bool isFavourite = false;
  Map<String, dynamic> map;

  MessModel({
    required this.messname,
    required this.totalRating,
    required this.noOfRaters,
    required this.avgRating,
    required this.isFavourite,
    required this.map,
  });
}
