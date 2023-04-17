// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      texture: json['texture'] as String,
      wash: json['wash'] as String,
      place: json['place'] as String,
      note: json['note'] as String,
      story: json['story'] as String,
      mainImgUrl: json['main_image'] as String,
      imageURLs:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      variants: (json['variants'] as List<dynamic>)
          .map((e) => Variant.fromJson(e as Map<String, dynamic>))
          .toList(),
      colors: (json['colors'] as List<dynamic>)
          .map((e) => ProductColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => $enumDecode(_$ProductSizeEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'texture': instance.texture,
      'wash': instance.wash,
      'place': instance.place,
      'note': instance.note,
      'story': instance.story,
      'main_image': instance.mainImgUrl,
      'images': instance.imageURLs,
      'variants': instance.variants,
      'colors': instance.colors,
      'sizes': instance.sizes.map((e) => _$ProductSizeEnumMap[e]!).toList(),
    };

const _$ProductSizeEnumMap = {
  ProductSize.F: 'F',
  ProductSize.S: 'S',
  ProductSize.M: 'M',
  ProductSize.L: 'L',
  ProductSize.XL: 'XL',
};

ProductColor _$ProductColorFromJson(Map<String, dynamic> json) => ProductColor(
      colorCode: json['code'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ProductColorToJson(ProductColor instance) =>
    <String, dynamic>{
      'code': instance.colorCode,
      'name': instance.name,
    };

Variant _$VariantFromJson(Map<String, dynamic> json) => Variant(
      colorCode: json['color_code'] as String,
      size: $enumDecode(_$ProductSizeEnumMap, json['size']),
      stock: json['stock'] as int,
    );

Map<String, dynamic> _$VariantToJson(Variant instance) => <String, dynamic>{
      'color_code': instance.colorCode,
      'size': _$ProductSizeEnumMap[instance.size]!,
      'stock': instance.stock,
    };
