part of '../new_main_game_page.dart';

class _ModalExitWidget extends StatelessWidget {
  const _ModalExitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  WhiteButtonWidget(
                    text: 'Да',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  WhiteButtonWidget(
                    text: 'Нет',
                    onPressed: () {},
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
