import 'dart:async';

import 'package:crypto_tycoon/domain/data_providers/flat_data_provider.dart';
import 'package:crypto_tycoon/domain/entities/flat.dart';
import 'package:crypto_tycoon/domain/repositories/my_repository.dart';

enum FlatRepositoryStreamEvents { addFlat, changeFlat }

class FlatRepository implements MyRepository {
  final _flatDataProvider = FlatDataProvider();
  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  var _flats = <Flat>[];
  List<Flat> get flats => _flats;
  Flat get currentFlat {
    try {
      return _flats.firstWhere((element) => element.isActive);
    } catch (_) {
      return Flat.empty();
    }
  }

  @override
  Future<void> init() async {
    await _flatDataProvider.openBox();
    updateData();
    stream ??= _streamController.stream.asBroadcastStream();
  }

  @override
  void updateData() {
    _flats = _flatDataProvider.loadData();
  }

  Future<void> addFlat(Flat flat) async {
    _flats.add(flat);
    await _flatDataProvider.saveData(flat);
    _streamController.add(FlatRepositoryStreamEvents.addFlat);
  }

  Future<void> changeFlat(Flat flat, {bool? isActive, bool? isBuy}) async {
    if (isActive != null) {
      flat.isActive = isActive;
    }
    if (isBuy != null) {
      flat.isBuy = isBuy;
    }
    await flat.save();
    _streamController.add(FlatRepositoryStreamEvents.changeFlat);
  }
}
