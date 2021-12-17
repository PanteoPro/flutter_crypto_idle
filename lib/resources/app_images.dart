import 'package:crypto_idle/initial_data.dart';

class AppImages {
  static String getTokenPathBySymbol(String symbol) {
    final result = 'assets/images/tokens/${symbol.toLowerCase()}.png';
    return result;
  }

  static String getPcPathByName(String name) {
    final index = InitialDataNames.namePCs.indexWhere((pcName) => pcName == name);
    const mainPath = 'assets/images/pcs/';
    if (index == -1) return '${mainPath}1.png';
    if (index >= 2) return '${mainPath}1.png';
    return '$mainPath${index + 1}.png';
  }

  static const image_comp_tap = 'assets/images/pcs/comp_tap.png';

  static const icon_computer = 'assets/images/icons/computer_icon.png';
  static const icon_lightning = 'assets/images/icons/lightning_icon.png';
  static const icon_mute = 'assets/images/icons/mute_icon.png';
  static const icon_unmute = 'assets/images/icons/unmute_icon.png';
  static const icon_settings = 'assets/images/icons/settings_icon.png';
  static const icon_dollar = 'assets/images/icons/dollar_icon.png';
  static const icon_token = 'assets/images/icons/token_icon.png';
  static const icon_calendar = 'assets/images/icons/calendar_icon.png';
  static const icon_calendar_gif = 'assets/images/icons/calendar_icon.gif';
  static const icon_cash = 'assets/images/icons/cash_icon.png';
  static const icon_down = 'assets/images/icons/down_icon.png';
  static const icon_up = 'assets/images/icons/up_icon.png';
}
