import 'dart:async';
import 'dart:math';

import 'package:crypto_idle/domain/data_providers/news_data_provider.dart';
import 'package:crypto_idle/domain/data_providers/price_token_data_provider.dart';
import 'package:crypto_idle/domain/data_providers/token_data_provider.dart';
import 'package:crypto_idle/domain/entities/news.dart';
import 'package:crypto_idle/domain/entities/price_token.dart';
import 'package:crypto_idle/domain/entities/token.dart';
import 'package:crypto_idle/domain/repositories/my_repository.dart';
import 'package:crypto_idle/initial_data.dart';

class _NewsStruct {
  _NewsStruct({
    required this.template,
    required this.type,
    required this.isAllCrypto,
    required this.isScamType,
    this.token,
  });

  final String template;
  final NewsType type;
  final Token? token;
  final bool isAllCrypto;
  final bool isScamType;
}

enum NewsType { positive, neutral, negative }

extension NewsTypeExt on NewsType {
  static NewsType getRandom() {
    var value = Random().nextInt(NewsType.values.length);
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

  static final Map<String, String> tokenNames = InitialDataNames.namesCrypto;
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
    await updateData();
    stream ??= _streamController.stream.asBroadcastStream();
  }

  @override
  Future<void> updateData() async {
    _news = await _newsDataProvider.loadData();
  }

  Future<void> addNews(News news) async {
    await _newsDataProvider.saveData(news);
    _streamController.add('Add News');
  }

  // Get new if dateNow after lastGeneratedDate + waitDays
  bool createNews(DateTime dateNow) {
    final dayBefore = dateNow.add(const Duration(days: -1));
    if (dateNow.isAfter(lastGenerated?.add(Duration(days: countWaitDays ?? 0)) ?? dayBefore)) {
      countWaitDays = _NewsRepositoryParams.minWaitDayDelay +
          Random().nextInt(_NewsRepositoryParams.maxWaitDayDelay - _NewsRepositoryParams.minWaitDayDelay);
      // countWaitDays = 0;
      print('wait days $countWaitDays');
      lastGenerated = dateNow;
      final news = _generateNews(dateNow);
      addNews(news);
      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> _replaceDataInTemplate(String template) {
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
    Token? token = isHaveSymbol || isHaveCrypto ? availableTokens.first : null;
    String result = template;

    if (isHaveCountry) {
      final countryNames = _NewsRepositoryParams.countryNames;
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
      final peopleNames = _NewsRepositoryParams.peopleNames;
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
        type: NewsType.positive,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: 'Президент [Страна] ретвитнул обновление [Символ].',
        type: NewsType.positive,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: '[Компания] начала принимать [Символ].',
        type: NewsType.positive,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: '[Известная личность] закупил [Символ].',
        type: NewsType.neutral,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: '[Известная личность] продал [Символ].',
        type: NewsType.neutral,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: '[Известная личность] обвинил [Крипта] [Символ] в мошеничестве.',
        type: NewsType.neutral,
        isAllCrypto: false,
        isScamType: false,
      ),
      _NewsStruct(
        template: 'Страна [Страна] запретила использование криптовалют на своей территории',
        type: NewsType.negative,
        isAllCrypto: true,
        isScamType: false,
      ),
      _NewsStruct(
        template: 'Создатель криптовалюты [Крипта] [Символ] обрушил курс.',
        type: NewsType.negative,
        isAllCrypto: true,
        isScamType: false,
      ),
      _NewsStruct(
        template: 'Криптовалюта [Крипта] [Символ] оказалась скамом.',
        type: NewsType.negative,
        isAllCrypto: true,
        isScamType: true,
      ),
    ];
    newsTexts.shuffle();
    var newsType = NewsTypeExt.getRandom();
    var newsStruct = newsTexts.firstWhere((element) => element.type == newsType);
    if (newsStruct.isScamType == true) {
      print('ReTake, but scam');
      newsTexts.shuffle();
      newsType = NewsTypeExt.getRandom();
      newsStruct = newsTexts.firstWhere((element) => element.type == newsType);
    }
    final result = _replaceDataInTemplate(newsStruct.template);
    return News(
      text: result['result'] as String,
      newsTypeValue: newsType.index,
      tokenID: result['tokenID'] as int?,
      date: dateNow,
      isAllCrypto: newsStruct.isAllCrypto,
      isScamToken: newsStruct.isScamType,
    );
  }
}
