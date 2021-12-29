part of '../wallet_tokens_page.dart';

class _WalletWidget extends StatelessWidget {
  const _WalletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Кошелек криптовалют',
          style: AppFonts.main.copyWith(color: AppColors.white),
        ),
        SizedBox(height: 12),
        _CheckerNullBalancesWidget(),
        SizedBox(height: 12),
        Expanded(child: _AssetsListWidget()),
      ],
    );
  }
}

class _CheckerNullBalancesWidget extends StatelessWidget {
  const _CheckerNullBalancesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppIconsImages.checkboxInactive,
          width: 12,
          height: 12,
        ),
        SizedBox(width: 4),
        Text(
          'Скрыть нулевые балансы',
          style: AppFonts.body.copyWith(color: AppColors.lightGrey),
        ),
      ],
    );
  }
}

class _AssetsListWidget extends StatelessWidget {
  const _AssetsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tokensLenght = context.select((GameCryptoViewModel vm) => vm.state.filtered.length);
    return ListView.separated(
      itemCount: tokensLenght,
      itemBuilder: (_, index) => _AssetsListItemWidget(index: index),
      separatorBuilder: (_, index) => const SizedBox(height: 16),
    );
  }
}

class _AssetsListItemWidget extends StatelessWidget {
  const _AssetsListItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameCryptoViewModel>();
    return GestureDetector(
      onTap: () => vm.onTokenPressed(context, vm.state.filtered[index]),
      child: ColoredBox(
        color: Colors.transparent,
        child: Row(
          children: [
            _AssetsListItemImageWidget(index: index),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _AssetsListItemSymbolWidget(index: index),
                      _AssetsListItemCountWidget(index: index),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _AssetsListItemFullNameWidget(index: index),
                      _AssetsListItemDollarWidget(index: index),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetsListItemImageWidget extends StatelessWidget {
  const _AssetsListItemImageWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.select((GameCryptoViewModel vm) => vm.state.filtered[index]);
    return Image.asset(AppImages.getTokenPathBySymbol(token.symbol), width: 24, height: 24);
  }
}

class _AssetsListItemFullNameWidget extends StatelessWidget {
  const _AssetsListItemFullNameWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.select((GameCryptoViewModel vm) => vm.state.filtered[index]);
    return Text(
      token.fullName,
      style: AppFonts.body.copyWith(color: token.isScam ? AppColors.red : AppColors.lightGrey),
    );
  }
}

class _AssetsListItemSymbolWidget extends StatelessWidget {
  const _AssetsListItemSymbolWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.select((GameCryptoViewModel vm) => vm.state.filtered[index]);
    return Text(
      token.symbol,
      style: AppFonts.main.copyWith(color: token.isScam ? AppColors.red : AppColors.white),
    );
  }
}

class _AssetsListItemCountWidget extends StatelessWidget {
  const _AssetsListItemCountWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    context.select((GameCryptoViewModel vm) => vm.state.filtered[index].count);
    final vm = context.read<GameCryptoViewModel>();
    final token = vm.state.filtered[index];
    final countToken = token.count;

    return Text(
      countToken.toStringAsFixed(8),
      style: AppFonts.mainLight.copyWith(color: token.isScam ? AppColors.red : AppColors.white),
    );
  }
}

class _AssetsListItemDollarWidget extends StatelessWidget {
  const _AssetsListItemDollarWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.read<GameCryptoViewModel>().state.filtered[index];
    final costInDollars = context.select((GameCryptoViewModel vm) => vm.state.getCostByToken(token));

    return Text(
      S.of(context).text_with_dollar(costInDollars.toStringAsFixed(2)),
      style: AppFonts.body.copyWith(color: token.isScam ? AppColors.red : AppColors.white),
    );
  }
}
