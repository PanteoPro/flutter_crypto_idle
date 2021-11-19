import 'package:flutter/material.dart';

AppBar kGameAppBar(BuildContext context) => AppBar(
      titleTextStyle: Theme.of(context).textTheme.bodyText1,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Баланс: 120\$'),
          Text('Количество установок: 5/10'),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('13.05.2015', style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ),
      ],
    );
