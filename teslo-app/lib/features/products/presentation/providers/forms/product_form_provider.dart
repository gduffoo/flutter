import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/infraestructure/inputs/inputs.dart';

final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProfuctFormState, Product>((ref, product) {
  //se cambia x funcion del repositorio de products para que actualize listado automaticamente
  //final createUpdateCallback =
  //    ref.watch(productsRepositoryProvider).createUpdateProduct;

  final createUpdateCallback =
      ref.watch(productsProvider.notifier).createOrUpdateProduct;

  return ProductFormNotifier(
      product: product, onSubmitCallback: createUpdateCallback);
});

class ProductFormNotifier extends StateNotifier<ProfuctFormState> {
  final Future<bool> Function(Map<String, dynamic> productLike)?
      onSubmitCallback;

  ProductFormNotifier({
    required Product product,
    this.onSubmitCallback,
  }) : super(
          ProfuctFormState(
            id: product.id,
            title: Title.dirty(product.title),
            price: Price.dirty(product.price),
            description: product.description,
            slug: Slug.dirty(product.slug),
            inStock: Stock.dirty(product.stock),
            sizes: product.sizes,
            gender: product.gender,
            tags: product.tags.join(
                ', '), //covierte el listado de strig a un string separados x ,
            images: product.images,
          ),
        );

  Future<bool> onformSubmit() async {
    _touchEverithing();
    if (!state.isformValid) return false;

    if (onSubmitCallback == null) return false;

    final producLike = {
      'id': (state.id == "new") ? null : state.id,
      'title': state.title.value,
      'price': state.price.value,
      'description': state.description,
      'slug': state.slug.value,
      'stock': state.inStock.value,
      'sizes': state.sizes,
      'gender': state.gender,
      'tags': state.tags.split(","),
      'images': state.images
          .map((image) =>
              image.replaceAll('${Environment.apiUrl}/files/product/', ""))
          .toList()
    };
    try {
      return await onSubmitCallback!(producLike);
      //return true;
    } catch (e) {
      return false;
    }
  }

  void _touchEverithing() {
    state = state.copyWith(
      isformValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void updateProductImage(String path) {
    state = state.copyWith(
      images: [...state.images, path],
    );
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
      title: Title.dirty(value),
      isformValid: Formz.validate([
        Title.dirty(value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
      slug: Slug.dirty(value),
      isformValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
      price: Price.dirty(value),
      isformValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(value),
        Stock.dirty(state.inStock.value),
      ]),
    );
  }

  void onStockChanged(int value) {
    state = state.copyWith(
      inStock: Stock.dirty(value),
      isformValid: Formz.validate([
        Title.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(value),
      ]),
    );
  }

  void onSizesChanged(List<String> value) {
    state = state.copyWith(sizes: value);
  }

  void onGenderChanged(String value) {
    state = state.copyWith(gender: value);
  }

  void onDescriptionChanged(String value) {
    state = state.copyWith(description: value);
  }

  void onTagsChanged(String value) {
    state = state.copyWith(tags: value);
  }
}

class ProfuctFormState {
  final bool isformValid;
  final String? id;
  final Title title;
  final Price price;
  final String description;
  final Slug slug;
  final Stock inStock;
  final List<String> sizes;
  final String gender;
  final String tags;
  final List<String> images;

  ProfuctFormState({
    this.isformValid = false,
    this.id,
    this.title = const Title.dirty(""),
    this.price = const Price.dirty(0.0),
    this.description = "",
    this.slug = const Slug.dirty(""),
    this.inStock = const Stock.dirty(0),
    this.sizes = const [],
    this.gender = 'men',
    this.tags = "",
    this.images = const [],
  });

  ProfuctFormState copyWith({
    bool? isformValid,
    String? id,
    Title? title,
    Price? price,
    String? description,
    Slug? slug,
    Stock? inStock,
    List<String>? sizes,
    String? gender,
    String? tags,
    List<String>? images,
  }) =>
      ProfuctFormState(
          isformValid: isformValid ?? this.isformValid,
          id: id ?? this.id,
          title: title ?? this.title,
          price: price ?? this.price,
          description: description ?? this.description,
          slug: slug ?? this.slug,
          inStock: inStock ?? this.inStock,
          sizes: sizes ?? this.sizes,
          gender: gender ?? this.gender,
          tags: tags ?? this.tags,
          images: images ?? this.images);
}
