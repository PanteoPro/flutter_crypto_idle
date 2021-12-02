import 'dart:async';

import 'package:crypto_idle/domain/data_providers/flat_data_provider.dart';
import 'package:crypto_idle/domain/entities/flat.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';

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

  Future<void> init() async {
    await _flatDataProvider.openBox();
    await updateData();
    stream ??= _streamController.stream.asBroadcastStream();
  }

  Future<void> addFlat(Flat flat) async {
    _flats.add(flat);
    await _flatDataProvider.saveData(flat);
    _streamController.add('addFlat');
  }

  Future<void> changeFlat(Flat flat, {bool? isActive, bool? isBuy}) async {
    if (isActive != null) {
      flat.isActive = isActive;
    }
    if (isBuy != null) {
      flat.isBuy = isBuy;
    }
    await flat.save();
    _streamController.add('ChangeFlat');
  }

  @override
  Future<void> updateData() async {
    _flats = _flatDataProvider.loadData();
  }
}
