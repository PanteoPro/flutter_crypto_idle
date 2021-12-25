part of '../main_game_page.dart';

class _ModalExitWidget extends StatelessWidget {
  const _ModalExitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isModalShow = context.select((MainGameViewModel vm) => vm.state.isModalExitShow);
    final vm = context.read<MainGameViewModel>();
    if (!isModalShow) return const SizedBox();
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ColoredBox(
        color: AppColors.black50,
        child: Center(
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.black,
                border: Border.all(color: AppColors.green),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Вы точно хотите выйти в меню?',
                    style: AppFonts.clicker.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 16),
                  GameButtonWidget.white(
                    text: 'Да',
                    onPressed: () => vm.onYesExitButtonPressed(context),
                  ),
                  const SizedBox(height: 16),
                  GameButtonWidget.white(
                    text: 'Нет',
                    onPressed: vm.onNoExitButtonPressed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
