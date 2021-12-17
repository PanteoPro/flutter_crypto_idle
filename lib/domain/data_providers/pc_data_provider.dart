import 'package:crypto_idle/domain/data_providers/my_hive_data_provider.dart';
import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:hive/hive.dart';

class PCDataProvider implements MyHiveDataProvider<PC> {
  late Box<PC> _box;
  late Box<PC> _constBox;

  @override
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

  @override
  List<PC> loadData() {
    return _box.values.toList();
  }

  @override
  Future<void> saveData(PC pc) async {
    await _box.add(pc);
  }

  Future<bool> deletePC(PC pc) async {
    try {
      dynamic keyToDelete;
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
      return false;
    }
  }

  List<PC> loadAllConst() {
    return _constBox.values.toList();
  }
}
