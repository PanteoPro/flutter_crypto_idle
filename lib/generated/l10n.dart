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

  /// `Month prices`
  String get main_game_month_title {
    return Intl.message(
      'Month prices',
      name: 'main_game_month_title',
      desc: '',
      args: [],
    );
  }

  /// `Cost flat`
  String get main_game_month_flat_title {
    return Intl.message(
      'Cost flat',
      name: 'main_game_month_flat_title',
      desc: '',
      args: [],
    );
  }

  /// `Cost energy`
  String get main_game_month_energy_title {
    return Intl.message(
      'Cost energy',
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

  /// `Spend on flat`
  String get main_game_stat_spend_flat_title {
    return Intl.message(
      'Spend on flat',
      name: 'main_game_stat_spend_flat_title',
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
