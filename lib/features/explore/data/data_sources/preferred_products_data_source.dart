
import 'package:experience_app/features/explore/data/models/preferred_products_model.dart';

class PreferredProductsDataSource {

  Future<List<PreferredProductsModel>> getPreferredProducts() async {
    await Future.delayed(Duration(seconds: 1));
    const mockData = [
      {'id': 1, 'name': 'Camisa formal', 'imageUrl': 'https://tommyguatemala.vtexassets.com/arquivos/ids/542721-1200-auto?v=638697576778830000&width=1200&height=auto&aspect=true'},
      {'id': 2, 'name': 'Vestido', 'imageUrl': 'https://tommyguatemala.vtexassets.com/arquivos/ids/559866-1200-auto?v=638761558184130000&width=1200&height=auto&aspect=true'},
      {'id': 3, 'name': 'Camisa Casual', 'imageUrl': 'https://tommyguatemala.vtexassets.com/arquivos/ids/624760-1200-auto?v=639003706307800000&width=1200&height=auto&aspect=true'},
    ];
    return mockData.map((json) => PreferredProductsModel.fromJson(json)).toList();
  }
}