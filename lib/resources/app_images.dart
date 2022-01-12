import 'package:crypto_tycoon/initial_data.dart';

class AppImages {
  static String getTokenPathBySymbol(String symbol) {
    final result = 'assets/images/tokens/${symbol.toLowerCase()}.png';
    return result;
  }

  static String getPcPathByName(String name) {
    final index = InitialDataNames.namePCs.indexWhere((pcName) => pcName == name);
    const mainPath = 'assets/images/pcs/';
    // if (index == -1 || index > 6) return '${mainPath}1.png';
    return '$mainPath${index + 1}.png';
  }

  static String getFlatPathByName(String name) {
    final index = InitialDataNames.nameFlats.indexWhere((flatName) => flatName == name);
    const mainPath = 'assets/images/flats/';
    if (index == -1) return '${mainPath}1.png';
    return '$mainPath${index + 1}.png';
  }

  static const imageCompTap = 'assets/images/pcs/comp_tap.png';
}
