import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign {
  final int id;
  final String story;

  @JsonKey(name: 'product_id')
  final int productId;

  @JsonKey(name: 'picture')
  final String pictureURL;

  const Campaign ({
    required this.id,
    required this.productId,
    required this.pictureURL,
    required this.story,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => _$CampaignFromJson(json);
  Map<String, dynamic> toJson() => _$CampaignToJson(this);
}

// {
//   "data": [
//     {
//       "id": 1,
//       "product_id": 201807242228,
//       "picture": "https://api.appworks-school.tw/assets/201807242228/keyvisual.jpg",
//       "story": "於是\r\n我也想要給你\r\n一個那麼美好的自己。\r\n不朽《與自己和好如初》"
//     },
//     {
//       "id": 2,
//       "product_id": 201807242222,
//       "picture": "https://api.appworks-school.tw/assets/201807242222/keyvisual.jpg",
//       "story": "永遠\r\n展現自信與專業\r\n無法抵擋的男人魅力。\r\n復古《再一次經典》"
//     },
//     {
//       "id": 3,
//       "product_id": 201807202140,
//       "picture": "https://api.appworks-school.tw/assets/201807202140/keyvisual.jpg",
//       "story": "瞬間\r\n在城市的角落\r\n找到失落多時的記憶。\r\n印象《都會故事集》"
//     }
//   ]
// }