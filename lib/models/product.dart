class ProductList {
  ProductList({required this.categoryName, required this.products, this.nextPage});

  final String categoryName;
  final List<Product> products;
  final int? nextPage;
}

class Product {

  Product({required this.id, required this.category, required this.title, required this.description, required this.price, required this.fiat, required this.texture, required this.wash, required this.place, required this.note, required this.story, required this.mainImgUrl, required this.imageURLs, required this.variants, required this.colors, required this.sizes});

  final int id;
  final String category;
  final String title;
  final String description;
  final int price;
  final String fiat;
  final String texture;
  final String wash;
  final String place;
  final String note;
  final String story;
  final String mainImgUrl;
  final List<String> imageURLs;
  final List<Variant> variants;
  final List<ProductColor> colors;
  final List<ProductSize> sizes;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      fiat: 'NT\$',
      texture: json['texture'],
      wash: json['wash'],
      place: json['place'],
      note: json['note'],
      story: json['story'],
      mainImgUrl: json['main_image'],
      imageURLs: (json['images'] as List).map((image) => image.toString()).toList(),
      variants: (json['variants'] as List).map((variant) => Variant.fromJson(variant)).toList(),
      colors: (json['colors'] as List).map((color) => ProductColor.fromJSON(color)).toList(),
      sizes: (json['sizes'] as List).map((size) => ProductSize.values.byName(size)).toList(),
    );
  }
}

class ProductColor {
  ProductColor({required this.colorCode, required this.name});

  final String colorCode;
  final String name;

  factory ProductColor.fromJSON(Map<String, dynamic> json) {
    return ProductColor(colorCode: json['code'], name: json['name']);
  }
}

enum ProductSize { S, M, L }

class Variant {
  Variant({required this.colorCode, required this.size, required this.stock});

  final String colorCode;
  final ProductSize size;
  final int stock;

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(colorCode: json['color_code'], size: ProductSize.values.byName(json['size']), stock: json['stock']);
  }
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