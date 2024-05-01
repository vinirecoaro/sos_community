class Claim {
  double lat;
  double lon;
  String description;
  String pictureLink;
  String title;
  DateTime date;

  Claim(
      {required this.lat,
      required this.lon,
      required this.description,
      required this.pictureLink,
      required this.title,
      required this.date});
}
