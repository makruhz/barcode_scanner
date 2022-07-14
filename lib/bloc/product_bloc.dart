import 'dart:async';

import 'package:barcode_scanner/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<LoadProductFromLocalStorage>(onLoadProductFromLocalStorage);
    on<AddProduct>(onAddProduct);
    on<DeleteProduct>(onDeleteProduct);
  }

  Future<void> onLoadProductFromLocalStorage(LoadProductFromLocalStorage event, Emitter<ProductState> emit) async {
    Future.delayed(const Duration(seconds: 2));
    return emit(state.copyWith(status: ProductStatus.success, products: []));
  }

  Future<void> onAddProduct(AddProduct event, Emitter<ProductState> emit) async {
    return emit(state.copyWith(products: List.of(state.products)..add(event.product)));
  }

  Future<void> onDeleteProduct(DeleteProduct event, Emitter<ProductState> emit) async {
    return emit(state.copyWith(products: List.of(state.products)..remove(event.product)));
  }
}
