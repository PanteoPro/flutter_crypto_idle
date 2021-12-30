import 'dart:async';

import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract class MessageTexts {}

class AppMessage {
  AppMessage({required this.text, required this.textENG, required this.color});
  final String text;
  final String textENG;
  final Color color;

  static AppMessage sellToken({
    required double volume,
    required String symbol,
    required double lastPrice,
    required double income,
  }) {
    final text = 'Продано $volume $symbol по цене $lastPrice, вы получили $income\$';
    final textENG = 'SOLD $volume $symbol by price $lastPrice, you received $income\$';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsGreen,
    );
  }

  static AppMessage buyToken({
    required double volume,
    required String symbol,
    required double lastPrice,
    required double spent,
  }) {
    final text = 'Куплено $volume $symbol по цене $lastPrice, вы потратили $spent\$';
    final textENG = 'Purchased $volume $symbol by price $lastPrice, have you spent $spent\$';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsGreen,
    );
  }

  static AppMessage changeFlat({
    required String flatName,
  }) {
    final text = 'Вы переехали в $flatName';
    final textENG = 'You moved to $flatName';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsBlue,
    );
  }

  static AppMessage errorNotEnoughLevelFlat({
    required String flatName,
  }) {
    final text = 'Ваши компьютеры выше уровнем, чем в помещнии $flatName';
    final textENG = 'Your computers are higher than indoors $flatName';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsRed,
    );
  }

  static AppMessage errorFlatWithMaxPC() {
    const text = 'Ваше текущее количество установок больше, чем максимальное количество установок в новом жилье';
    const textENG = 'Your current installs are greater than the maximum installs in a new home';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsRed,
    );
  }

  static AppMessage errorFlatNotBoughtFlat() {
    const text = 'Это жилье не куплено';
    const textENG = 'This house has not been bought';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsRed,
    );
  }

  static AppMessage buyFlat({
    required String flatName,
    required double cost,
  }) {
    final text = 'Куплено жилье $flatName по цене $cost\$';
    final textENG = 'TPurchased housing $flatName at price $cost\$';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsGreen,
    );
  }

  static AppMessage errorFlatNotEnoughtMoney() {
    const text = 'Недостаточно денег';
    const textENG = 'Not enough money';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsRed,
    );
  }

  static AppMessage buyPC({
    required String name,
    required double cost,
  }) {
    final text = 'Вы купили установку - $name за $cost\$';
    final textENG = 'You bought the installation  - $name for $cost\$';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsGreen,
    );
  }

  static AppMessage errorPCMaxPC() {
    const text = 'У вас максимальное количество установок!';
    const textENG = 'You have the maximum number of installs!';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsRed,
    );
  }

  static AppMessage errorPCNotEnoughtMoney() {
    const text = 'У вас недостаточно денег!';
    const textENG = "You don't have enough money!";
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsRed,
    );
  }

  static AppMessage errorPCNotEnoughtLevel() {
    const text = 'Недостающий уровень жилья';
    const textENG = 'Missing level of housing';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsRed,
    );
  }

  static AppMessage sellPC({
    required String name,
    required double cost,
  }) {
    final text = 'Вы продали установку - $name за $cost\$';
    final textENG = 'You sold the installation - $name for $cost\$';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsGreen,
    );
  }

  static AppMessage errorSellPCNothing() {
    const text = 'Вы не можете продать, то чего у вас нет';
    const textENG = "You Can't Sell What You Don't Have";
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsRed,
    );
  }

  static AppMessage day7() {
    const text =
        'Через 7 дней оплата ежемесячных расходов, у вас должно быть достаточное количество наличных для оплаты.';
    const textENG = 'After 7 days of paying monthly expenses, you must have enough cash to pay.';
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsBlue,
    );
  }

  static AppMessage dayNotEnoughtMoney({required double notEnoughtMoney}) {
    final text = 'У вас не хватает денег для месячной оплаты, найдите $notEnoughtMoney\$, или проиграете!';
    final textENG =
        "You don't have enough money to pay for the monthly payment, find $notEnoughtMoney\$ or you will lose!";
    return AppMessage(
      text: text,
      textENG: textENG,
      color: AppColors.newsBlue,
    );
  }
}

/// Before using, call the init()
/// For listen change messages listen the stream field
class MessageManager {
  /// Using this method before use MessageManager
  static void init() {
    stream ??= _streamController.stream.asBroadcastStream();
  }

  static final messages = <AppMessage>[];

  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  static void addMessage(AppMessage message) {
    messages.add(message);
    _streamController.add('change messages');
    Future.delayed(const Duration(seconds: 5), () {
      messages.remove(message);
      _streamController.add('change messages');
    });
  }
}
