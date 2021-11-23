import 'package:crypto_idle/domain/data_providers/pc_data_provider.dart';
import 'package:crypto_idle/domain/entities/pc.dart';

class PCRepository {
  final _pcDataProvider = PCDataProvider();

  var _pcsConst = <PC>[];
  List<PC> get pcsConst => List.unmodifiable(_pcsConst);

  var _pcs = <PC>[];
  List<PC> get pcs => List.unmodifiable(_pcs);

  PC? getByIdConst(int id) {
    try {
      return _pcsConst.firstWhere((PC pc) => pc.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> init() async {
    await _pcDataProvider.openBox();
    _pcsConst = await _pcDataProvider.loadAllConst();
    _pcs = await _pcDataProvider.loadAll();
  }

  Future<void> addPC(PC pc) async {
    await _pcDataProvider.savePC(pc);
    _pcs = await _pcDataProvider.loadAll();
  }

  Future<bool> sellPC(PC pc) async {
    final result = await _pcDataProvider.deletePC(pc);
    if (result) {
      _pcs = await _pcDataProvider.loadAll();
    }
    return result;
  }
}
