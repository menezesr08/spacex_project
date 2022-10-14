class Mission {
  Mission(
      {required this.name, required this.rocket, required this.flightNumber, required this.launchDate});

  final String? name;
  final String? rocket;
  final int? flightNumber;
  final String? launchDate;

  factory Mission.fromJson(Map<String, dynamic> json) => Mission(
        name: json["name"],
        rocket: json["rocket"],
        flightNumber: json["flight_number"],
        launchDate: json["date_utc"]
      );
}
