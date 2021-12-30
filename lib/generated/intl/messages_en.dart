// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(value) => "To install - ${value}";

  static String m1(value) => "You have: ${value} pieces";

  static String m2(value) => "Level ${value}";

  static String m3(value) => "${value} level ";

  static String m4(symbol) => "Sold ${symbol} for the amount";

  static String m5(symbol) => "Mined ${symbol}";

  static String m6(value) => "${value}\$";

  static String m7(value) => "${value}\$/month";

  static String m8(value) => "${value} V/h";

  static String m9(value) => "${value} U/dex";

  static String m10(value1, value2) => "${value1}/${value2}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "game_global_app_bar_cash":
            MessageLookupByLibrary.simpleMessage("Cash"),
        "game_global_app_bar_crypto":
            MessageLookupByLibrary.simpleMessage("Cryptocurrency"),
        "game_global_footer_consume":
            MessageLookupByLibrary.simpleMessage("Costs"),
        "game_global_footer_consume_energy":
            MessageLookupByLibrary.simpleMessage("Electricity"),
        "game_global_footer_consume_flat":
            MessageLookupByLibrary.simpleMessage("Place"),
        "game_global_footer_income":
            MessageLookupByLibrary.simpleMessage("Daily earnings"),
        "game_global_footer_level":
            MessageLookupByLibrary.simpleMessage("Level place"),
        "game_global_footer_place":
            MessageLookupByLibrary.simpleMessage("Place"),
        "game_global_footer_power":
            MessageLookupByLibrary.simpleMessage("Power"),
        "game_global_modal_game_over_return":
            MessageLookupByLibrary.simpleMessage("To the main menu"),
        "game_global_modal_game_over_statistic":
            MessageLookupByLibrary.simpleMessage("Statistics"),
        "game_global_modal_game_over_title":
            MessageLookupByLibrary.simpleMessage("YOU LOST"),
        "game_main_actions_buy_flat":
            MessageLookupByLibrary.simpleMessage("Buy a place"),
        "game_main_actions_buy_pc":
            MessageLookupByLibrary.simpleMessage("Buy computers"),
        "game_main_actions_crypto_wallet":
            MessageLookupByLibrary.simpleMessage("Cryptocurrency"),
        "game_main_actions_statistics":
            MessageLookupByLibrary.simpleMessage("Statistics"),
        "game_main_modal_exit_no": MessageLookupByLibrary.simpleMessage("No"),
        "game_main_modal_exit_title": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to go to the menu?"),
        "game_main_modal_exit_yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "game_main_modal_tokens_button_active":
            MessageLookupByLibrary.simpleMessage("ACTIVELY"),
        "game_main_modal_tokens_button_scam":
            MessageLookupByLibrary.simpleMessage("SCAM"),
        "game_main_modal_tokens_button_select":
            MessageLookupByLibrary.simpleMessage("Select"),
        "game_main_modal_tokens_exit":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "game_main_modal_tokens_info_current_cost":
            MessageLookupByLibrary.simpleMessage("Current price"),
        "game_main_modal_tokens_info_month_cost":
            MessageLookupByLibrary.simpleMessage("Price a month ago"),
        "game_main_modal_tokens_sub_title": m0,
        "game_main_modal_tokens_title":
            MessageLookupByLibrary.simpleMessage("Choose a cryptocurrency"),
        "game_main_news": MessageLookupByLibrary.simpleMessage("News"),
        "game_main_pcs_assign": MessageLookupByLibrary.simpleMessage("ASSIGN"),
        "game_main_pcs_mining": MessageLookupByLibrary.simpleMessage("Mined"),
        "game_main_upgrade_info_critical":
            MessageLookupByLibrary.simpleMessage("Crit"),
        "game_main_upgrade_info_critical_probability":
            MessageLookupByLibrary.simpleMessage("Crit"),
        "game_main_upgrade_info_max":
            MessageLookupByLibrary.simpleMessage("Max"),
        "game_main_upgrade_info_min":
            MessageLookupByLibrary.simpleMessage("Min"),
        "game_main_upgrade_info_title":
            MessageLookupByLibrary.simpleMessage("Money per click"),
        "game_main_upgrade_level": MessageLookupByLibrary.simpleMessage("LVL"),
        "game_main_upgrade_title":
            MessageLookupByLibrary.simpleMessage("Upgrade"),
        "game_market_crypto_available":
            MessageLookupByLibrary.simpleMessage("Available"),
        "game_market_crypto_buy_button":
            MessageLookupByLibrary.simpleMessage("BUY"),
        "game_market_crypto_buy_title":
            MessageLookupByLibrary.simpleMessage("Purchase"),
        "game_market_crypto_sell_button":
            MessageLookupByLibrary.simpleMessage("SELL"),
        "game_market_crypto_sell_title":
            MessageLookupByLibrary.simpleMessage("Sale"),
        "game_market_flat_button_buy":
            MessageLookupByLibrary.simpleMessage("BUY"),
        "game_market_flat_button_have":
            MessageLookupByLibrary.simpleMessage("ACQUIRED"),
        "game_market_flat_info_cost":
            MessageLookupByLibrary.simpleMessage("Price"),
        "game_market_flat_info_count_pc":
            MessageLookupByLibrary.simpleMessage("Number of computers"),
        "game_market_flat_info_level":
            MessageLookupByLibrary.simpleMessage("LVL"),
        "game_market_flat_info_month_cost":
            MessageLookupByLibrary.simpleMessage("Monthly Fee"),
        "game_market_flat_lock_title":
            MessageLookupByLibrary.simpleMessage("Not enough cash to buy"),
        "game_market_flat_status_active_title":
            MessageLookupByLibrary.simpleMessage("ACTIVELY"),
        "game_market_flat_title":
            MessageLookupByLibrary.simpleMessage("Buy a place"),
        "game_market_pc_button_buy":
            MessageLookupByLibrary.simpleMessage("Buy"),
        "game_market_pc_button_sell":
            MessageLookupByLibrary.simpleMessage("Sell"),
        "game_market_pc_info_cost":
            MessageLookupByLibrary.simpleMessage("Price"),
        "game_market_pc_info_cost_sell":
            MessageLookupByLibrary.simpleMessage("Selling price"),
        "game_market_pc_info_cost_sell_minus":
            MessageLookupByLibrary.simpleMessage("electr"),
        "game_market_pc_info_count": m1,
        "game_market_pc_info_energy":
            MessageLookupByLibrary.simpleMessage("Electricity"),
        "game_market_pc_info_level": m2,
        "game_market_pc_info_no_level_1":
            MessageLookupByLibrary.simpleMessage("To purchase you need "),
        "game_market_pc_info_no_level_2": m3,
        "game_market_pc_info_no_level_3":
            MessageLookupByLibrary.simpleMessage("place"),
        "game_market_pc_info_power":
            MessageLookupByLibrary.simpleMessage("Power"),
        "game_market_pc_lock_title": MessageLookupByLibrary.simpleMessage(
            "Insufficient level of premises for purchase"),
        "game_market_pc_title":
            MessageLookupByLibrary.simpleMessage("Buy computers"),
        "game_wallet_assets_title":
            MessageLookupByLibrary.simpleMessage("Asset allocation"),
        "game_wallet_hide_null":
            MessageLookupByLibrary.simpleMessage("Hide zero balances"),
        "game_wallet_tokens_title":
            MessageLookupByLibrary.simpleMessage("Cryptocurrency wallet"),
        "main_game_stat_consume": MessageLookupByLibrary.simpleMessage("Costs"),
        "main_game_stat_consume_buyFlat":
            MessageLookupByLibrary.simpleMessage("Spent on home purchases"),
        "main_game_stat_consume_buyPC":
            MessageLookupByLibrary.simpleMessage("Spent on PC purchases"),
        "main_game_stat_consume_energy":
            MessageLookupByLibrary.simpleMessage("Spent on electricity"),
        "main_game_stat_consume_flat":
            MessageLookupByLibrary.simpleMessage("Spent on housing"),
        "main_game_stat_crypto":
            MessageLookupByLibrary.simpleMessage("Cryptocurrencies"),
        "main_game_stat_crypto_earn": m4,
        "main_game_stat_crypto_mining": m5,
        "main_game_stat_deals":
            MessageLookupByLibrary.simpleMessage("Transactions"),
        "main_game_stat_deals_count_buy":
            MessageLookupByLibrary.simpleMessage("Buy deals completed"),
        "main_game_stat_deals_count_sell":
            MessageLookupByLibrary.simpleMessage("Sell ​​deals"),
        "main_game_stat_deals_volume_buy":
            MessageLookupByLibrary.simpleMessage("Purchase volume"),
        "main_game_stat_deals_volume_sell":
            MessageLookupByLibrary.simpleMessage("Volume of sales"),
        "main_game_stat_other": MessageLookupByLibrary.simpleMessage("Other"),
        "main_game_stat_other_clicker_count":
            MessageLookupByLibrary.simpleMessage(
                "Number of clicks on the computer"),
        "main_game_stat_other_clicker_crit_count":
            MessageLookupByLibrary.simpleMessage("Number of crits"),
        "main_game_stat_other_clicker_earn":
            MessageLookupByLibrary.simpleMessage("Earned on clicks"),
        "main_game_stat_other_days":
            MessageLookupByLibrary.simpleMessage("Number of days passed"),
        "main_game_stat_sum": MessageLookupByLibrary.simpleMessage("Sum"),
        "main_game_stat_title":
            MessageLookupByLibrary.simpleMessage("Statistics"),
        "menu_app_bar": MessageLookupByLibrary.simpleMessage("CRYPTO TYCOON"),
        "menu_button_authors": MessageLookupByLibrary.simpleMessage("AUTHORS"),
        "menu_button_back": MessageLookupByLibrary.simpleMessage("BACK"),
        "menu_button_continue_game":
            MessageLookupByLibrary.simpleMessage("CONTINUE"),
        "menu_button_new_game":
            MessageLookupByLibrary.simpleMessage("NEW GAME"),
        "menu_button_play": MessageLookupByLibrary.simpleMessage("PLAY"),
        "menu_button_settings":
            MessageLookupByLibrary.simpleMessage("SETTINGS"),
        "menu_settings_language":
            MessageLookupByLibrary.simpleMessage("LANGUAGE"),
        "menu_settings_music": MessageLookupByLibrary.simpleMessage("Music"),
        "menu_settings_sound": MessageLookupByLibrary.simpleMessage("Sound"),
        "menu_settings_title": MessageLookupByLibrary.simpleMessage("Settings"),
        "text_with_dollar": m6,
        "text_with_dollar_month": m7,
        "text_with_energy": m8,
        "text_with_power_mining": m9,
        "text_with_slash": m10
      };
}
