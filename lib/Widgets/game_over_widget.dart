import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/buttons/white_button_widget.dart';
import 'package:crypto_idle/resources/app_images.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ModalGameOverWidget extends StatelessWidget {
  const ModalGameOverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameOver = context.select((GameViewModel vm) => vm.state.gameOver);
    final isModalGameOverClose = context.select((GameViewModel vm) => vm.state.isModalGameOverClose);
    final vm = context.read<GameViewModel>();
    if (gameOver && !isModalGameOverClose) {
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
                              onPressed: () => vm.onExitGameOverPressed(context),
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
    return const SizedBox();
  }
}
