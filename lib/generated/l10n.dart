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

  /// `Statistics`
  String get main_game_stat_title {
    return Intl.message(
      'Statistics',
      name: 'main_game_stat_title',
      desc: '',
      args: [],
    );
  }

  /// `Costs`
  String get main_game_stat_consume {
    return Intl.message(
      'Costs',
      name: 'main_game_stat_consume',
      desc: '',
      args: [],
    );
  }

  /// `Spent on PC purchases`
  String get main_game_stat_consume_buyPC {
    return Intl.message(
      'Spent on PC purchases',
      name: 'main_game_stat_consume_buyPC',
      desc: '',
      args: [],
    );
  }

  /// `Spent on home purchases`
  String get main_game_stat_consume_buyFlat {
    return Intl.message(
      'Spent on home purchases',
      name: 'main_game_stat_consume_buyFlat',
      desc: '',
      args: [],
    );
  }

  /// `Spent on electricity`
  String get main_game_stat_consume_energy {
    return Intl.message(
      'Spent on electricity',
      name: 'main_game_stat_consume_energy',
      desc: '',
      args: [],
    );
  }

  /// `Spent on housing`
  String get main_game_stat_consume_flat {
    return Intl.message(
      'Spent on housing',
      name: 'main_game_stat_consume_flat',
      desc: '',
      args: [],
    );
  }

  /// `Transactions`
  String get main_game_stat_deals {
    return Intl.message(
      'Transactions',
      name: 'main_game_stat_deals',
      desc: '',
      args: [],
    );
  }

  /// `Sell ​​deals`
  String get main_game_stat_deals_count_sell {
    return Intl.message(
      'Sell ​​deals',
      name: 'main_game_stat_deals_count_sell',
      desc: '',
      args: [],
    );
  }

  /// `Buy deals completed`
  String get main_game_stat_deals_count_buy {
    return Intl.message(
      'Buy deals completed',
      name: 'main_game_stat_deals_count_buy',
      desc: '',
      args: [],
    );
  }

  /// `Volume of sales`
  String get main_game_stat_deals_volume_sell {
    return Intl.message(
      'Volume of sales',
      name: 'main_game_stat_deals_volume_sell',
      desc: '',
      args: [],
    );
  }

  /// `Purchase volume`
  String get main_game_stat_deals_volume_buy {
    return Intl.message(
      'Purchase volume',
      name: 'main_game_stat_deals_volume_buy',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get main_game_stat_other {
    return Intl.message(
      'Other',
      name: 'main_game_stat_other',
      desc: '',
      args: [],
    );
  }

  /// `Number of clicks on the computer`
  String get main_game_stat_other_clicker_count {
    return Intl.message(
      'Number of clicks on the computer',
      name: 'main_game_stat_other_clicker_count',
      desc: '',
      args: [],
    );
  }

  /// `Earned on clicks`
  String get main_game_stat_other_clicker_earn {
    return Intl.message(
      'Earned on clicks',
      name: 'main_game_stat_other_clicker_earn',
      desc: '',
      args: [],
    );
  }

  /// `Number of crits`
  String get main_game_stat_other_clicker_crit_count {
    return Intl.message(
      'Number of crits',
      name: 'main_game_stat_other_clicker_crit_count',
      desc: '',
      args: [],
    );
  }

  /// `Number of days passed`
  String get main_game_stat_other_days {
    return Intl.message(
      'Number of days passed',
      name: 'main_game_stat_other_days',
      desc: '',
      args: [],
    );
  }

  /// `Cryptocurrencies`
  String get main_game_stat_crypto {
    return Intl.message(
      'Cryptocurrencies',
      name: 'main_game_stat_crypto',
      desc: '',
      args: [],
    );
  }

  /// `Mined {symbol}`
  String main_game_stat_crypto_mining(Object symbol) {
    return Intl.message(
      'Mined $symbol',
      name: 'main_game_stat_crypto_mining',
      desc: '',
      args: [symbol],
    );
  }

  /// `Sold {symbol} for the amount`
  String main_game_stat_crypto_earn(Object symbol) {
    return Intl.message(
      'Sold $symbol for the amount',
      name: 'main_game_stat_crypto_earn',
      desc: '',
      args: [symbol],
    );
  }

  /// `Sum`
  String get main_game_stat_sum {
    return Intl.message(
      'Sum',
      name: 'main_game_stat_sum',
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

  /// `Music`
  String get menu_settings_music {
    return Intl.message(
      'Music',
      name: 'menu_settings_music',
      desc: '',
      args: [],
    );
  }

  /// `Sound`
  String get menu_settings_sound {
    return Intl.message(
      'Sound',
      name: 'menu_settings_sound',
      desc: '',
      args: [],
    );
  }

  /// `LANGUAGE`
  String get menu_settings_language {
    return Intl.message(
      'LANGUAGE',
      name: 'menu_settings_language',
      desc: '',
      args: [],
    );
  }

  /// `CRYPTO TYCOON`
  String get menu_app_bar {
    return Intl.message(
      'CRYPTO TYCOON',
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

  /// `Cash`
  String get game_global_app_bar_cash {
    return Intl.message(
      'Cash',
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

  /// `Level place`
  String get game_global_footer_level {
    return Intl.message(
      'Level place',
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

  /// `Upgrade PC`
  String get game_main_modal_upgrade_title {
    return Intl.message(
      'Upgrade PC',
      name: 'game_main_modal_upgrade_title',
      desc: '',
      args: [],
    );
  }

  /// `Minimum:`
  String get game_main_modal_upgrade_min {
    return Intl.message(
      'Minimum:',
      name: 'game_main_modal_upgrade_min',
      desc: '',
      args: [],
    );
  }

  /// `Maximum:`
  String get game_main_modal_upgrade_max {
    return Intl.message(
      'Maximum:',
      name: 'game_main_modal_upgrade_max',
      desc: '',
      args: [],
    );
  }

  /// `Critical:`
  String get game_main_modal_upgrade_crit {
    return Intl.message(
      'Critical:',
      name: 'game_main_modal_upgrade_crit',
      desc: '',
      args: [],
    );
  }

  /// `Critical %:`
  String get game_main_modal_upgrade_probability_crit {
    return Intl.message(
      'Critical %:',
      name: 'game_main_modal_upgrade_probability_crit',
      desc: '',
      args: [],
    );
  }

  /// `Level Up`
  String get game_main_modal_upgrade_button {
    return Intl.message(
      'Level Up',
      name: 'game_main_modal_upgrade_button',
      desc: '',
      args: [],
    );
  }

  /// `Cost`
  String get game_main_modal_upgrade_cost {
    return Intl.message(
      'Cost',
      name: 'game_main_modal_upgrade_cost',
      desc: '',
      args: [],
    );
  }

  /// `Current Level`
  String get game_main_modal_upgrade_level {
    return Intl.message(
      'Current Level',
      name: 'game_main_modal_upgrade_level',
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

  /// `electr`
  String get game_market_pc_info_cost_sell_minus {
    return Intl.message(
      'electr',
      name: 'game_market_pc_info_cost_sell_minus',
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

  /// `Insufficient level of premises for purchase`
  String get game_market_pc_lock_title {
    return Intl.message(
      'Insufficient level of premises for purchase',
      name: 'game_market_pc_lock_title',
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

  /// `Not enough cash to buy`
  String get game_market_flat_lock_title {
    return Intl.message(
      'Not enough cash to buy',
      name: 'game_market_flat_lock_title',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get game_market_crypto_available {
    return Intl.message(
      'Available',
      name: 'game_market_crypto_available',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get game_market_crypto_buy_title {
    return Intl.message(
      'Purchase',
      name: 'game_market_crypto_buy_title',
      desc: '',
      args: [],
    );
  }

  /// `BUY`
  String get game_market_crypto_buy_button {
    return Intl.message(
      'BUY',
      name: 'game_market_crypto_buy_button',
      desc: '',
      args: [],
    );
  }

  /// `Sale`
  String get game_market_crypto_sell_title {
    return Intl.message(
      'Sale',
      name: 'game_market_crypto_sell_title',
      desc: '',
      args: [],
    );
  }

  /// `SELL`
  String get game_market_crypto_sell_button {
    return Intl.message(
      'SELL',
      name: 'game_market_crypto_sell_button',
      desc: '',
      args: [],
    );
  }

  /// `Asset allocation`
  String get game_wallet_assets_title {
    return Intl.message(
      'Asset allocation',
      name: 'game_wallet_assets_title',
      desc: '',
      args: [],
    );
  }

  /// `Cryptocurrency wallet`
  String get game_wallet_tokens_title {
    return Intl.message(
      'Cryptocurrency wallet',
      name: 'game_wallet_tokens_title',
      desc: '',
      args: [],
    );
  }

  /// `Hide zero balances`
  String get game_wallet_hide_null {
    return Intl.message(
      'Hide zero balances',
      name: 'game_wallet_hide_null',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get game_settings_title {
    return Intl.message(
      'Settings',
      name: 'game_settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Music`
  String get game_settings_music {
    return Intl.message(
      'Music',
      name: 'game_settings_music',
      desc: '',
      args: [],
    );
  }

  /// `Sound`
  String get game_settings_sound {
    return Intl.message(
      'Sound',
      name: 'game_settings_sound',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get game_settings_close {
    return Intl.message(
      'Close',
      name: 'game_settings_close',
      desc: '',
      args: [],
    );
  }

  /// `Idea author/code`
  String get game_authors_panteo {
    return Intl.message(
      'Idea author/code',
      name: 'game_authors_panteo',
      desc: '',
      args: [],
    );
  }

  /// `Design by`
  String get game_authors_codex {
    return Intl.message(
      'Design by',
      name: 'game_authors_codex',
      desc: '',
      args: [],
    );
  }

  /// `{value} $`
  String text_with_dollar(Object value) {
    return Intl.message(
      '$value \$',
      name: 'text_with_dollar',
      desc: '',
      args: [value],
    );
  }

  /// `{value} $/month`
  String text_with_dollar_month(Object value) {
    return Intl.message(
      '$value \$/month',
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
