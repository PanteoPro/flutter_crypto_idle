import 'package:crypto_idle/domain/data_providers/flat_data_provider.dart';
import 'package:crypto_idle/domain/entities/flat.dart';

class FlatRepository {
  final _flatDataProvider = FlatDataProvider();

  var _flats = <Flat>[];
  List<Flat> get flats => _flats;

  Future<void> init() async {
    await _flatDataProvider.openBox();
    _flats = _flatDataProvider.loadData();
  }

  Future<void> addFlat(Flat flat) async {
    _flats.add(flat);
    await _flatDataProvider.saveData(flat);
  }

  Future<void> changeFlat(Flat flat, {bool? isActive, bool? isBuy}) async {
    if (isActive != null) {
      flat.isActive = isActive;
    }
    if (isBuy != null) {
      flat.isBuy = isBuy;
    }
    await flat.save();
  }
}
