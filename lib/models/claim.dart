class Claim {
  double lat;
  double lon;
  String description;
  String pictureLink;
  String title;
  DateTime date;
  String status;
  bool edit;

  Claim(
      {required this.lat,
      required this.lon,
      required this.description,
      required this.pictureLink,
      required this.title,
      required this.date,
      this.status = "Em análise",
      this.edit = false});
}
