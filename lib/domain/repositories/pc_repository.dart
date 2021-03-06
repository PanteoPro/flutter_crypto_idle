import 'dart:async';

import 'package:crypto_tycoon/domain/data_providers/pc_data_provider.dart';
import 'package:crypto_tycoon/domain/entities/pc.dart';
import 'package:crypto_tycoon/domain/entities/token.dart';
import 'package:crypto_tycoon/domain/repositories/my_repository.dart';

enum PCRepositoryStreamEvents { addPc, sellPc, changeMiningToken }

class PCRepository implements MyRepository {
  final _pcDataProvider = PCDataProvider();
  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

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

  @override
  Future<void> init() async {
    await _pcDataProvider.openBox();
    updateData();
    stream ??= _streamController.stream.asBroadcastStream();
  }

  @override
  void updateData() {
    _pcsConst = _pcDataProvider.loadAllConst();
    _pcs = _pcDataProvider.loadData();
  }

  Future<void> addPC(PC pc) async {
    await _pcDataProvider.saveData(pc);
    updateData();
    _streamController.add(PCRepositoryStreamEvents.addPc);
  }

  Future<bool> sellPC(PC pc) async {
    final result = await _pcDataProvider.deletePC(pc);
    if (result) {
      updateData();
      _streamController.add(PCRepositoryStreamEvents.sellPc);
    }
    return result;
  }

  Future<void> changeMiningToken(PC pc, [Token? token]) async {
    pc.miningToken = token;
    await pc.save();
    _streamController.add(PCRepositoryStreamEvents.changeMiningToken);
  }
}
