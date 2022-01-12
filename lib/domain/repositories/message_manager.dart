import 'dart:async';

import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:crypto_tycoon/resources/resources.dart';
import 'package:flutter/material.dart';

abstract class MessageTexts {}

class AppMessage {
  AppMessage({
    required this.text,
    required this.textENG,
    required this.color,
    required this.image,
  });
  final Widget text;
  final Widget textENG;
  final Color color;
  final String image;

  static AppMessage sellToken({
    required double volume,
    required String symbol,
    required double lastPrice,
    required double income,
  }) {
    final text = 'Продано $volume $symbol по цене $lastPrice, вы получили $income\$';
    final textENG = 'SOLD $volume $symbol SOLD $lastPrice, you received $income\$';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Продано ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: '$volume $symbol ',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: 'по цене ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${lastPrice.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ', вы получили ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${income.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'SOLD ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: '$volume $symbol ',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: 'by price ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${lastPrice.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ', you received ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${income.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      color: AppColors.black,
      image: AppIconsImages.money,
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
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Куплено ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: '$volume $symbol ',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: 'по цене ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${lastPrice.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ', вы потратили ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${spent.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Purchased ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: '$volume $symbol ',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: 'by price ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${lastPrice.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ', have you spent',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${spent.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      color: AppColors.black,
      image: AppIconsImages.money,
    );
  }

  static AppMessage changeFlat({
    required String flatName,
  }) {
    final text = 'Вы переехали в $flatName';
    final textENG = 'You moved to $flatName';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Вы переехали в ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: flatName,
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'You moved to ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: flatName,
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      color: AppColors.black,
      image: AppIconsImages.car,
    );
  }

  static AppMessage errorNotEnoughLevelFlat({
    required String flatName,
  }) {
    final text = 'Ваши компьютеры выше уровнем, чем в помещении $flatName';
    final textENG = 'Your computers are higher than flat $flatName';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Ваши компьютеры выше уровнем, чем в помещнии ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: flatName,
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Your computers are higher than flat ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: flatName,
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      color: AppColors.red,
      image: AppIconsImages.car,
    );
  }

  static AppMessage errorFlatWithMaxPC() {
    const text = 'Ваше текущее количество установок больше, чем максимальное количество установок в новом жилье';
    const textENG = 'Your current installs are greater than the maximum installs in a new home';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Ваше текущее количество установок больше, чем максимальное количество установок в новом жилье',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Your current installs are greater than the maximum installs in a new home',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      color: AppColors.red,
      image: AppIconsImages.car,
    );
  }

  static AppMessage errorFlatNotBoughtFlat() {
    const text = 'Это жилье не куплено';
    const textENG = 'This house has not been bought';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'то жилье не куплено',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'This house has not been bought',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      color: AppColors.red,
      image: AppIconsImages.car,
    );
  }

  static AppMessage buyFlat({
    required String flatName,
    required double cost,
  }) {
    final text = 'Куплено жилье $flatName по цене $cost\$';
    final textENG = 'Purchased housing $flatName at price $cost\$';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Куплено жилье ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: flatName,
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ' по цене ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${cost.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Purchased housing ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: flatName,
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ' at price ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${cost.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      color: AppColors.black,
      image: AppIconsImages.money,
    );
  }

  static AppMessage errorFlatNotEnoughtMoney() {
    const text = 'Недостаточно денег';
    const textENG = 'Not enough money';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Недостаточно денег',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Not enough money',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      color: AppColors.red,
      image: AppIconsImages.money,
    );
  }

  static AppMessage buyPC({
    required String name,
    required double cost,
  }) {
    final text = 'Вы купили установку - $name за $cost\$';
    final textENG = 'You bought the installation  - $name for $cost\$';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Вы купили установку - ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: name,
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ' за ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${cost.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'You bought the installation  - ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: name,
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ' for ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${cost.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      color: AppColors.black,
      image: AppIconsImages.money,
    );
  }

  static AppMessage errorPCMaxPC() {
    const text = 'У вас максимальное количество установок!';
    const textENG = 'You have the maximum number of installs!';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'У вас максимальное количество установок!',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'You have the maximum number of installs!',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      color: AppColors.red,
      image: AppIconsImages.money,
    );
  }

  static AppMessage errorPCNotEnoughtMoney() {
    const text = 'У вас недостаточно денег!';
    const textENG = "You don't have enough money!";
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'У вас недостаточно денег!',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: "You don't have enough money!",
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      color: AppColors.red,
      image: AppIconsImages.money,
    );
  }

  static AppMessage errorPCNotEnoughtLevel() {
    const text = 'Недостающий уровень жилья';
    const textENG = 'Missing level of housing';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Недостающий уровень жилья',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Missing level of housing',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      color: AppColors.red,
      image: AppIconsImages.money,
    );
  }

  static AppMessage sellPC({
    required String name,
    required double cost,
  }) {
    final text = 'Вы продали установку - $name за $cost\$';
    final textENG = 'You sold the installation - $name for $cost\$';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Вы продали установку - ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: name,
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ' за ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${cost.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'YYou sold the installation  - ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: name,
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ' for ',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
            TextSpan(
              text: '${cost.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
          ],
        ),
      ),
      color: AppColors.black,
      image: AppIconsImages.money,
    );
  }

  static AppMessage errorSellPCNothing() {
    const text = 'Вы не можете продать, то чего у вас нет';
    const textENG = "You Can't Sell What You Don't Have";
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Вы не можете продать, то чего у вас нет',
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: "You Can't Sell What You Don't Have",
          style: AppFonts.body2.copyWith(color: AppColors.white),
        ),
      ),
      color: AppColors.red,
      image: AppIconsImages.money,
    );
  }

  static AppMessage day7() {
    const text =
        'Через 7 дней оплата ежемесячных расходов, у вас должно быть достаточное количество наличных для оплаты.';
    const textENG = 'After 7 days of paying monthly expenses, you must have enough cash to pay.';
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'Через ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: '7 дней ',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: 'оплата ежемесячных расходов, у вас должно быть достаточное количество наличных для оплаты.',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'After ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: '7 days ',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: 'of paying monthly expenses, you must have enough cash to pay.',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
      color: AppColors.black,
      image: AppIconsImages.clock,
    );
  }

  static AppMessage dayNotEnoughtMoney({required double notEnoughtMoney}) {
    final text = 'У вас не хватает денег для месячной оплаты, найдите $notEnoughtMoney\$, или проиграете!';
    final textENG =
        "You don't have enough money to pay for the monthly payment, find $notEnoughtMoney\$ or you will lose!";
    return AppMessage(
      text: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: 'У вас не хватает денег для месячной оплаты, найдите ',
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: '${notEnoughtMoney.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ', или проиграете!',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
      textENG: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: "You don't have enough money to pay for the monthly payment, find ",
          style: AppFonts.body2.copyWith(color: AppColors.white),
          children: [
            TextSpan(
              text: '${notEnoughtMoney.toStringAsFixed(2)} \$',
              style: AppFonts.body2.copyWith(color: AppColors.green),
            ),
            TextSpan(
              text: ', or you will lose!',
              style: AppFonts.body2.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
      color: AppColors.red,
      image: AppIconsImages.clock,
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
