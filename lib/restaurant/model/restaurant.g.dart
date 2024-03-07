// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      location: json['location'] as String,
      ratings: (json['ratings'] as List<dynamic>).map((e) => e as int),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>)),
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'location': instance.location,
      'ratings': instance.ratings.toList(),
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
    };
