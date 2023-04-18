class Connections {
  String? groupAffiliation;
  String? relatives;

  Connections({this.groupAffiliation, this.relatives});

  Connections.fromJson(Map<String, dynamic> json) {
    groupAffiliation = json['groupAffiliation'];
    relatives = json['relatives'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupAffiliation'] = groupAffiliation;
    data['relatives'] = relatives;
    return data;
  }
}