class Mission {
  Mission({
    required this.name,
    required this.rocket,
    required this.id,
    required this.launchDate,
    required this.flightNumber,
    required this.youtubeId,
  });

  final String? id;
  final String? name;
  final String? rocket;
  final String? launchDate;
  final int? flightNumber;
  final String? youtubeId;

  factory Mission.fromJson(Map<String, dynamic> json) => Mission(
      name: json["name"],
      rocket: json["rocket"],
      id: json["id"],
      launchDate: json["date_utc"],
      flightNumber: json["flight_number"],
      youtubeId: json["links"]["youtube_id"]);
}
