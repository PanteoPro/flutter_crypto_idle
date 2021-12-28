part of '../market_crypto_page.dart';

class _MarketWidget extends StatelessWidget {
  const _MarketWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _MarketBuyWidget(),
        SizedBox(height: 4),
        _MarketSellWidget(),
        SizedBox(height: 8),
      ],
    );
  }
}

class _MarketBuyWidget extends StatelessWidget {
  const _MarketBuyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Покупка',
                    style: AppFonts.main.copyWith(color: AppColors.white),
                  ),
                  const _MarketBuySumDollarWidget(),
                ],
              ),
              const SizedBox(height: 4),
              const _MarketBuySliderWidget(),
              const SizedBox(height: 4),
              const SizedBox(
                width: double.infinity,
                child: _MarketBuySumTokenWidget(),
              ),
            ],
          ),
        ),
        const _MarketBuyButton(),
      ],
    );
  }
}

class _MarketBuyButton extends StatelessWidget {
  const _MarketBuyButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    final value = context.select((GameMarketCryptoViewModel vm) => vm.state.buyVolumeDollar);
    final isActive = value > 0;
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: GameButtonWidget.buy(
        text: 'КУПИТЬ',
        onPressed: isActive ? vm.onBuyNowButtonPressed : null,
        backgroundColor: AppColors.mainGrey,
        textColor: isActive ? AppColors.white : AppColors.grey,
        borderColor: isActive ? AppColors.green : AppColors.grey,
      ),
    );
  }
}

class _MarketBuySliderWidget extends StatelessWidget {
  const _MarketBuySliderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    final value = context.select((GameMarketCryptoViewModel vm) => vm.state.percentBuy);
    return _SliderWidget(
      value: value,
      callback: vm.onChangeSliderBuy,
    );
  }
}

class _MarketBuySumTokenWidget extends StatelessWidget {
  const _MarketBuySumTokenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buyToken2 = context.select((GameMarketCryptoViewModel vm) => vm.state.buyVolumeToken);
    return Text(
      buyToken2.toString(),
      textAlign: TextAlign.right,
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}

class _MarketBuySumDollarWidget extends StatelessWidget {
  const _MarketBuySumDollarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buyDollars = context.select((GameMarketCryptoViewModel vm) => vm.state.buyVolumeDollar);
    return Text(
      S.of(context).text_with_dollar(buyDollars),
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}

class _MarketSellWidget extends StatelessWidget {
  const _MarketSellWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Продажа',
                    style: AppFonts.main.copyWith(color: AppColors.white),
                  ),
                  const _MarketSellSumDollarWidget(),
                ],
              ),
              const SizedBox(height: 4),
              const _MarketSellSliderWidget(),
              const SizedBox(height: 4),
              const SizedBox(
                width: double.infinity,
                child: _MarketSellSumTokenWidget(),
              ),
            ],
          ),
        ),
        const _MarketSellButton(),
      ],
    );
  }
}

class _MarketSellButton extends StatelessWidget {
  const _MarketSellButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    final sellVolume = context.select((GameMarketCryptoViewModel vm) => vm.state.sellVolumeDollar);

    final isActive = sellVolume > 0;
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: GameButtonWidget.buy(
        text: 'ПРОДАТЬ',
        onPressed: isActive ? vm.onSellNowButtonPressed : null,
        backgroundColor: AppColors.mainGrey,
        textColor: isActive ? AppColors.white : AppColors.grey,
        borderColor: isActive ? AppColors.red : AppColors.grey,
      ),
    );
  }
}

class _MarketSellSliderWidget extends StatelessWidget {
  const _MarketSellSliderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<GameMarketCryptoViewModel>();
    final value = context.select((GameMarketCryptoViewModel vm) => vm.state.percentSell);
    return _SliderWidget(
      value: value,
      callback: vm.onChangeSliderSell,
      activeColor: AppColors.red,
      circleColor: AppColors.red,
    );
  }
}

class _MarketSellSumTokenWidget extends StatelessWidget {
  const _MarketSellSumTokenWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sellVolume = context.select((GameMarketCryptoViewModel vm) => vm.state.sellVolumeToken);
    return Text(
      sellVolume.toString(),
      textAlign: TextAlign.right,
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}

class _MarketSellSumDollarWidget extends StatelessWidget {
  const _MarketSellSumDollarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sellVolume = context.select((GameMarketCryptoViewModel vm) => vm.state.sellVolumeDollar);

    return Text(
      S.of(context).text_with_dollar(sellVolume),
      style: AppFonts.body.copyWith(color: AppColors.white),
    );
  }
}

class _SliderWidget extends StatelessWidget {
  const _SliderWidget({
    Key? key,
    required this.value,
    required this.callback,
    this.activeColor = AppColors.green,
    this.circleColor = AppColors.green,
  }) : super(key: key);

  final double value;
  final Function(double) callback;
  final Color activeColor;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      child: SliderTheme(
        data: SliderThemeData(
          trackShape: CustomTrackShape(),
          thumbColor: circleColor,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
          activeTrackColor: activeColor,
          inactiveTrackColor: AppColors.grey,
        ),
        child: Slider(
          value: value,
          onChanged: callback,
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 1;
    final double trackLeft = offset.dx + 10;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 20;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
