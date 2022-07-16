import 'dart:async';

import 'package:barcode_scanner/models/barcode.dart';
import 'package:barcode_scanner/repositories/barcodes_local_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'barcode_event.dart';

part 'barcode_state.dart';

class BarcodeBloc extends Bloc<BarcodeEvent, BarcodeState> {
  BarcodeBloc(this._barCodesLocalRepository) : super(const BarcodeState()) {
    on<BarcodeLoaded>(_onBarcodeLoaded);
    on<BarcodeAddPressed>(_onBarcodeAddPressed);
    on<BarcodeDeletePressed>(_onBarcodeDeletePressed);
  }

  final BarcodesLocalRepository _barCodesLocalRepository;

  Future<void> _onBarcodeLoaded(BarcodeLoaded event, Emitter<BarcodeState> emit) async {
    try {
      final barcodes = await _barCodesLocalRepository.loadBarCodes();
      return emit(state.copyWith(status: BarcodeStatus.success, barcodes: barcodes));
    } catch (e) {
      return emit(state.copyWith(status: BarcodeStatus.failure));
    }
  }

  Future<void> _onBarcodeAddPressed(BarcodeAddPressed event, Emitter<BarcodeState> emit) async {
    _barCodesLocalRepository.addBarCode(event.barcode);
    return emit(state.copyWith(barcodes: List.of(state.barcodes)..add(event.barcode)));
  }

  Future<void> _onBarcodeDeletePressed(BarcodeDeletePressed event, Emitter<BarcodeState> emit) async {
    _barCodesLocalRepository.deleteBarCode(event.barcode);
    return emit(state.copyWith(barcodes: List.of(state.barcodes)..remove(event.barcode)));
  }
}
