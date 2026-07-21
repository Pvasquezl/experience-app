import 'package:experience_app/features/admin/products/domain/product_admin_entity.dart';
import 'package:experience_app/features/admin/products/domain/use_cases/create_product.dart';
import 'package:experience_app/features/admin/products/domain/use_cases/delete_product.dart';
import 'package:experience_app/features/admin/products/domain/use_cases/get_products.dart';
import 'package:experience_app/features/admin/products/domain/use_cases/update_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/legacy.dart';

class ProductsState {
  final List<ProductAdminEntity> products;
  final bool isLoading;
  final String? error;

  ProductsState({
    required this.products,
    this.isLoading = false,
    this.error,
  });

  ProductsState copyWith({
    List<ProductAdminEntity>? products,
    bool? isLoading,
    String? error,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ProductsNotifier extends StateNotifier<ProductsState> {
  final GetProductsUseCase _getProducts;
  final CreateProductUseCase _createProduct;
  final UpdateProductUseCase _updateProduct;
  final DeleteProductUseCase _deleteProduct;

  ProductsNotifier({
    GetProductsUseCase? getProducts,
    CreateProductUseCase? createProduct,
    UpdateProductUseCase? updateProduct,
    DeleteProductUseCase? deleteProduct,
  })  : _getProducts = getProducts ?? GetProductsUseCase(),
        _createProduct = createProduct ?? CreateProductUseCase(),
        _updateProduct = updateProduct ?? UpdateProductUseCase(),
        _deleteProduct = deleteProduct ?? DeleteProductUseCase(),
        super(ProductsState(products: [])) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true);
    try {
      final products = await _getProducts();
      state = state.copyWith(products: products, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addProduct(ProductAdminEntity product) async {
    try {
      final created = await _createProduct(product);
      state = state.copyWith(products: [...state.products, created]);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateProduct(ProductAdminEntity updated) async {
    try {
      final saved = await _updateProduct(updated);
      final updatedList =
          state.products.map((p) => p.id == saved.id ? saved : p).toList();
      state = state.copyWith(products: updatedList);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _deleteProduct(id);
      state = state.copyWith(
        products: state.products.where((p) => p.id != id).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

final productsNotifierProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>(
  (ref) => ProductsNotifier(),
);
