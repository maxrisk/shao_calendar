import 'package:json_annotation/json_annotation.dart';

part 'package.g.dart';

@JsonSerializable()
class Package {
  final int id;
  @JsonKey(name: 'serviceName')
  final String name;
  final String description;
  @JsonKey(defaultValue: 0)
  final double price;
  @JsonKey(defaultValue: 0)
  final int originalPrice;
  @JsonKey(name: 'detailImage')
  final String? coverImage; // 可以为空
  final List<String>? images; // 可以为空
  final List<String>? benefits; // 可以为空
  @JsonKey(defaultValue: 0)
  final int validDays;
  @JsonKey(name: 'isDisplay', fromJson: _isDisplayToStatus)
  final int status; // 1: 上架, 0: 下架
  final String? createTime;
  final String? updateTime;

  Package({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    this.coverImage,
    this.images,
    this.benefits,
    required this.validDays,
    required this.status,
    this.createTime,
    this.updateTime,
  });

  static int _isDisplayToStatus(bool? isDisplay) {
    return isDisplay == true ? 1 : 0;
  }

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);
  Map<String, dynamic> toJson() => _$PackageToJson(this);
}

@JsonSerializable()
class InnerPackageResponse {
  final int code;
  final String? msg;
  final List<Package>? data;

  InnerPackageResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory InnerPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$InnerPackageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InnerPackageResponseToJson(this);
}

@JsonSerializable()
class PackageResponse {
  final int code;
  final String? msg;
  @JsonKey(fromJson: _extractInnerData)
  final List<Package>? data;

  PackageResponse({
    required this.code,
    this.msg,
    this.data,
  });

  static List<Package>? _extractInnerData(Map<String, dynamic>? json) {
    if (json == null) return null;
    final innerResponse = InnerPackageResponse.fromJson(json);
    return innerResponse.data;
  }

  factory PackageResponse.fromJson(Map<String, dynamic> json) =>
      _$PackageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PackageResponseToJson(this);
}

@JsonSerializable()
class PackageDetailResponse {
  final int code;
  final String? msg;
  final Package? data;

  PackageDetailResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory PackageDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PackageDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PackageDetailResponseToJson(this);
}
