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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
          AppIconsImages.cashIcon,
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
    return RichText(
      text: TextSpan(
        text: '${S.of(context).main_game_cash_balance_title}: ',
        style: AppFonts.main,
        children: [
          TextSpan(
            text: S.of(context).text_with_dollar(money),
            style: AppFonts.mainLight.copyWith(color: AppColors.white),
          ),
        ],
      ),
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
          AppIconsImages.tokenIcon,
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
    return RichText(
      text: TextSpan(
        text: '${S.of(context).main_game_crypto_balance_title}: ',
        style: AppFonts.main,
        children: [
          TextSpan(
            text: S.of(context).text_with_dollar(cryptoBalance),
            style: AppFonts.mainLight.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class _NewsWidget extends StatelessWidget {
  const _NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.secondGrey,
      child: SizedBox(
        height: 40,
        child: Column(
          children: [
            ColoredBox(
              color: AppColors.secondGrey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _NewsLeftRowWidget(),
                    SizedBox(width: 6),
                    Expanded(
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

class _NewsLeftRowWidget extends StatelessWidget {
  const _NewsLeftRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainGameViewModel>();
    final isShowNews = context.select((MainGameViewModel vm) => vm.state.isShowNews);

    return GestureDetector(
      onTap: vm.onShowNewsButtonPressed,
      child: SizedBox(
        height: 40,
        child: Column(
          children: [
            Text(
              'Новости:',
              style: AppFonts.main.copyWith(color: AppColors.green),
            ),
            Expanded(
              child: AnimatedRotation(
                turns: isShowNews ? 0.5 : 0,
                duration: Duration(milliseconds: isShowNews ? 500 : 200),
                child: Image.asset(
                  AppIconsImages.downIcon,
                  width: 19,
                  height: 19,
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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        key: ValueKey(newsText),
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                newsText,
                maxLines: 2,
                style: AppFonts.mainLight.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
