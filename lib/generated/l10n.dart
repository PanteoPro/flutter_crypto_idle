// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Crypto IDLE`
  String get main_game_appbar_title {
    return Intl.message(
      'Crypto IDLE',
      name: 'main_game_appbar_title',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get main_game_cash_balance_title {
    return Intl.message(
      'Cash',
      name: 'main_game_cash_balance_title',
      desc: '',
      args: [],
    );
  }

  /// `Crypto`
  String get main_game_crypto_balance_title {
    return Intl.message(
      'Crypto',
      name: 'main_game_crypto_balance_title',
      desc: '',
      args: [],
    );
  }

  /// `Buy PC's`
  String get main_game_action_buy_pc_title {
    return Intl.message(
      'Buy PC\'s',
      name: 'main_game_action_buy_pc_title',
      desc: '',
      args: [],
    );
  }

  /// `Buy flat`
  String get main_game_action_buy_flat_title {
    return Intl.message(
      'Buy flat',
      name: 'main_game_action_buy_flat_title',
      desc: '',
      args: [],
    );
  }

  /// `Mining crypto`
  String get main_game_action_mining_title {
    return Intl.message(
      'Mining crypto',
      name: 'main_game_action_mining_title',
      desc: '',
      args: [],
    );
  }

  /// `Purse crypto`
  String get main_game_action_crypto_title {
    return Intl.message(
      'Purse crypto',
      name: 'main_game_action_crypto_title',
      desc: '',
      args: [],
    );
  }

  /// `Main`
  String get main_game_info_title {
    return Intl.message(
      'Main',
      name: 'main_game_info_title',
      desc: '',
      args: [],
    );
  }

  /// `Place`
  String get main_game_info_place_title {
    return Intl.message(
      'Place',
      name: 'main_game_info_place_title',
      desc: '',
      args: [],
    );
  }

  /// `Count PC`
  String get main_game_info_count_pc_title {
    return Intl.message(
      'Count PC',
      name: 'main_game_info_count_pc_title',
      desc: '',
      args: [],
    );
  }

  /// `Consuming energy`
  String get main_game_info_energy_title {
    return Intl.message(
      'Consuming energy',
      name: 'main_game_info_energy_title',
      desc: '',
      args: [],
    );
  }

  /// `Power mining`
  String get main_game_info_power_mining_title {
    return Intl.message(
      'Power mining',
      name: 'main_game_info_power_mining_title',
      desc: '',
      args: [],
    );
  }

  /// `Monthly expenses`
  String get main_game_month_title {
    return Intl.message(
      'Monthly expenses',
      name: 'main_game_month_title',
      desc: '',
      args: [],
    );
  }

  /// `Payment for housing`
  String get main_game_month_flat_title {
    return Intl.message(
      'Payment for housing',
      name: 'main_game_month_flat_title',
      desc: '',
      args: [],
    );
  }

  /// `Electricity payment`
  String get main_game_month_energy_title {
    return Intl.message(
      'Electricity payment',
      name: 'main_game_month_energy_title',
      desc: '',
      args: [],
    );
  }

  /// `Statistic`
  String get main_game_stat_title {
    return Intl.message(
      'Statistic',
      name: 'main_game_stat_title',
      desc: '',
      args: [],
    );
  }

  /// `Spend all time`
  String get main_game_stat_spend_all_title {
    return Intl.message(
      'Spend all time',
      name: 'main_game_stat_spend_all_title',
      desc: '',
      args: [],
    );
  }

  /// `Spend on flats`
  String get main_game_stat_spend_flat_title {
    return Intl.message(
      'Spend on flats',
      name: 'main_game_stat_spend_flat_title',
      desc: '',
      args: [],
    );
  }

  /// `Spend in pcs`
  String get main_game_stat_spend_pc_title {
    return Intl.message(
      'Spend in pcs',
      name: 'main_game_stat_spend_pc_title',
      desc: '',
      args: [],
    );
  }

  /// `Spend on energy`
  String get main_game_stat_spend_energy_title {
    return Intl.message(
      'Spend on energy',
      name: 'main_game_stat_spend_energy_title',
      desc: '',
      args: [],
    );
  }

  /// `Earn on {symbol}`
  String main_game_stat_earn_on_crypto_title(Object symbol) {
    return Intl.message(
      'Earn on $symbol',
      name: 'main_game_stat_earn_on_crypto_title',
      desc: '',
      args: [symbol],
    );
  }

  /// `Mining {symbol}`
  String main_game_stat_mining_on_crypto_title(Object symbol) {
    return Intl.message(
      'Mining $symbol',
      name: 'main_game_stat_mining_on_crypto_title',
      desc: '',
      args: [symbol],
    );
  }

  /// `Mining pc`
  String get game_market_pc_title {
    return Intl.message(
      'Mining pc',
      name: 'game_market_pc_title',
      desc: '',
      args: [],
    );
  }

  /// `Cost`
  String get game_market_pc_cost_item_title {
    return Intl.message(
      'Cost',
      name: 'game_market_pc_cost_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Selling value`
  String get game_market_pc_cost_sell_item_title {
    return Intl.message(
      'Selling value',
      name: 'game_market_pc_cost_sell_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Power`
  String get game_market_pc_power_item_title {
    return Intl.message(
      'Power',
      name: 'game_market_pc_power_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Energy consume`
  String get game_market_pc_energy_item_title {
    return Intl.message(
      'Energy consume',
      name: 'game_market_pc_energy_item_title',
      desc: '',
      args: [],
    );
  }

  /// `You have {value} el`
  String game_market_pc_you_have_item_title(Object value) {
    return Intl.message(
      'You have $value el',
      name: 'game_market_pc_you_have_item_title',
      desc: '',
      args: [value],
    );
  }

  /// `Buy`
  String get game_market_pc_buy_item_title {
    return Intl.message(
      'Buy',
      name: 'game_market_pc_buy_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Sell`
  String get game_market_pc_sell_item_title {
    return Intl.message(
      'Sell',
      name: 'game_market_pc_sell_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Flat`
  String get game_market_flat_title {
    return Intl.message(
      'Flat',
      name: 'game_market_flat_title',
      desc: '',
      args: [],
    );
  }

  /// `Cost`
  String get game_market_flat_cost_item_title {
    return Intl.message(
      'Cost',
      name: 'game_market_flat_cost_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Fee`
  String get game_market_flat_month_item_title {
    return Intl.message(
      'Monthly Fee',
      name: 'game_market_flat_month_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Count PC`
  String get game_market_flat_count_pc_item_title {
    return Intl.message(
      'Count PC',
      name: 'game_market_flat_count_pc_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Own`
  String get game_market_flat_own_item_title {
    return Intl.message(
      'Own',
      name: 'game_market_flat_own_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get game_market_flat_change_item_title {
    return Intl.message(
      'Change',
      name: 'game_market_flat_change_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get game_market_flat_buy_item_title {
    return Intl.message(
      'Buy',
      name: 'game_market_flat_buy_item_title',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get game_market_flat_status_active_title {
    return Intl.message(
      'Active',
      name: 'game_market_flat_status_active_title',
      desc: '',
      args: [],
    );
  }

  /// `Crypto`
  String get game_crypto_title {
    return Intl.message(
      'Crypto',
      name: 'game_crypto_title',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get game_crypto_cost_header_title {
    return Intl.message(
      'Balance',
      name: 'game_crypto_cost_header_title',
      desc: '',
      args: [],
    );
  }

  /// `Click on cryptocurrency to sell`
  String get game_crypto_helper_title {
    return Intl.message(
      'Click on cryptocurrency to sell',
      name: 'game_crypto_helper_title',
      desc: '',
      args: [],
    );
  }

  /// `Mining`
  String get game_mining_title {
    return Intl.message(
      'Mining',
      name: 'game_mining_title',
      desc: '',
      args: [],
    );
  }

  /// `Now price`
  String get game_mining_now_price_title {
    return Intl.message(
      'Now price',
      name: 'game_mining_now_price_title',
      desc: '',
      args: [],
    );
  }

  /// `Week price`
  String get game_mining_week_price_title {
    return Intl.message(
      'Week price',
      name: 'game_mining_week_price_title',
      desc: '',
      args: [],
    );
  }

  /// `Month price`
  String get game_mining_month_price_title {
    return Intl.message(
      'Month price',
      name: 'game_mining_month_price_title',
      desc: '',
      args: [],
    );
  }

  /// `Year price`
  String get game_mining_year_price_title {
    return Intl.message(
      'Year price',
      name: 'game_mining_year_price_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose PC`
  String get game_mining_set_pc_title {
    return Intl.message(
      'Choose PC',
      name: 'game_mining_set_pc_title',
      desc: '',
      args: [],
    );
  }

  /// `Mining {symbol}`
  String game_mining_module_title(Object symbol) {
    return Intl.message(
      'Mining $symbol',
      name: 'game_mining_module_title',
      desc: '',
      args: [symbol],
    );
  }

  /// `Your pc`
  String get game_mining_module_pc_title {
    return Intl.message(
      'Your pc',
      name: 'game_mining_module_pc_title',
      desc: '',
      args: [],
    );
  }

  /// `Power`
  String get game_mining_module_pc_power_title {
    return Intl.message(
      'Power',
      name: 'game_mining_module_pc_power_title',
      desc: '',
      args: [],
    );
  }

  /// `Mining`
  String get game_mining_module_pc_mining_title {
    return Intl.message(
      'Mining',
      name: 'game_mining_module_pc_mining_title',
      desc: '',
      args: [],
    );
  }

  /// `Nothing`
  String get game_mining_module_pc_mining_empty_title {
    return Intl.message(
      'Nothing',
      name: 'game_mining_module_pc_mining_empty_title',
      desc: '',
      args: [],
    );
  }

  /// `Current cost`
  String get game_crypto_market_cost_title {
    return Intl.message(
      'Current cost',
      name: 'game_crypto_market_cost_title',
      desc: '',
      args: [],
    );
  }

  /// `Market Sell`
  String get game_crypto_market_fast_sell_title {
    return Intl.message(
      'Market Sell',
      name: 'game_crypto_market_fast_sell_title',
      desc: '',
      args: [],
    );
  }

  /// `Market Buy`
  String get game_crypto_market_fast_buy_title {
    return Intl.message(
      'Market Buy',
      name: 'game_crypto_market_fast_buy_title',
      desc: '',
      args: [],
    );
  }

  /// `Quantity for sale`
  String get game_crypto_market_count_sell_input_title {
    return Intl.message(
      'Quantity for sale',
      name: 'game_crypto_market_count_sell_input_title',
      desc: '',
      args: [],
    );
  }

  /// `Purchase quantity`
  String get game_crypto_market_count_buy_input_title {
    return Intl.message(
      'Purchase quantity',
      name: 'game_crypto_market_count_buy_input_title',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get game_crypto_market_balance_title {
    return Intl.message(
      'Balance',
      name: 'game_crypto_market_balance_title',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu_title {
    return Intl.message(
      'Menu',
      name: 'menu_title',
      desc: '',
      args: [],
    );
  }

  /// `Crypto IDLE`
  String get menu_game_title {
    return Intl.message(
      'Crypto IDLE',
      name: 'menu_game_title',
      desc: '',
      args: [],
    );
  }

  /// `Start company`
  String get menu_company_button_title {
    return Intl.message(
      'Start company',
      name: 'menu_company_button_title',
      desc: '',
      args: [],
    );
  }

  /// `Start free play`
  String get menu_free_button_title {
    return Intl.message(
      'Start free play',
      name: 'menu_free_button_title',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get menu_settings_button_title {
    return Intl.message(
      'Settings',
      name: 'menu_settings_button_title',
      desc: '',
      args: [],
    );
  }

  /// `About the author`
  String get menu_about_button_title {
    return Intl.message(
      'About the author',
      name: 'menu_about_button_title',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get menu_settings_title {
    return Intl.message(
      'Settings',
      name: 'menu_settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Change to language RU`
  String get menu_settings_swap_ru_button_title {
    return Intl.message(
      'Change to language RU',
      name: 'menu_settings_swap_ru_button_title',
      desc: '',
      args: [],
    );
  }

  /// `Change to language EN`
  String get menu_settings_swap_en_button_title {
    return Intl.message(
      'Change to language EN',
      name: 'menu_settings_swap_en_button_title',
      desc: '',
      args: [],
    );
  }

  /// `About the author`
  String get manu_about_title {
    return Intl.message(
      'About the author',
      name: 'manu_about_title',
      desc: '',
      args: [],
    );
  }

  /// `The author of the application is Griva Konstantin.`
  String get manu_about_by_title {
    return Intl.message(
      'The author of the application is Griva Konstantin.',
      name: 'manu_about_by_title',
      desc: '',
      args: [],
    );
  }

  /// `The application is created for flutter.`
  String get manu_about_dev_title {
    return Intl.message(
      'The application is created for flutter.',
      name: 'manu_about_dev_title',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get game_app_bar_info_balance_title {
    return Intl.message(
      'Balance',
      name: 'game_app_bar_info_balance_title',
      desc: '',
      args: [],
    );
  }

  /// `Count pcs`
  String get game_app_bar_info_count_pc_title {
    return Intl.message(
      'Count pcs',
      name: 'game_app_bar_info_count_pc_title',
      desc: '',
      args: [],
    );
  }

  /// `{value}$`
  String text_with_dollar(Object value) {
    return Intl.message(
      '$value\$',
      name: 'text_with_dollar',
      desc: '',
      args: [value],
    );
  }

  /// `{value} V/h`
  String text_with_energy(Object value) {
    return Intl.message(
      '$value V/h',
      name: 'text_with_energy',
      desc: '',
      args: [value],
    );
  }

  /// `{value} U/dex`
  String text_with_power_mining(Object value) {
    return Intl.message(
      '$value U/dex',
      name: 'text_with_power_mining',
      desc: '',
      args: [value],
    );
  }

  /// `{value1}/{value2}`
  String text_with_slash(Object value1, Object value2) {
    return Intl.message(
      '$value1/$value2',
      name: 'text_with_slash',
      desc: '',
      args: [value1, value2],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
