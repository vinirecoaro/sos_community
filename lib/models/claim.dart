class Claim {
  String? id;
  double? lat;
  double? lon;
  String description;
  List<String>? picturesPath;
  String title;
  DateTime date;
  String status;
  bool edit;
  int? cep;
  int? num;

  Claim({
    this.id,
    this.lat,
    this.lon,
    required this.description,
    this.picturesPath,
    required this.title,
    required this.date,
    this.status = "Em análise",
    this.edit = false,
    this.cep,
    this.num,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'lon': lon,
      'description': description,
      'picturesPath': picturesPath,
      'title': title,
      'date': date.toIso8601String(), // Converter DateTime para String
      'status': status,
      'edit': edit,
      'cep': cep,
      'num': num,
    };
  }

  factory Claim.fromJson(Map<String, dynamic> json) {
    return Claim(
      id: json['id'],
      lat: json['lat'],
      lon: json['lon'],
      description: json['description'],
      picturesPath: json['picturesPath'] != null
          ? List<String>.from(json['picturesPath'])
          : null,
      title: json['title'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      edit: json['edit'],
      cep: json['cep'],
      num: json['num'],
    );
  }
}
