part of '../new_main_game_page.dart';

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).canvasColor,
      child: Column(
        children: const [
          _BalanceWidget(),
          _NewsWidget(),
        ],
      ),
    );
  }
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _BalanceCashWidget(),
              SizedBox(height: 4),
              _BalanceCryptoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceCashWidget extends StatelessWidget {
  const _BalanceCashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppImages.iconCash,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 4),
        const _BalanceCashTextWidget(),
      ],
    );
  }
}

class _BalanceCashTextWidget extends StatelessWidget {
  const _BalanceCashTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final money = context.select((MainGameViewModel vm) => vm.state.money);
    return Text(
      '${S.of(context).main_game_cash_balance_title}: ${S.of(context).text_with_dollar(money)}',
      style: Theme.of(context).textTheme.headline3,
    );
  }
}

class _BalanceCryptoWidget extends StatelessWidget {
  const _BalanceCryptoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppImages.iconToken,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 4),
        const _BalanceCryptoTextWidget(),
      ],
    );
  }
}

class _BalanceCryptoTextWidget extends StatelessWidget {
  const _BalanceCryptoTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cryptoBalance = context.select((MainGameViewModel vm) => vm.state.cryptoBalance);
    return Text(
      '${S.of(context).main_game_crypto_balance_title}: ${S.of(context).text_with_dollar(cryptoBalance)}',
      style: Theme.of(context).textTheme.headline3,
    );
  }
}

class _NewsWidget extends StatelessWidget {
  const _NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).primaryColor,
      child: SizedBox(
        child: Column(
          children: [
            ColoredBox(
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Text(
                          'Новости:',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: _NewsFirstNewsWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsFirstNewsWidget extends StatelessWidget {
  const _NewsFirstNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final news = context.select((DayStreamViewModel vm) => vm.newsListToDisplay);
    final newsText = news.isEmpty ? '' : news.first.text;
    return Text(
      newsText,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
