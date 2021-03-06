part of '../main_game_page.dart';

class _ModalListTokensWidget extends StatelessWidget {
  const _ModalListTokensWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isShow = context.select((MainGameViewModel vm) => vm.state.isOpenModalTokens);
    if (isShow) {
      return Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: context.read<MainGameViewModel>().onExitModalAction,
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ColoredBox(
                color: AppColors.black50,
              ),
            ),
          ),
          SizedBox(
            height: 380,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.black,
                border: Border.all(color: AppColors.green),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Column(
                  children: const [
                    _ModalHeaderWidget(),
                    Expanded(child: _ModalListWidget()),
                    _ModalFooterWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    return const SizedBox();
  }
}

class _ModalHeaderWidget extends StatelessWidget {
  const _ModalHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pcIndex = context.select((MainGameViewModel vm) => vm.state.modalPCIndex);
    final pc = context.read<MainGameViewModel>().state.myPCs[pcIndex];
    return ColoredBox(
      color: AppColors.secondGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                S.of(context).game_main_modal_tokens_title,
                style: AppFonts.main.copyWith(color: AppColors.white),
              ),
              Text(
                S.of(context).game_main_modal_tokens_sub_title(pc.name),
                style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModalListWidget extends StatefulWidget {
  const _ModalListWidget({Key? key}) : super(key: key);

  @override
  State<_ModalListWidget> createState() => _ModalListWidgetState();
}

class _ModalListWidgetState extends State<_ModalListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final countTokens = context.select((MainGameViewModel vm) => vm.state.tokens.length);
    return ColoredBox(
      color: AppColors.mainGrey,
      child: Padding(
        padding: const EdgeInsets.only(right: 4, top: 10, bottom: 10),
        child: Scrollbar(
          controller: _scrollController,
          isAlwaysShown: true,
          scrollbarOrientation: ScrollbarOrientation.right,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12 - 4,
            ),
            child: ListView.separated(
              controller: _scrollController,
              itemBuilder: (ctx, index) => _ModalListItemWidget(index: index),
              separatorBuilder: (ctx, index) => const SizedBox(height: 16),
              itemCount: countTokens,
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalListItemWidget extends StatelessWidget {
  const _ModalListItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ModalListItemMainWidget(index: index),
        _ModalListItemOtherWidget(index: index),
      ],
    );
  }
}

class _ModalListItemMainWidget extends StatelessWidget {
  const _ModalListItemMainWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainGameViewModel>();
    final isScam = context.select((MainGameViewModel vm) => vm.state.tokens[index].isScam);
    final token = vm.state.tokens[index];
    final isActiveToken = vm.state.isActiveTokenByTokenIndex(index);
    final color = isScam
        ? AppColors.red
        : isActiveToken
            ? AppColors.dollar
            : AppColors.green;

    return SizedBox(
      height: 36,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: color,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 7),
          child: Row(
            children: [
              CircleIndexWidget(
                index: index,
                color: color,
              ),
              const SizedBox(width: 4),
              _ModalListItemMainImageWidget(index: index),
              const SizedBox(width: 4),
              RichText(
                text: TextSpan(
                  text: '${token.fullName} - ',
                  style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
                  children: [
                    TextSpan(
                      text: token.symbol,
                      style: AppFonts.body.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _ModalListItemMainButtonWidget(index: index),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModalListItemMainImageWidget extends StatelessWidget {
  const _ModalListItemMainImageWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.read<MainGameViewModel>().state.tokens[index];
    return Image.asset(
      AppImages.getTokenPathBySymbol(token.symbol),
      width: 28,
      height: 28,
    );
  }
}

class _ModalListItemMainButtonWidget extends StatelessWidget {
  const _ModalListItemMainButtonWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final isScam = context.select((MainGameViewModel vm) => vm.state.tokens[index].isScam);
    final vm = context.read<MainGameViewModel>();
    final isActiveToken = vm.state.isActiveTokenByTokenIndex(index);

    VoidCallback? onPressed;
    if (!isScam) {
      onPressed = () => vm.onChangeMiningToken(index);
    }

    return GameButtonWidget.tokenSelect(
      onPressed: onPressed,
      text: isScam
          ? S.of(context).game_main_modal_tokens_button_scam
          : isActiveToken
              ? S.of(context).game_main_modal_tokens_button_active
              : S.of(context).game_main_modal_tokens_button_select,
      borderColor: isScam
          ? AppColors.red
          : isActiveToken
              ? AppColors.dollar
              : AppColors.green,
      backgroundColor: isActiveToken ? AppColors.dollar : AppColors.mainGrey,
    );
  }
}

class _ModalListItemOtherWidget extends StatelessWidget {
  const _ModalListItemOtherWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainGameViewModel>();
    final isScam = context.select((MainGameViewModel vm) => vm.state.tokens[index].isScam);
    final isActiveToken = vm.state.isActiveTokenByTokenIndex(index);

    final color = isScam
        ? AppColors.red
        : isActiveToken
            ? AppColors.dollar
            : AppColors.green;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 30,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: color),
              right: BorderSide(color: color),
              bottom: BorderSide(color: color),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ModalListItemOtherCurrentPriceWidget(index: index),
                if (!isScam) _ModalListItemOtherMonthPriceWidget(index: index),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalListItemOtherCurrentPriceWidget extends StatelessWidget {
  const _ModalListItemOtherCurrentPriceWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.read<MainGameViewModel>().state.tokens[index];
    final currentPrice = context.select((MainGameViewModel vm) => vm.state.getCurrentPriceByToken(token));
    final text = currentPrice.cost > 1 ? currentPrice.cost.toStringAsFixed(2) : currentPrice.cost.toStringAsFixed(4);
    return Text(
      '${S.of(context).game_main_modal_tokens_info_current_cost}: ${S.of(context).text_with_dollar(text)}',
      style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
    );
  }
}

class _ModalListItemOtherMonthPriceWidget extends StatelessWidget {
  const _ModalListItemOtherMonthPriceWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final token = context.read<MainGameViewModel>().state.tokens[index];
    final monthPrice =
        context.select((MainGameViewModel vm) => vm.state.getDataAfterPriceByToken(token: token, daysAgo: 31));
    final text = monthPrice.cost > 1 ? monthPrice.cost.toStringAsFixed(2) : monthPrice.cost.toStringAsFixed(4);
    return Text(
      '${S.of(context).game_main_modal_tokens_info_month_cost}: ${S.of(context).text_with_dollar(text)}',
      style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
    );
  }
}

class _ModalFooterWidget extends StatelessWidget {
  const _ModalFooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainGameViewModel>();
    return ColoredBox(
      color: AppColors.secondGrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Center(
          child: GameButtonWidget.tokenSelect(
            text: S.of(context).game_main_modal_tokens_exit,
            onPressed: vm.onExitModalAction,
            font: AppFonts.main,
            backgroundColor: AppColors.secondGrey,
          ),
        ),
      ),
    );
  }
}
