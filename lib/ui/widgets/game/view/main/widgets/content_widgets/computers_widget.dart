part of '../../main_game_page.dart';

class _ComputersWidget extends StatefulWidget {
  const _ComputersWidget({Key? key}) : super(key: key);

  @override
  State<_ComputersWidget> createState() => _ComputersWidgetState();
}

class _ComputersWidgetState extends State<_ComputersWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final countPC = context.select((MainGameViewModel vm) => vm.state.myPCs.length);

    const heightItemComp = 36;
    const heightSizedBox = 10;
    var height = 0.0;
    if (countPC > 0) {
      final count = min(countPC, 3);
      height += count * heightItemComp + (count - 1) * heightSizedBox + 2 * heightSizedBox;
    }

    return AnimatedContainer(
      width: double.infinity,
      height: height,
      alignment: Alignment.center,
      duration: const Duration(seconds: 3),
      curve: Curves.fastOutSlowIn,
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: ColoredBox(
          color: AppColors.black50,
          child: Padding(
            padding: const EdgeInsets.only(right: 1, top: 10, bottom: 10),
            child: Scrollbar(
              isAlwaysShown: true,
              controller: _scrollController,
              scrollbarOrientation: ScrollbarOrientation.right,
              child: ListView.separated(
                controller: _scrollController,
                itemCount: countPC,
                itemBuilder: (context, index) {
                  return _ComputerItemWidget(index: index);
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox(height: 10);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ComputerItemWidget extends StatelessWidget {
  const _ComputerItemWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainGameViewModel>();
    final pc = vm.state.myPCs[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: () => vm.onOpenModalButtonPressed(index),
        child: SizedBox(
          height: 36,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppColors.green),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                children: [
                  CircleIndexWidget(index: index),
                  const SizedBox(width: 4),
                  Image.asset(
                    AppImages.getPcPathByName(pc.name),
                    width: 28,
                    height: 28,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    pc.name,
                    style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
                  ),
                  const Spacer(),
                  __ComputerItemImageCryptoWidget(index: index),
                  const SizedBox(width: 4),
                  __ComputerItemButtonOrMiningWidget(index: index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class __ComputerItemImageCryptoWidget extends StatelessWidget {
  const __ComputerItemImageCryptoWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    context.select((MainGameViewModel vm) => vm.state.pcByIndex(index)?.miningToken);
    final pc = context.read<MainGameViewModel>().state.myPCs[index];

    final imagePath =
        pc.miningToken == null ? AppIconsImages.emptyIcon : AppImages.getTokenPathBySymbol(pc.miningToken!.symbol);
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(imagePath == AppIconsImages.emptyIcon ? pi : 0),
      child: Image.asset(
        imagePath,
        width: 28,
        height: 28,
      ),
    );
  }
}

class __ComputerItemButtonOrMiningWidget extends StatelessWidget {
  const __ComputerItemButtonOrMiningWidget({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    context.select((MainGameViewModel vm) => vm.state.pcByIndex(index)?.miningToken);
    final vm = context.read<MainGameViewModel>();
    final pc = vm.state.myPCs[index];

    return SizedBox(
      width: 120,
      child: TextButton(
        onPressed: () => vm.onOpenModalButtonPressed(index),
        child: Text(
          pc.miningToken != null ? 'Майнится: ${pc.miningToken?.symbol}' : 'НАЗНАЧИТЬ',
          textAlign: TextAlign.center,
          maxLines: 1,
          style: AppFonts.mainPagePc.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
