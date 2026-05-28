import 'package:experience_app/features/explore/data/models/product_section_model.dart';

class ProductSectionsDataSource {
  Future<List<ProductSectionModel>> getPreferredProducts() async {
    await Future.delayed(Duration(seconds: 10));
    const mockData = [
      {
        'title': 'Perfect for you today',
        'products': [
          {
            'id': '1A',
            'name': 'Amazing T-shirt',
            'price': 12.00,
            'image':
                'https://emprendepyme.net/wp-content/uploads/2023/03/cualidades-producto.jpg',
          },
          {
            'id': '2',
            'name': 'Fabulous Pants',
            'price': 15.00,
            'image':
                'https://emprendepyme.net/wp-content/uploads/2023/03/cualidades-producto.jpg',
          },
          {
            'id': '3',
            'name': 'Cool Shoes',
            'price': 30.00,
            'image':
                'https://emprendepyme.net/wp-content/uploads/2023/03/cualidades-producto.jpg',
          },
          {
            'id': '4',
            'name': 'Modern Jacket',
            'price': 45.00,
            'image':
                'https://emprendepyme.net/wp-content/uploads/2023/03/cualidades-producto.jpg',
          },
        ],
      },
      {
        'title': 'For this summer',
        'products': [
          {
            'id': '5',
            'name': 'Summer Hat',
            'price': 10.00,
            'image':
                'https://emprendepyme.net/wp-content/uploads/2023/03/cualidades-producto.jpg',
          },
        ],
      },
    ];
    return mockData.map((json) => ProductSectionModel.fromJson(json)).toList();
  }
}
