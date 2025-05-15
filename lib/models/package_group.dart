import 'package:json_annotation/json_annotation.dart';
import 'package.dart';

part 'package_group.g.dart';

@JsonSerializable()
class PackageGroup {
  final int id;
  @JsonKey(name: 'packageName')
  final String name;
  final String? description;
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
  @JsonKey(name: 'singleServices')
  final List<Package>? packages; // 可以为空
  final String? createTime;
  final String? updateTime;
  final String? relatedServiceIds;

  PackageGroup({
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
    this.packages,
    this.createTime,
    this.updateTime,
    this.relatedServiceIds,
  });

  static int _isDisplayToStatus(bool? isDisplay) {
    return isDisplay == true ? 1 : 0;
  }

  factory PackageGroup.fromJson(Map<String, dynamic> json) =>
      _$PackageGroupFromJson(json);
  Map<String, dynamic> toJson() => _$PackageGroupToJson(this);
}

@JsonSerializable()
class InnerPackageGroupResponse {
  final int code;
  final String? msg;
  final List<PackageGroup>? data;

  InnerPackageGroupResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory InnerPackageGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$InnerPackageGroupResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InnerPackageGroupResponseToJson(this);
}

@JsonSerializable()
class PackageGroupResponse {
  final int code;
  final String? msg;
  @JsonKey(fromJson: _extractInnerData)
  final List<PackageGroup>? data;

  PackageGroupResponse({
    required this.code,
    this.msg,
    this.data,
  });

  static List<PackageGroup>? _extractInnerData(Map<String, dynamic>? json) {
    if (json == null) return null;
    final innerResponse = InnerPackageGroupResponse.fromJson(json);
    return innerResponse.data;
  }

  factory PackageGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$PackageGroupResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PackageGroupResponseToJson(this);
}

@JsonSerializable()
class PackageGroupDetailResponse {
  final int code;
  final String? msg;
  final PackageGroup? data;

  PackageGroupDetailResponse({
    required this.code,
    this.msg,
    this.data,
  });

  factory PackageGroupDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$PackageGroupDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PackageGroupDetailResponseToJson(this);
}
