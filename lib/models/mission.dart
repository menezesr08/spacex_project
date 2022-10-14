class Mission {
    Mission({
        required this.name,
         required this.rocket,
    });

    final String name;
    final String rocket;

    factory Mission.fromJson(Map<String, dynamic> json) => Mission(
        name: json[0]["name"] ?? "",
        rocket: json[0]["rocket"] ?? "",
    );
}