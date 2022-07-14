part of 'barcode_bloc.dart';

abstract class BarcodeEvent extends Equatable {
  const BarcodeEvent();
}

class LoadBarcodesFromLocalStorage extends BarcodeEvent {
  @override
  List<Object> get props => [];
}

class AddBarcode extends BarcodeEvent {
  final Barcode barcode;

  const AddBarcode(this.barcode);

  @override
  List<Object> get props => [barcode];
}

class DeleteBarcode extends BarcodeEvent {
  final Barcode barcode;

  const DeleteBarcode(this.barcode);

  @override
  List<Object> get props => [barcode];
}
