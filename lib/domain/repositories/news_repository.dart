import 'dart:math';

import 'package:crypto_idle/initial_data.dart';

enum NewsType { positive, neutral, negative }

extension NewsTypeExt on NewsType {
  static NewsType getRandom() {
    var value = Random().nextInt(NewsType.values.length);
    return NewsType.values[value];
  }
}

class NewsRepository {
  static const int _minWaitDayDelay = 5;
  static const int _maxWaitDayDelay = 30;

  static final List<String> _countryNames = [
    'Нурляндия',
    'Гемец',
    'Шальмена',
    'Голанды',
    'Дуркоместан',
    'Пегруеваниа',
    'Зебрад',
    'Друп',
    'Схуорус',
    'Труниа',
    'Нускиулес',
    'Фриосе',
    'Скиудал',
  ];

  static final List<String> _peopleNames = [
    'Кирилл Иванников',
    'Генадий Шмутин ',
    'Иклон Немаск',
    'Грет Природный',
    'Тим Телефонный',
    'Виталик Бутерброд',
    'Карл Андрес',
    'Шпинона Мухоморовична',
    'Носок Потеряшка',
    'Дак Томпон',
    'Ксеномирон',
    'Витя Ной',
    'Теодор Грузный',
    'Доктрин Шмитов',
  ];

  static final List<String> _companyNames = [
    'Finalloy Quarries',
    'Dba Promotions',
    'Rw Auto Repair',
    'Ma Tourniche',
    'Skyprint',
    'Hotel Grove Chelsea',
    'Loops Building',
    'Local No Frills',
    'Autobazaarcom',
    'Tpc Solutions',
  ];

  static final Map<String, String> _tokenNames = InitialDataNames.namesCrypto;

  DateTime? lastGenerated;
  int? countWaitDays;

  // Get new if dateNow after lastGeneratedDate + waitDays
  String? getNews(DateTime dateNow) {
    final dayBefore = dateNow.add(const Duration(days: -1));
    if (dateNow.isAfter(lastGenerated?.add(Duration(days: countWaitDays ?? 0)) ?? dayBefore)) {
      // countWaitDays = _minWaitDayDelay + Random().nextInt(_maxWaitDayDelay - _minWaitDayDelay);
      countWaitDays = 0;
      lastGenerated = dateNow;
      return _generateNews();
    } else {
      // no news
    }
  }

  String _replaceDataInTemplate(String template) {
    final isHaveCountry = template.contains('[Страна]');
    final isHaveSymbol = template.contains('[Символ]');
    final isHavePerson = template.contains('[Известная личность]');
    final isHaveCrypto = template.contains('[Крипта]');
    final isHaveCompany = template.contains('[Компания]');

    String? symbol;
    String result = template;

    if (isHaveCountry) {
      _countryNames.shuffle();
      final country = _countryNames.first;
      result = result.replaceFirst('[Страна]', country);
    }
    if (isHaveSymbol) {
      final symbols = _tokenNames.keys.toList();
      symbols.shuffle();
      symbol = symbols.first;
      result = result.replaceFirst('[Символ]', symbol);
    }
    if (isHaveCrypto) {
      if (symbol == null) {
        final symbols = _tokenNames.keys.toList();
        symbols.shuffle();
        symbol = symbols.first;
      }
      final cryptoName = _tokenNames[symbol] ?? '';
      result = result.replaceFirst('[Крипта]', cryptoName);
    }
    if (isHavePerson) {
      _peopleNames.shuffle();
      final people = _peopleNames.first;
      result = result.replaceFirst('[Известная личность]', people);
    }
    if (isHaveCompany) {
      _companyNames.shuffle();
      final company = _companyNames.first;
      result = result.replaceFirst('[Компания]', company);
    }
    return result;
  }

  String _generateNews() {
    final positive = [
      'Департамент финансов страны [Страна] закупил [Символ].',
      'Президент [Страна] ретвитнул обновление [Символ].',
      '[Компания] начала принимать [Символ].',
    ];
    final neutral = [
      '[Известная личность] закупил [Символ].',
      '[Известная личность] продал [Символ].',
      '[Известная личность] обвинил [Крипта] в мошеничестве.',
    ];
    final negative = [
      'Страна [Страна] запретила использование криптовалют на своей территории',
      'Создатель криптовалюты [Крипта] [Символ] обрушил курс.',
      'Криптовалюта [Крипта] [Символ] оказалась скамом.',
    ];
    positive.shuffle();
    neutral.shuffle();
    negative.shuffle();
    final newsType = NewsTypeExt.getRandom();
    String template = '';
    switch (newsType) {
      case NewsType.positive:
        template = positive.first;
        break;
      case NewsType.neutral:
        template = neutral.first;
        break;
      case NewsType.negative:
        template = negative.first;
        break;
    }
    return _replaceDataInTemplate(template);
  }
}
