class Biography {
  String? fullName;
  String? alterEgos;
  List<String>? aliases;
  String? placeOfBirth;
  String? firstAppearance;
  String? publisher;
  String? alignment;

  Biography(
      {this.fullName,
        this.alterEgos,
        this.aliases,
        this.placeOfBirth,
        this.firstAppearance,
        this.publisher,
        this.alignment});

  Biography.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    alterEgos = json['alterEgos'];
    aliases = json['aliases'].cast<String>();
    placeOfBirth = json['placeOfBirth'];
    firstAppearance = json['firstAppearance'];
    publisher = json['publisher'];
    alignment = json['alignment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['alterEgos'] = this.alterEgos;
    data['aliases'] = this.aliases;
    data['placeOfBirth'] = this.placeOfBirth;
    data['firstAppearance'] = this.firstAppearance;
    data['publisher'] = this.publisher;
    data['alignment'] = this.alignment;
    return data;
  }

  @override
  String toString() {
    return 'place of birth: $placeOfBirth\nfirst appearance: $firstAppearance';
  }
}