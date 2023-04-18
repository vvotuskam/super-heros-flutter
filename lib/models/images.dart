class Images {
  String? xs;
  String? sm;
  String? md;
  String? lg;

  Images({this.xs, this.sm, this.md, this.lg});

  Images.fromJson(Map<String, dynamic> json) {
    xs = json['xs'];
    sm = json['sm'];
    md = json['md'];
    lg = json['lg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['xs'] = this.xs;
    data['sm'] = this.sm;
    data['md'] = this.md;
    data['lg'] = this.lg;
    return data;
  }
}