import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/products_repository_provider.dart';

//enlazar el notifier con el state
final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductState>((ref) {
  final productsRepository = ref.watch(productRepositoryProvider);

  return ProductsNotifier(productsRepository: productsRepository);
});

//2 como se manejan los datos del state
class ProductsNotifier extends StateNotifier<ProductState> {
  final ProductsRepository productsRepository;

  ProductsNotifier({required this.productsRepository}) : super(ProductState()) {
    loadNextPage(); //cuando se crea la instancia carga los datos
  }

  Future loadNextPage() async {
    //evitar que llamen varias veces el motodo
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getProductByPage(
        limit: state.limit, offset: state.offset);

    if (products.isEmpty) {
      state.copyWith(
        isLoading: false,
        isLastPage: true,
      );
      return;
    }

    state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        products: [...state.products, ...products]);
  }
}

//1 que datos se quieren controlar
class ProductState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

/*
  ProductState(
      {required this.isLastPage,
      required this.limit,
      required this.offset,
      required this.isLoading,
      required this.products});
*/
  ProductState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.products = const [],
  });

  ProductState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products,
  }) =>
      ProductState(
          isLastPage: isLastPage ?? this.isLastPage,
          limit: limit ?? this.limit,
          offset: offset ?? this.offset,
          isLoading: isLoading ?? this.isLoading,
          products: products ?? this.products);
}
