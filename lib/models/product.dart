import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

class ProductList {
  ProductList({required this.categoryName, required this.products, this.nextPage});

  final String categoryName;
  final List<Product> products;
  final int? nextPage;
}

@JsonSerializable()
class Product {

  Product({required this.id, required this.category, required this.title, required this.description, required this.price, required this.texture, required this.wash, required this.place, required this.note, required this.story, required this.mainImgUrl, required this.imageURLs, required this.variants, required this.colors, required this.sizes});

  final int id;
  final String category;
  final String title;
  final String description;
  final int price;
  final String texture;
  final String wash;
  final String place;
  final String note;
  final String story;

  @JsonKey(name: 'main_image')
  final String mainImgUrl;

  @JsonKey(includeFromJson: false, includeToJson: false, includeIfNull: false)
  final String fiat = 'NT\$';

  @JsonKey(name: 'images')
  final List<String> imageURLs;
  final List<Variant> variants;
  final List<ProductColor> colors;
  final List<ProductSize> sizes;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class ProductColor {
  ProductColor({required this.colorCode, required this.name});

  @JsonKey(name: 'code')
  final String colorCode;
  
  final String name;

  factory ProductColor.fromJson(Map<String, dynamic> json) => _$ProductColorFromJson(json);
  Map<String, dynamic> toJson() => _$ProductColorToJson(this);
}

enum ProductSize {
  @JsonValue("F") F,
  @JsonValue("S") S,
  @JsonValue("M") M,
  @JsonValue("L") L,
  @JsonValue("XL") XL
}

@JsonSerializable()
class Variant {
  Variant({required this.colorCode, required this.size, required this.stock});

  @JsonKey(name: 'color_code')
  final String colorCode;

  final ProductSize size;

  final int stock;

  factory Variant.fromJson(Map<String, dynamic> json) => _$VariantFromJson(json);
  Map<String, dynamic> toJson() => _$VariantToJson(this);
}

// {
//   "data": [
//     {
//       "id": 201807201824,
//       "category": "women",
//       "title": "前開衩扭結洋裝",
//       "description": "厚薄：薄\r\n彈性：無",
//       "price": 799,
//       "texture": "棉 100%",
//       "wash": "手洗，溫水",
//       "place": "中國",
//       "note": "實品顏色依單品照為主",
//       "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.",
//       "main_image": "https://api.appworks-school.tw/assets/201807201824/main.jpg",
//       "images": [
//         "https://api.appworks-school.tw/assets/201807201824/0.jpg",
//         "https://api.appworks-school.tw/assets/201807201824/1.jpg",
//         "https://api.appworks-school.tw/assets/201807201824/0.jpg",
//         "https://api.appworks-school.tw/assets/201807201824/1.jpg"
//       ],
//       "variants": [
//         {
//           "color_code": "FFFFFF",
//           "size": "S",
//           "stock": 2
//         },
//         {
//           "color_code": "FFFFFF",
//           "size": "M",
//           "stock": 1
//         },
//         {
//           "color_code": "FFFFFF",
//           "size": "L",
//           "stock": 2
//         },
//         {
//           "color_code": "DDFFBB",
//           "size": "S",
//           "stock": 9
//         },
//         {
//           "color_code": "DDFFBB",
//           "size": "M",
//           "stock": 0
//         },
//         {
//           "color_code": "DDFFBB",
//           "size": "L",
//           "stock": 5
//         },
//         {
//           "color_code": "CCCCCC",
//           "size": "S",
//           "stock": 8
//         },
//         {
//           "color_code": "CCCCCC",
//           "size": "M",
//           "stock": 5
//         },
//         {
//           "color_code": "CCCCCC",
//           "size": "L",
//           "stock": 9
//         }
//       ],
//       "colors": [
//         {
//           "code": "FFFFFF",
//           "name": "白色"
//         },
//         {
//           "code": "DDFFBB",
//           "name": "亮綠"
//         },
//         {
//           "code": "CCCCCC",
//           "name": "淺灰"
//         }
//       ],
//       "sizes": [
//         "S",
//         "M",
//         "L"
//       ]
//     },
//   ],
//   "next_paging": 1
// }