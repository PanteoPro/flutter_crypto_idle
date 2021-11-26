import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:hive/hive.dart';

class PCDataProvider {
  late Box<PC> _box;
  late Box<PC> _constBox;

  Future<void> openBox() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(PCAdapter());
    }
    if (Hive.isBoxOpen('pc')) {
      _box = Hive.box<PC>('pc');
    } else {
      _box = await Hive.openBox<PC>('pc');
    }

    if (Hive.isBoxOpen('pc_const')) {
      _constBox = Hive.box<PC>('pc_const');
    } else {
      _constBox = await Hive.openBox<PC>('pc_const');
    }
  }

  Future<List<PC>> loadAll() async {
    return _box.values.toList();
  }

  Future<void> savePC(PC pc) async {
    await _box.add(pc);
  }

  Future<bool> deletePC(PC pc) async {
    try {
      var keyToDelete;
      _box.toMap().forEach((key, value) {
        if (value.id == pc.id) {
          keyToDelete = key;
        }
      });
      if (keyToDelete != null) {
        await _box.delete(keyToDelete);
        return true;
      } else {
        return false;
      }
    } catch (_) {
      // error? not find
      print('cant delete pc in own box');
      return false;
    }
  }

  Future<List<PC>> loadAllConst() async {
    return _constBox.values.toList();
  }

  Future<PC> loadByIdConst(int id) async {
    return _constBox.get(id) ?? PC.empty();
  }
}
