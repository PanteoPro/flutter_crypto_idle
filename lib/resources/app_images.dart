import 'package:crypto_idle/initial_data.dart';

class AppImages {
  static String getTokenPathBySymbol(String symbol) {
    final result = 'assets/images/tokens/${symbol.toLowerCase()}.png';
    print(result);
    return result;
  }

  static String getPcPathByName(String name) {
    final index = InitialDataNames.namePCs.indexWhere((pcName) => pcName == name);
    const mainPath = 'assets/images/pcs/';
    if (index == -1) return '${mainPath}1.png';
    if (index >= 2) return '${mainPath}1.png';
    return '$mainPath${index + 1}.png';
  }

  static const imageCompTap = 'assets/images/pcs/comp_tap.png';

  static const iconComputer = 'assets/images/icons/computer_icon.png';
  static const iconLightning = 'assets/images/icons/lightning_icon.png';
  static const iconMute = 'assets/images/icons/mute_icon.png';
  static const iconUnmute = 'assets/images/icons/unmute_icon.png';
  static const iconSettings = 'assets/images/icons/settings_icon.png';
  static const iconDollar = 'assets/images/icons/dollar_icon.png';
  static const iconToken = 'assets/images/icons/token_icon.png';
  static const iconCalendar = 'assets/images/icons/calendar_icon.png';
  static const iconCalendarGif = 'assets/images/icons/calendar_icon.gif';
  static const iconCash = 'assets/images/icons/cash_icon.png';
  static const iconDown = 'assets/images/icons/down_icon.png';
  static const iconUp = 'assets/images/icons/up_icon.png';
  static const iconEmpty = 'assets/images/icons/empty_icon.png';
}
