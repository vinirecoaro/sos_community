class Claim {
  double? lat;
  double? lon;
  String description;
  String pictureLink;
  String title;
  DateTime date;
  String status;
  bool edit;
  int? cep;
  int? num;

  Claim({
    this.lat,
    this.lon,
    required this.description,
    required this.pictureLink,
    required this.title,
    required this.date,
    this.status = "Em análise",
    this.edit = false,
    this.cep,
    this.num,
  });
}
