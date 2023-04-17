// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campaign _$CampaignFromJson(Map<String, dynamic> json) => Campaign(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      pictureURL: json['picture'] as String,
      story: json['story'] as String,
    );

Map<String, dynamic> _$CampaignToJson(Campaign instance) => <String, dynamic>{
      'id': instance.id,
      'story': instance.story,
      'product_id': instance.productId,
      'picture': instance.pictureURL,
    };
