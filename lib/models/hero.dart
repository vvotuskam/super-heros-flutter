import 'package:json_parse_lab/models/appearance.dart';
import 'package:json_parse_lab/models/biography.dart';
import 'package:json_parse_lab/models/connections.dart';
import 'package:json_parse_lab/models/images.dart';
import 'package:json_parse_lab/models/powerstats.dart';
import 'package:json_parse_lab/models/work.dart';

class Hero {
  int? id;
  String? name;
  String? slug;
  Powerstats? powerstats;
  Appearance? appearance;
  Biography? biography;
  Work? work;
  Connections? connections;
  Images? images;

  Hero(
      {this.id,
        this.name,
        this.slug,
        this.powerstats,
        this.appearance,
        this.biography,
        this.work,
        this.connections,
        this.images});

  Hero.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    powerstats = json['powerstats'] != null
        ? new Powerstats.fromJson(json['powerstats'])
        : null;
    appearance = json['appearance'] != null
        ? new Appearance.fromJson(json['appearance'])
        : null;
    biography = json['biography'] != null
        ? new Biography.fromJson(json['biography'])
        : null;
    work = json['work'] != null ? new Work.fromJson(json['work']) : null;
    connections = json['connections'] != null
        ? new Connections.fromJson(json['connections'])
        : null;
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    if (this.powerstats != null) {
      data['powerstats'] = this.powerstats!.toJson();
    }
    if (this.appearance != null) {
      data['appearance'] = this.appearance!.toJson();
    }
    if (this.biography != null) {
      data['biography'] = this.biography!.toJson();
    }
    if (this.work != null) {
      data['work'] = this.work!.toJson();
    }
    if (this.connections != null) {
      data['connections'] = this.connections!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    return data;
  }
}