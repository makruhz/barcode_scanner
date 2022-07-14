part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadProductFromLocalStorage extends ProductEvent {
  @override
  List<Object> get props => [];
}

class AddProduct extends ProductEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final Product product;

  const DeleteProduct(this.product);

  @override
  List<Object> get props => [product];
}
