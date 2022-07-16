part of 'barcode_bloc.dart';

abstract class BarcodeEvent extends Equatable {
  const BarcodeEvent();
}

class BarcodeLoaded extends BarcodeEvent {
  @override
  List<Object> get props => [];
}

class BarcodeAddPressed extends BarcodeEvent {
  final Barcode barcode;

  const BarcodeAddPressed(this.barcode);

  @override
  List<Object> get props => [barcode];
}

class BarcodeDeletePressed extends BarcodeEvent {
  final Barcode barcode;

  const BarcodeDeletePressed(this.barcode);

  @override
  List<Object> get props => [barcode];
}
