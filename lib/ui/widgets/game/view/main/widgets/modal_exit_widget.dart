part of '../main_game_page.dart';

class _ModalExitWidget extends StatelessWidget {
  const _ModalExitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isModalShow = context.select((MainGameViewModel vm) => vm.state.isModalExitShow);
    final vm = context.read<MainGameViewModel>();
    if (!isModalShow) return const SizedBox();
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: vm.onNoExitButtonPressed,
          child: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ColoredBox(
              color: AppColors.black50,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.black,
              border: Border.all(color: AppColors.green),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).game_main_modal_exit_title,
                    textAlign: TextAlign.center,
                    style: AppFonts.clicker.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 16),
                  GameButtonWidget.white(
                    text: S.of(context).game_main_modal_exit_yes,
                    onPressed: () => vm.onYesExitButtonPressed(context),
                  ),
                  const SizedBox(height: 16),
                  GameButtonWidget.white(
                    text: S.of(context).game_main_modal_exit_no,
                    onPressed: vm.onNoExitButtonPressed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
