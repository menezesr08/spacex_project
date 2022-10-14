class Patch {
  Patch({
    required this.small,
    required this.large,
  });

  final String? small;
  final String? large;

  factory Patch.fromJson(Map<String, dynamic> json) => Patch(
        small: json["small"],
        large: json["large"],
      );
}
