import 'dart:async';
import 'dart:math';

import 'package:crypto_tycoon/domain/data_providers/news_data_provider.dart';
import 'package:crypto_tycoon/domain/data_providers/price_token_data_provider.dart';
import 'package:crypto_tycoon/domain/data_providers/token_data_provider.dart';
import 'package:crypto_tycoon/domain/entities/news.dart';
import 'package:crypto_tycoon/domain/entities/price_token.dart';
import 'package:crypto_tycoon/domain/entities/token.dart';
import 'package:crypto_tycoon/domain/repositories/music_manager.dart';
import 'package:crypto_tycoon/domain/repositories/my_repository.dart';

class _NewsStruct {
  _NewsStruct({
    required this.template,
    required this.templateENG,
    required this.type,
    required this.isAllCrypto,
    required this.isScamType,
    this.token,
  });

  final String template;
  final String templateENG;
  final NewsType type;
  final Token? token;
  final bool isAllCrypto;
  final bool isScamType;
}

enum NewsType { positive, neutral, negative }

extension NewsTypeExt on NewsType {
  static NewsType getRandom() {
    final value = Random().nextInt(NewsType.values.length);
    return NewsType.values[value];
  }
}

class _NewsRepositoryParams {
  static const int minWaitDayDelay = 1;
  static const int maxWaitDayDelay = 4;

  static final List<String> countryNames = [
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

  static final List<String> countryNamesENG = [
    'Nurlandia',
    'Gemets',
    'Shalmen',
    'Holands',
    'Durkomestan',
    'Pegruevania',
    'Zebrad',
    'Drup',
    'Schuorus',
    'Trunia',
    'Nuscules',
    'Friose',
    'Skiudal',
  ];

  static final List<String> peopleNames = [
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

  static final List<String> peopleNamesENG = [
    'Kirill Ivannikov',
    'Gennady Shmutin',
    'Iklon Nemask',
    'Gret Natural',
    'Tim Telephone',
    'Vitalik Sandwich',
    'Karl Andres',
    'Spinona Mukhomorovichna',
    'Waif Sock',
    'Duck Tompon',
    'Xenomiron',
    'Vitya Noy',
    'Theodore Gruzny',
    'Doctrine of the Shmites',
  ];

  static final List<String> companyNames = [
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
}

enum NewsRepositoryStreamEvents {
  addNews,
}

class NewsRepository extends MyRepository {
  final _newsDataProvider = NewsDataProvider();
  final _tokenDataProvider = TokenDataProvider();
  final _priceDataProvider = PriceTokenDataProvider();

  var _news = <News>[];

  List<News> get news => List.unmodifiable(_news);
  List<News> get newsNotActivate => List.unmodifiable(_news.where((element) => element.isActivate == false));

  List<PriceToken> pricesByTokenId(int tokenId) =>
      _priceDataProvider.loadData().where((element) => element.tokenId == tokenId).toList();
  PriceToken getLatestPriceByTokenId(int tokenId) => pricesByTokenId(tokenId).last;

  static final _streamController = StreamController<dynamic>();
  static Stream<dynamic>? stream;

  DateTime? lastGenerated;
  int? countWaitDays;

  @override
  Future<void> init() async {
    await _newsDataProvider.openBox();
    await _tokenDataProvider.openBox();
    await _priceDataProvider.openBox();
    updateData();
    stream ??= _streamController.stream.asBroadcastStream();
  }

  @override
  void updateData() {
    _news = _newsDataProvider.loadData();
  }

  Future<void> addNews(News news) async {
    await _newsDataProvider.saveData(news);
    _streamController.add(NewsRepositoryStreamEvents.addNews);
  }

  // Get new if dateNow after lastGeneratedDate + waitDays
  void createNews(DateTime dateNow) {
    final dayBefore = dateNow.add(const Duration(days: -1));
    if (dateNow.isAfter(lastGenerated?.add(Duration(days: countWaitDays ?? 0)) ?? dayBefore)) {
      countWaitDays = _NewsRepositoryParams.minWaitDayDelay +
          Random().nextInt(_NewsRepositoryParams.maxWaitDayDelay - _NewsRepositoryParams.minWaitDayDelay);
      lastGenerated = dateNow;
      final news = _generateNews(dateNow);
      if (news.isScamToken) {
        MusicManager.playScamToken();
      } else {
        MusicManager.playNews();
      }
      addNews(news);
    }
  }

  Map<String, dynamic> _replaceDataInTemplate(String template, [bool isEnglish = false]) {
    final isHaveCountry = template.contains('[Страна]');
    final isHaveSymbol = template.contains('[Символ]');
    final isHavePerson = template.contains('[Известная личность]');
    final isHaveCrypto = template.contains('[Крипта]');
    final isHaveCompany = template.contains('[Компания]');

    final tokens = _tokenDataProvider.loadData();
    final latestPrices = tokens.map((e) => getLatestPriceByTokenId(e.id));

    final availableTokens = <Token>[];
    for (final token in tokens) {
      final price = latestPrices.where((element) => element.tokenId == token.id).first;
      if (price.cost > 0) {
        availableTokens.add(token);
      }
    }

    availableTokens.shuffle();
    final token = isHaveSymbol || isHaveCrypto ? availableTokens.first : null;
    String result = template;

    if (isHaveCountry) {
      var countryNames = <String>[];
      if (isEnglish) {
        countryNames = _NewsRepositoryParams.countryNamesENG;
      } else {
        countryNames = _NewsRepositoryParams.countryNames;
      }
      countryNames.shuffle();
      final country = countryNames.first;
      result = result.replaceFirst('[Страна]', country);
    }
    if (isHaveSymbol) {
      result = result.replaceFirst('[Символ]', token!.symbol);
    }
    if (isHaveCrypto) {
      result = result.replaceFirst('[Крипта]', token!.fullName);
    }
    if (isHavePerson) {
      var peopleNames = <String>[];
      if (isEnglish) {
        peopleNames = _NewsRepositoryParams.peopleNamesENG;
      } else {
        peopleNames = _NewsRepositoryParams.peopleNames;
      }
      peopleNames.shuffle();
      final people = peopleNames.first;
      result = result.replaceFirst('[Известная личность]', people);
    }
    if (isHaveCompany) {
      final companyNames = _NewsRepositoryParams.companyNames;
      companyNames.shuffle();
      final company = companyNames.first;
      result = result.replaceFirst('[Компания]', company);
    }
    return {'result': result, 'tokenID': token?.id};
  }

  News _generateNews(DateTime dateNow) {
    final newsTexts = [
      _NewsStruct(
        template: 'Департамент финансов страны [Страна] закупил [Символ].',
        templateENG: 'Country Finance Department [Страна] purchased [Символ]',
        type: NewsType.positive,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: 'Президент [Страна] ретвитнул обновление [Символ].',
        templateENG: 'The [Страна] President retweeted the [Символ] update.',
        type: NewsType.positive,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: '[Компания] начала принимать [Символ].',
        templateENG: '[Компания] began to accept [Символ].',
        type: NewsType.positive,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: '[Известная личность] закупил [Символ].',
        templateENG: '[Известная личность] bought [Символ].',
        type: NewsType.neutral,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: '[Известная личность] продал [Символ].',
        templateENG: '[Известная личность] sold [Символ].',
        type: NewsType.neutral,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: '[Известная личность] обвинил [Крипта] [Символ] в мошеничестве.',
        templateENG: '[Известная личность] accused [Крипта] [Символ] of fraud.',
        type: NewsType.neutral,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: 'Страна [Страна] запретила использование криптовалют на своей территории',
        templateENG: 'Country  [Страна] has banned the use of cryptocurrencies on its territory',
        type: NewsType.negative,
        isAllCrypto: true,
        isScamType: false,
      ),
      _NewsStruct(
        template: 'Создатель криптовалюты [Крипта] [Символ] обрушил курс.',
        templateENG: 'The creator of the cryptocurrency  [Крипта] [Символ] brought down the course.',
        type: NewsType.negative,
        isAllCrypto: true,
        isScamType: false,
      ),
      _NewsStruct(
        template: 'Криптовалюта [Крипта] [Символ] оказалась скамом.',
        templateENG: 'Cryptocurrency [Крипта] [Символ] turned out to be a scam.',
        type: NewsType.negative,
        isAllCrypto: true,
        isScamType: true,
      ),
    ];
    newsTexts.shuffle();
    var newsType = NewsTypeExt.getRandom();
    var newsStruct = newsTexts.firstWhere((element) => element.type == newsType);
    // Scam news can't be while tokens lenght <= 3
    if (_tokenDataProvider.loadData().length <= 3) {
      while (newsStruct.isScamType == true) {
        newsTexts.shuffle();
        newsType = NewsTypeExt.getRandom();
        newsStruct = newsTexts.firstWhere((element) => element.type == newsType);
      }
    } else if (newsStruct.isScamType == true) {
      newsTexts.shuffle();
      newsType = NewsTypeExt.getRandom();
      newsStruct = newsTexts.firstWhere((element) => element.type == newsType);
    }
    final result = _replaceDataInTemplate(newsStruct.template);
    final resultENG = _replaceDataInTemplate(newsStruct.templateENG, true);
    return News(
      text: result['result'] as String,
      textENG: resultENG['result'] as String,
      newsTypeValue: newsType.index,
      tokenID: result['tokenID'] as int?,
      date: dateNow,
      isAllCrypto: newsStruct.isAllCrypto,
      isScamToken: newsStruct.isScamType,
    );
  }

  void createNewsByNewToken(Token token, DateTime date) {
    MusicManager.playNewToken();
    final news = News(
      text: 'Появилась новая криптовалюта ${token.symbol} - ${token.fullName}',
      textENG: 'A new cryptocurrency has appeared ${token.symbol} - ${token.fullName}',
      newsTypeValue: NewsType.neutral.index,
      date: date,
    );
    addNews(news);
  }

  void createNewsByMonthyPayments({required double flat, required double energy, required DateTime date}) {
    final news = News(
      text: 'Оплата жилья: -$flat\$. Оплата энергии: -$energy\$',
      textENG: 'Payment for housing: -$flat\$. Energy payment: -$energy\$',
      newsTypeValue: NewsType.neutral.index,
      date: date,
    );
    addNews(news);
  }
}
