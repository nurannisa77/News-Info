import 'dart:convert';

GetListNewsPortalResponseModel getListNewsPortalResponseModelFromJson(
        String str) =>
    GetListNewsPortalResponseModel.fromJson(json.decode(str));

String getListNewsPortalResponseModelToJson(
        GetListNewsPortalResponseModel data) =>
    json.encode(data.toJson());

class GetListNewsPortalResponseModel {
  final String? maintainer;
  final String? github;
  final List<Endpoint>? endpoints;

  GetListNewsPortalResponseModel({
    this.maintainer,
    this.github,
    this.endpoints,
  });

  factory GetListNewsPortalResponseModel.fromJson(Map<String, dynamic> json) =>
      GetListNewsPortalResponseModel(
        maintainer: json["maintainer"],
        github: json["github"],
        endpoints: json["endpoints"] == null
            ? []
            : List<Endpoint>.from(
                json["endpoints"]!.map((x) => Endpoint.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "maintainer": maintainer,
        "github": github,
        "endpoints": endpoints == null
            ? []
            : List<dynamic>.from(endpoints!.map((x) => x.toJson())),
      };
}

class Endpoint {
  final String? name;
  final List<Path>? paths;

  Endpoint({
    this.name,
    this.paths,
  });

  factory Endpoint.fromJson(Map<String, dynamic> json) => Endpoint(
        name: json["name"],
        paths: json["paths"] == null
            ? []
            : List<Path>.from(json["paths"]!.map((x) => Path.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "paths": paths == null
            ? []
            : List<dynamic>.from(paths!.map((x) => x.toJson())),
      };
}

class Path {
  final String? name;
  final String? path;

  Path({
    this.name,
    this.path,
  });

  factory Path.fromJson(Map<String, dynamic> json) => Path(
        name: json["name"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "path": path,
      };
}
