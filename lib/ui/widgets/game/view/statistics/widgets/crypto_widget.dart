part of '../game_statistics_page.dart';

class _CryptoWidget extends StatelessWidget {
  const _CryptoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GameStatisticsViewModel>();
    final tokensEarnMap = vm.state.tokenEarn;
    final tokensMiningMap = vm.state.tokenMining;

    final children = <Widget>[];
    for (final token in vm.state.tokens) {
      try {
        final mining = tokensMiningMap[token.id];
        final miningSum = mining!.sum.toStringAsFixed(8);
        final widget = _ItemWidget(
          title: 'Добыто ${token.symbol}',
          value: miningSum,
          symbol: token.symbol,
        );
        children.add(widget);
        children.add(const SizedBox(height: 4));
      } catch (_) {
        final widget = _ItemWidget(title: 'Добыто ${token.symbol}', value: 0.toStringAsFixed(8), symbol: token.symbol);
        children.add(widget);
        children.add(const SizedBox(height: 4));
      }

      try {
        final earns = tokensEarnMap[token.id];
        final earnsSum = earns!.sum.toStringAsFixed(2);
        final widget =
            _ItemWidget(title: 'Продано ${token.symbol} на сумму', value: S.of(context).text_with_dollar(earnsSum));
        children.add(widget);
        children.add(const SizedBox(height: 4));
      } catch (_) {
        final widget = _ItemWidget(
            title: 'Продано ${token.symbol} на сумму', value: S.of(context).text_with_dollar(0.toStringAsFixed(2)));
        children.add(widget);
        children.add(const SizedBox(height: 4));
      }

      children.add(const SizedBox(height: 8));
    }

    // for (final tokenID in tokensMiningMap.keys) {
    //   final mining = tokensMiningMap[tokenID]!.sum;
    //   final tokenSymbol = vm.state.tokenById(tokenID).symbol;
    //   final widget = _ItemWidget(title: 'Добыто $tokenSymbol', value: mining.toStringAsFixed(8));
    //   children.add(widget);
    //   children.add(const SizedBox(height: 4));
    // }
    // for (final tokenID in tokensEarnMap.keys) {
    //   final earns = tokensEarnMap[tokenID]!.sum;
    //   final tokenSymbol = vm.state.tokenById(tokenID).symbol;
    //   final widget = _ItemWidget(
    //       title: 'Продано $tokenSymbol на сумму', value: S.of(context).text_with_dollar(earns.toStringAsFixed(2)));
    //   children.add(widget);
    //   children.add(const SizedBox(height: 4));
    // }
    if (children.isNotEmpty) {
      children.removeLast();
    }
    return Column(
      children: children,
    );
  }
}
