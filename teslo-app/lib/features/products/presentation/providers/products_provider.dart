import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_repository_provider.dart';

//enlazar el notifier con el state
final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductsNotifier(productsRepository: productsRepository);
});

//2 como se manejan los datos del state
class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository productsRepository;

  ProductsNotifier({required this.productsRepository})
      : super(ProductsState()) {
    loadNextPage(); //cuando se crea la instancia carga los datos
  }

  Future<bool> createOrUpdateProduct(Map<String, dynamic> productLike) async {
    try {
      final product = await productsRepository.createUpdateProduct(productLike);
      final isProductInList =
          state.products.any((element) => element.id == product.id);
      if (!isProductInList) {
        //no existe
        state = state.copyWith(products: [...state.products, product]);
        return true;
      }

      state = state.copyWith(
          products: state.products
              .map((element) => (element.id == product.id) ? product : element)
              .toList());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future loadNextPage() async {
    //evitar que llamen varias veces el motodo
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getProductByPage(
        limit: state.limit, offset: state.offset);

    if (products.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true,
      );
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        products: [...state.products, ...products]);
  }
}

//1 que datos se quieren controlar
class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const [],
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  }) =>
      ProductsState(
          isLastPage: isLastPage ?? this.isLastPage,
          limit: limit ?? this.limit,
          offset: offset ?? this.offset,
          isLoading: isLoading ?? this.isLoading,
          products: products ?? this.products);
}
