import 'dart:async';

import 'package:barcode_scanner/models/barcode.dart';
import 'package:barcode_scanner/repositories/barcodes_local_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'barcode_event.dart';

part 'barcode_state.dart';

class BarcodeBloc extends Bloc<BarcodeEvent, BarcodeState> {
  BarcodeBloc({required this.barCodesLocalRepository}) : super(const BarcodeState()) {
    on<LoadBarcodesFromLocalStorage>(onLoadBarcodesFromLocalStorage);
    on<AddBarcode>(onAddBarcode);
    on<DeleteBarcode>(onDeleteBarcode);
  }

  final BarCodesLocalRepository barCodesLocalRepository;

  Future<void> onLoadBarcodesFromLocalStorage(LoadBarcodesFromLocalStorage event, Emitter<BarcodeState> emit) async {
    try {
      final barcodes = await barCodesLocalRepository.loadBarCodes();
      return emit(state.copyWith(status: BarcodeStatus.success, barcodes: barcodes));
    } catch (e) {
      return emit(state.copyWith(status: BarcodeStatus.failure));
    }
  }

  Future<void> onAddBarcode(AddBarcode event, Emitter<BarcodeState> emit) async {
    barCodesLocalRepository.addBarCode(event.barcode);
    return emit(state.copyWith(barcodes: List.of(state.barcodes)..add(event.barcode)));
  }

  Future<void> onDeleteBarcode(DeleteBarcode event, Emitter<BarcodeState> emit) async {
    barCodesLocalRepository.deleteBarCode(event.barcode);
    return emit(state.copyWith(barcodes: List.of(state.barcodes)..remove(event.barcode)));
  }
}
