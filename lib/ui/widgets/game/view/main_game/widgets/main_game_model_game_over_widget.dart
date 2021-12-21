part of '../new_main_game_page.dart';

class _ModalGameOverWidget extends StatelessWidget {
  const _ModalGameOverWidget({Key? key}) : super(key: key);

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
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Stack(
                  children: [
                    Image.asset(
                      AppImages.gameOverScreen,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ВЫ ПРОИГРАЛИ',
                            style: AppFonts.clicker.copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: 16),
                          WhiteButtonWidget(
                            text: 'В главное меню',
                            onPressed: () {},
                          ),
                          const SizedBox(height: 16),
                          WhiteButtonWidget(
                            text: 'Статистика',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
