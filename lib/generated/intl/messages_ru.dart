// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(symbol) => "Заработано на ${symbol}";

  static String m1(symbol) => "Добыто ${symbol}";

  static String m2(value) => "${value}\$";

  static String m3(value) => "${value} Ват/ч";

  static String m4(value) => "${value} U/dex";

  static String m5(value1, value2) => "${value1}/${value2}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "main_game_action_buy_flat_title":
            MessageLookupByLibrary.simpleMessage("Купить помещение"),
        "main_game_action_buy_pc_title":
            MessageLookupByLibrary.simpleMessage("Купить установки"),
        "main_game_action_crypto_title":
            MessageLookupByLibrary.simpleMessage("Кошелек криптовалют"),
        "main_game_action_mining_title":
            MessageLookupByLibrary.simpleMessage("Добыча криптовалют"),
        "main_game_appbar_title":
            MessageLookupByLibrary.simpleMessage("Криптовалютный IDLE"),
        "main_game_cash_balance_title":
            MessageLookupByLibrary.simpleMessage("Наличные"),
        "main_game_crypto_balance_title":
            MessageLookupByLibrary.simpleMessage("Криптовалюта"),
        "main_game_info_count_pc_title":
            MessageLookupByLibrary.simpleMessage("Количество установок"),
        "main_game_info_energy_title":
            MessageLookupByLibrary.simpleMessage("Потребление энергии"),
        "main_game_info_place_title":
            MessageLookupByLibrary.simpleMessage("Место"),
        "main_game_info_power_mining_title":
            MessageLookupByLibrary.simpleMessage("Мощность майнинга"),
        "main_game_info_title":
            MessageLookupByLibrary.simpleMessage("Основное"),
        "main_game_month_energy_title":
            MessageLookupByLibrary.simpleMessage("Оплата электричества"),
        "main_game_month_flat_title":
            MessageLookupByLibrary.simpleMessage("Оплата жилья"),
        "main_game_month_title":
            MessageLookupByLibrary.simpleMessage("Ежемесячные расходы"),
        "main_game_stat_earn_on_crypto_title": m0,
        "main_game_stat_mining_on_crypto_title": m1,
        "main_game_stat_spend_all_title":
            MessageLookupByLibrary.simpleMessage("Потрачено за все время"),
        "main_game_stat_spend_energy_title":
            MessageLookupByLibrary.simpleMessage("Потрачено на электричество"),
        "main_game_stat_spend_flat_title":
            MessageLookupByLibrary.simpleMessage("Потрачено на жилье"),
        "main_game_stat_title":
            MessageLookupByLibrary.simpleMessage("Статистика"),
        "text_with_dollar": m2,
        "text_with_energy": m3,
        "text_with_power_mining": m4,
        "text_with_slash": m5
      };
}
