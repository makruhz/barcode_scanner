part of 'barcode_bloc.dart';

enum BarcodeStatus { initial, success, failure }

class BarcodeState extends Equatable {
  const BarcodeState({
    this.status = BarcodeStatus.initial,
    this.barcodes = const [],
  });

  final BarcodeStatus status;
  final List<Barcode> barcodes;

  BarcodeState copyWith({
    BarcodeStatus? status,
    List<Barcode>? barcodes,
  }) {
    return BarcodeState(
      status: status ?? this.status,
      barcodes: barcodes ?? this.barcodes,
    );
  }

  @override
  List<Object> get props => [status, barcodes];
}
