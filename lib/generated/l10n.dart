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

  /// `CRYPTO IDLE`
  String get menu_app_bar {
    return Intl.message(
      'CRYPTO IDLE',
      name: 'menu_app_bar',
      desc: '',
      args: [],
    );
  }

  /// `PLAY`
  String get menu_button_play {
    return Intl.message(
      'PLAY',
      name: 'menu_button_play',
      desc: '',
      args: [],
    );
  }

  /// `SETTINGS`
  String get menu_button_settings {
    return Intl.message(
      'SETTINGS',
      name: 'menu_button_settings',
      desc: '',
      args: [],
    );
  }

  /// `AUTHORS`
  String get menu_button_authors {
    return Intl.message(
      'AUTHORS',
      name: 'menu_button_authors',
      desc: '',
      args: [],
    );
  }

  /// `BACK`
  String get menu_button_back {
    return Intl.message(
      'BACK',
      name: 'menu_button_back',
      desc: '',
      args: [],
    );
  }

  /// `NEW GAME`
  String get menu_button_new_game {
    return Intl.message(
      'NEW GAME',
      name: 'menu_button_new_game',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE`
  String get menu_button_continue_game {
    return Intl.message(
      'CONTINUE',
      name: 'menu_button_continue_game',
      desc: '',
      args: [],
    );
  }

  /// `CASH`
  String get game_global_app_bar_cash {
    return Intl.message(
      'CASH',
      name: 'game_global_app_bar_cash',
      desc: '',
      args: [],
    );
  }

  /// `Cryptocurrency`
  String get game_global_app_bar_crypto {
    return Intl.message(
      'Cryptocurrency',
      name: 'game_global_app_bar_crypto',
      desc: '',
      args: [],
    );
  }

  /// `Place`
  String get game_global_footer_place {
    return Intl.message(
      'Place',
      name: 'game_global_footer_place',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get game_global_footer_level {
    return Intl.message(
      'Level',
      name: 'game_global_footer_level',
      desc: '',
      args: [],
    );
  }

  /// `Costs`
  String get game_global_footer_consume {
    return Intl.message(
      'Costs',
      name: 'game_global_footer_consume',
      desc: '',
      args: [],
    );
  }

  /// `Power`
  String get game_global_footer_power {
    return Intl.message(
      'Power',
      name: 'game_global_footer_power',
      desc: '',
      args: [],
    );
  }

  /// `Daily earnings`
  String get game_global_footer_income {
    return Intl.message(
      'Daily earnings',
      name: 'game_global_footer_income',
      desc: '',
      args: [],
    );
  }

  /// `Place`
  String get game_global_footer_consume_flat {
    return Intl.message(
      'Place',
      name: 'game_global_footer_consume_flat',
      desc: '',
      args: [],
    );
  }

  /// `Electricity`
  String get game_global_footer_consume_energy {
    return Intl.message(
      'Electricity',
      name: 'game_global_footer_consume_energy',
      desc: '',
      args: [],
    );
  }

  /// `YOU LOST`
  String get game_global_modal_game_over_title {
    return Intl.message(
      'YOU LOST',
      name: 'game_global_modal_game_over_title',
      desc: '',
      args: [],
    );
  }

  /// `To the main menu`
  String get game_global_modal_game_over_return {
    return Intl.message(
      'To the main menu',
      name: 'game_global_modal_game_over_return',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get game_global_modal_game_over_statistic {
    return Intl.message(
      'Statistics',
      name: 'game_global_modal_game_over_statistic',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get game_main_news {
    return Intl.message(
      'News',
      name: 'game_main_news',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade`
  String get game_main_upgrade_title {
    return Intl.message(
      'Upgrade',
      name: 'game_main_upgrade_title',
      desc: '',
      args: [],
    );
  }

  /// `LVL`
  String get game_main_upgrade_level {
    return Intl.message(
      'LVL',
      name: 'game_main_upgrade_level',
      desc: '',
      args: [],
    );
  }

  /// `Money per click`
  String get game_main_upgrade_info_title {
    return Intl.message(
      'Money per click',
      name: 'game_main_upgrade_info_title',
      desc: '',
      args: [],
    );
  }

  /// `Min`
  String get game_main_upgrade_info_min {
    return Intl.message(
      'Min',
      name: 'game_main_upgrade_info_min',
      desc: '',
      args: [],
    );
  }

  /// `Max`
  String get game_main_upgrade_info_max {
    return Intl.message(
      'Max',
      name: 'game_main_upgrade_info_max',
      desc: '',
      args: [],
    );
  }

  /// `Crit`
  String get game_main_upgrade_info_critical {
    return Intl.message(
      'Crit',
      name: 'game_main_upgrade_info_critical',
      desc: '',
      args: [],
    );
  }

  /// `Crit`
  String get game_main_upgrade_info_critical_probability {
    return Intl.message(
      'Crit',
      name: 'game_main_upgrade_info_critical_probability',
      desc: '',
      args: [],
    );
  }

  /// `Buy computers`
  String get game_main_actions_buy_pc {
    return Intl.message(
      'Buy computers',
      name: 'game_main_actions_buy_pc',
      desc: '',
      args: [],
    );
  }

  /// `Buy a place`
  String get game_main_actions_buy_flat {
    return Intl.message(
      'Buy a place',
      name: 'game_main_actions_buy_flat',
      desc: '',
      args: [],
    );
  }

  /// `Cryptocurrency`
  String get game_main_actions_crypto_wallet {
    return Intl.message(
      'Cryptocurrency',
      name: 'game_main_actions_crypto_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get game_main_actions_statistics {
    return Intl.message(
      'Statistics',
      name: 'game_main_actions_statistics',
      desc: '',
      args: [],
    );
  }

  /// `ASSIGN`
  String get game_main_pcs_assign {
    return Intl.message(
      'ASSIGN',
      name: 'game_main_pcs_assign',
      desc: '',
      args: [],
    );
  }

  /// `Mined`
  String get game_main_pcs_mining {
    return Intl.message(
      'Mined',
      name: 'game_main_pcs_mining',
      desc: '',
      args: [],
    );
  }

  /// `Choose a cryptocurrency`
  String get game_main_modal_tokens_title {
    return Intl.message(
      'Choose a cryptocurrency',
      name: 'game_main_modal_tokens_title',
      desc: '',
      args: [],
    );
  }

  /// `To install - {value}`
  String game_main_modal_tokens_sub_title(Object value) {
    return Intl.message(
      'To install - $value',
      name: 'game_main_modal_tokens_sub_title',
      desc: '',
      args: [value],
    );
  }

  /// `Cancel`
  String get game_main_modal_tokens_exit {
    return Intl.message(
      'Cancel',
      name: 'game_main_modal_tokens_exit',
      desc: '',
      args: [],
    );
  }

  /// `Current price`
  String get game_main_modal_tokens_info_current_cost {
    return Intl.message(
      'Current price',
      name: 'game_main_modal_tokens_info_current_cost',
      desc: '',
      args: [],
    );
  }

  /// `Price a month ago`
  String get game_main_modal_tokens_info_month_cost {
    return Intl.message(
      'Price a month ago',
      name: 'game_main_modal_tokens_info_month_cost',
      desc: '',
      args: [],
    );
  }

  /// `ACTIVELY`
  String get game_main_modal_tokens_button_active {
    return Intl.message(
      'ACTIVELY',
      name: 'game_main_modal_tokens_button_active',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get game_main_modal_tokens_button_select {
    return Intl.message(
      'Select',
      name: 'game_main_modal_tokens_button_select',
      desc: '',
      args: [],
    );
  }

  /// `SCAM`
  String get game_main_modal_tokens_button_scam {
    return Intl.message(
      'SCAM',
      name: 'game_main_modal_tokens_button_scam',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to go to the menu?`
  String get game_main_modal_exit_title {
    return Intl.message(
      'Are you sure you want to go to the menu?',
      name: 'game_main_modal_exit_title',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get game_main_modal_exit_yes {
    return Intl.message(
      'Yes',
      name: 'game_main_modal_exit_yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get game_main_modal_exit_no {
    return Intl.message(
      'No',
      name: 'game_main_modal_exit_no',
      desc: '',
      args: [],
    );
  }

  /// `Buy computers`
  String get game_market_pc_title {
    return Intl.message(
      'Buy computers',
      name: 'game_market_pc_title',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get game_market_pc_info_cost {
    return Intl.message(
      'Price',
      name: 'game_market_pc_info_cost',
      desc: '',
      args: [],
    );
  }

  /// `Selling price`
  String get game_market_pc_info_cost_sell {
    return Intl.message(
      'Selling price',
      name: 'game_market_pc_info_cost_sell',
      desc: '',
      args: [],
    );
  }

  /// `Power`
  String get game_market_pc_info_power {
    return Intl.message(
      'Power',
      name: 'game_market_pc_info_power',
      desc: '',
      args: [],
    );
  }

  /// `Electricity`
  String get game_market_pc_info_energy {
    return Intl.message(
      'Electricity',
      name: 'game_market_pc_info_energy',
      desc: '',
      args: [],
    );
  }

  /// `You have: {value} pieces`
  String game_market_pc_info_count(Object value) {
    return Intl.message(
      'You have: $value pieces',
      name: 'game_market_pc_info_count',
      desc: '',
      args: [value],
    );
  }

  /// `Level {value}`
  String game_market_pc_info_level(Object value) {
    return Intl.message(
      'Level $value',
      name: 'game_market_pc_info_level',
      desc: '',
      args: [value],
    );
  }

  /// `To purchase you need `
  String get game_market_pc_info_no_level_1 {
    return Intl.message(
      'To purchase you need ',
      name: 'game_market_pc_info_no_level_1',
      desc: '',
      args: [],
    );
  }

  /// `{value} level `
  String game_market_pc_info_no_level_2(Object value) {
    return Intl.message(
      '$value level ',
      name: 'game_market_pc_info_no_level_2',
      desc: '',
      args: [value],
    );
  }

  /// `place`
  String get game_market_pc_info_no_level_3 {
    return Intl.message(
      'place',
      name: 'game_market_pc_info_no_level_3',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get game_market_pc_button_buy {
    return Intl.message(
      'Buy',
      name: 'game_market_pc_button_buy',
      desc: '',
      args: [],
    );
  }

  /// `Sell`
  String get game_market_pc_button_sell {
    return Intl.message(
      'Sell',
      name: 'game_market_pc_button_sell',
      desc: '',
      args: [],
    );
  }

  /// `Buy a place`
  String get game_market_flat_title {
    return Intl.message(
      'Buy a place',
      name: 'game_market_flat_title',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get game_market_flat_info_cost {
    return Intl.message(
      'Price',
      name: 'game_market_flat_info_cost',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Fee`
  String get game_market_flat_info_month_cost {
    return Intl.message(
      'Monthly Fee',
      name: 'game_market_flat_info_month_cost',
      desc: '',
      args: [],
    );
  }

  /// `Number of computers`
  String get game_market_flat_info_count_pc {
    return Intl.message(
      'Number of computers',
      name: 'game_market_flat_info_count_pc',
      desc: '',
      args: [],
    );
  }

  /// `LVL`
  String get game_market_flat_info_level {
    return Intl.message(
      'LVL',
      name: 'game_market_flat_info_level',
      desc: '',
      args: [],
    );
  }

  /// `ACQUIRED`
  String get game_market_flat_button_have {
    return Intl.message(
      'ACQUIRED',
      name: 'game_market_flat_button_have',
      desc: '',
      args: [],
    );
  }

  /// `BUY`
  String get game_market_flat_button_buy {
    return Intl.message(
      'BUY',
      name: 'game_market_flat_button_buy',
      desc: '',
      args: [],
    );
  }

  /// `ACTIVELY`
  String get game_market_flat_status_active_title {
    return Intl.message(
      'ACTIVELY',
      name: 'game_market_flat_status_active_title',
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

  /// `{value}$/month`
  String text_with_dollar_month(Object value) {
    return Intl.message(
      '$value\$/month',
      name: 'text_with_dollar_month',
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
